//
//  ArticleView.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 29/08/2021.
//

import UIKit

class ArticleView: UIView {
    
    //Views
    let articleImage = ArticleImageView(frame: .zero)
    let articleTopBorder = UIView(frame: .zero)
    let articleContainer = UIView(frame: .zero)
    let articleTitle = ArticleLable (fontSize: 11, font: UIFont(font: FontFamily.Cairo.bold, size: 11))
    let articleSource = ArticleLable (fontSize: 11, font: UIFont(font: FontFamily.Cairo.bold, size: 11))
    let articleContent = ArticleLable (fontSize: 11, font: UIFont(font: FontFamily.Cairo.regular, size: 15))
    
    //Order is needed in this function
    func setupView() {
        configureArticleViews()
    }
    
    func setData(with article: Article){
        articleSource.text = article.source?.name
        articleContent.text = article.articleDescription
        articleTitle.text = article.title
        articleImage.downloadImage(fromURL: article.urlToImage)
    }
    
    private func configureArticleViews() {
        self.backgroundColor = ColorName.bgGray.color
        self.addSubview(articleImage)
        self.addSubview(articleTopBorder)
        self.addSubview(articleContainer)
        articleContainer.addSubview(articleSource)
        articleContainer.addSubview(articleTitle)
        articleContainer.addSubview(articleContent)
        configureAtricalImage()
        configureArticleTopBorder()
        configureArticleContainer()
        configureArticleSource()
        configureArticelTitle()
        configureArticelContent()
    }
    
    private func configureAtricalImage() {
        articleImage.image = Asset.imagePlaceHolder.image
        articleImage.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            articleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            articleImage.heightAnchor.constraint(equalToConstant: 290)
        ])
    }
    
    private func configureArticleTopBorder() {
        articleTopBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTopBorder.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: -25),
            articleTopBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            articleTopBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            articleTopBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        articleTopBorder.backgroundColor = ColorName.naveyBlue.color
        articleTopBorder.layer.cornerRadius = 25
    }
    	
    private func configureArticleContainer() {
        articleContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleContainer.topAnchor.constraint(equalTo: articleTopBorder.topAnchor, constant: 12),
            articleContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            articleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            articleContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        articleContainer.backgroundColor = ColorName.bgGray.color
        articleContainer.layer.cornerRadius = 25
    }
    
    private func configureArticleSource() {
        articleSource.numberOfLines = 1
        NSLayoutConstraint.activate([
            articleSource.topAnchor.constraint(equalTo: articleContainer.topAnchor, constant: 12),
            articleSource.leadingAnchor.constraint(equalTo: articleContainer.leadingAnchor, constant: 12),
            articleSource.trailingAnchor.constraint(equalTo: articleContainer.trailingAnchor, constant: -25),
        ])
    }
    
    private func configureArticelTitle() {
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: articleSource.bottomAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: articleContainer.leadingAnchor, constant: 24),
            articleTitle.trailingAnchor.constraint(equalTo: articleSource.trailingAnchor)
        ])
        articleTitle.numberOfLines = 2
    }
    
    private func configureArticelContent() {
        NSLayoutConstraint.activate([
            articleContent.topAnchor.constraint(equalTo: articleTitle.bottomAnchor),
            articleContent.leadingAnchor.constraint(equalTo: articleContainer.leadingAnchor, constant: 24),
            articleContent.trailingAnchor.constraint(equalTo: articleContainer.trailingAnchor, constant: -50),
        ])
    }
}
