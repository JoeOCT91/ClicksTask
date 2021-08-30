//
//  NewsVM.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 27/08/2021.
//

import Foundation

protocol NewsVMProtocol: class {
    func getNews()
    func articlesFiltration(keyWords: String?)
    func getDataListCount() -> Int
    func scrollObserve(cellCount: Int)
    func getCellData(indexPath: IndexPath) -> Article
    func getClickedArticle(in index: Int) -> Article
}

class NewsVM: NewsVMProtocol {
    
    //View Weak Refrence to update UI
    private weak var view: NewsVCProtocol?
    
    //Pagination proprties
    internal var page = 1
    internal var hasMorePages = true
    
    //Data and filteration proprties
    internal var articlesList = [Article]()
    internal var filteredArticles  = [Article]()
    internal var isSearching: Bool = false
    
    //Init
    init(view: NewsVCProtocol) {
        self.view = view
    }
    
    // Calling API USing Alamofire to retrive News Articles
    internal func getNews() {
        view?.showLoadingView()
        APIManager.shared().getNews(page: page) { [weak self] (result: Result<BaseResponse<Article>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.articlesList.append(contentsOf: data.articles)
                self.isHasMorePages(resultCount: data.totalResults)
                self.page += 1
                self.view?.updateData(on: self.articlesList)
                self.view?.dismissLoadingView()
            case .failure(let error):
                self.view?.dismissLoadingView()
                print(error)
            }
        }
    }
    
    internal func articlesFiltration(keyWords: String?){
        guard let filter = keyWords, filter.isEmpty == false else {
            filteredArticles.removeAll()
            view?.updateData(on: articlesList)
            isSearching = false
            return
        }
        filteredArticles = articlesList.filter { $0.title.lowercased().contains(filter.lowercased()) }
        view?.updateData(on: filteredArticles)
        isSearching = true
    }
    internal func getClickedArticle(in index: Int) -> Article {
        return isSearching ? filteredArticles[index] : articlesList[index]
    }
    
    internal func getDataListCount() -> Int {
        return articlesList.count
    }
    
    internal func getCellData(indexPath: IndexPath) -> Article {
        return articlesList[indexPath.row]
    }
    
    internal func scrollObserve(cellCount: Int){
        if didScrollToEnd(cellCount: cellCount) && hasMorePages {
            self.getNews()
        }
    }
    
    private func didScrollToEnd(cellCount: Int) -> Bool {
        return cellCount + 1  == articlesList.count ? true : false
    }
    
    //To terminate how many pages will retrieve from the API
    internal func isHasMorePages(resultCount: Int) {
        var numberOfPages: Int
        numberOfPages = (resultCount / 20)
        (resultCount % 20) != 0 ? (numberOfPages += 1) : (numberOfPages = numberOfPages)
        resultCount > page ? (hasMorePages = true) : (hasMorePages = false)
    }
}
