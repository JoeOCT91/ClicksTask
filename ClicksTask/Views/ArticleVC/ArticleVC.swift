//
//  ArticleVCViewController.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 29/08/2021.
//

import UIKit

protocol ArticleVCProtocol: AnyObject {
    func setViewData(article: Article)
}

class ArticleVC: UIViewController {
    
    //Outlets
    @IBOutlet var articleView: ArticleView!
    
    //ViewModel property
    private var viewModel: ArticleVMProtocol!
    
    //Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        articleView.setupView()
        configureNavBar()
        viewModel.getViewData()
    }
    
    private func configureNavBar(){
        let shareSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
        let shareIcon = UIImage(systemName: "square.and.arrow.up", withConfiguration: shareSymbolConfiguration)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: sha, style: UIBarButtonItem.Style, target: .self, action: #selector(addTapped))

    }
    
    @objc func addTapped(){
        
    }

    
//MARK:- Public Methods
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
