//
//  ArticleVCViewController.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 29/08/2021.
//

import UIKit

protocol ArticleVCProtocol: class {
    func setViewData(article: Article)
}

class ArticleVC: UIViewController {
    
    //Outlets
    @IBOutlet var articleView: ArticleView!
    
    //ViewModel
    private var viewModel: ArticleVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        articleView.setupView()
        viewModel.getViewData()
    }
    
    class func create(article: Article) -> ArticleVC {
        let articleVC: ArticleVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.articleVC)
        let viewModel = ArticleVM(view: articleVC, article: article)
        articleVC.viewModel = viewModel
        return articleVC
    }
}
extension ArticleVC: ArticleVCProtocol {
    internal func setViewData(article: Article) {
        articleView.setData(with: article)
    }
}
