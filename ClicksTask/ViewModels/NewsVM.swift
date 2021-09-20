//
//  NewsVM.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 27/08/2021.
//

import UIKit

protocol NewsVMProtocol: ViewModelWithPaginationProtocol, PaginationChild {
    func articlesFiltration(keyWords: String?)
    func getDataListCount() -> Int
    func scrollObserve(cellCount: Int)
    func getCellData(indexPath: IndexPath) -> Article
    func getClickedArticle(in index: Int) -> Article
}

class NewsVM<T: NewsVCProtocol>: ViewModelWithPagination<T>, NewsVMProtocol {
    
    internal var filteredArticles  = [Article]()
    internal var isSearching: Bool = false
    
    //Init
    override init(view: T) {
        super.init(view: view)
        super.child = self
    }
    
    // Calling API USing Alamofire to retrieve News Articles
    internal func getData() {
        view?.showLoadingView()
        APIManager.shared().getNews(page: page) { [weak self] (result: Result<BaseResponse<Article>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.dataList.append(contentsOf: data.articles)
                print(data.totalResults)
                self.isHasMorePages(resultCount: data.totalResults)
                self.page += 1
                self.view?.updateData(on: self.dataList as! [Article])
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
            view?.updateData(on: dataList as! [Article])
            isSearching = false
            return
        }
        filteredArticles = (dataList as! [Article]).filter  { $0.title.lowercased().contains(filter.lowercased()) }
        view?.updateData(on: filteredArticles)
        isSearching = true
    }
    
    internal func getClickedArticle(in index: Int) -> Article {
        return isSearching ? filteredArticles[index] : (dataList[index] as! Article)
    }
    
    internal func getCellData(indexPath: IndexPath) -> Article {
        return dataList[indexPath.row] as! Article
    }
}


protocol ViewControllerWithReachabilityProtocol: AnyObject {
    
    func showNoConnection()
    func hideNoConnection()
}

protocol ViewControllerWithPagination: AnyObject  {
    
}

protocol newsViewControllerProtocol: ViewControllerWithReachabilityProtocol, ViewControllerWithPagination  {
    
}


