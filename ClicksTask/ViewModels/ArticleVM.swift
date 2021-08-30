//
//  ArticleVM.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 29/08/2021.
//

import Foundation

protocol ArticleVMProtocol: class {
    func getViewData()
}

class ArticleVM: ArticleVMProtocol {
    
    //View Weak Reference to update UI
    private weak var view: ArticleVCProtocol!
    
    //Properties
    private let article: Article
    
    //Init
    init(view: ArticleVCProtocol, article: Article) {
        self.view = view
        self.article = article
    }
    
    internal func getViewData() {
        view.setViewData(article: article)
    }
}
