//
//  ArticalCell.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 27/08/2021.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    static let reuseID = "ArticalCell"
    
    private let container = UIView(frame: .zero)
    private let articleImageView = ArticleImageView(frame: .zero)
    private let articleSourceLable = ArticleLable(fontSize: 10, font: UIFont(font: FontFamily.Cairo.regular, size: 10))
    private let articleTitleLable = ArticleLable(fontSize: 12, font: UIFont(font: FontFamily.Cairo.bold, size: 12))
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        articleSourceLable.text = article.source?.name
        articleTitleLable.text = article.title
        articleImageView.downloadImage(fromURL: article.urlToImage)
    }
    
    private func configureCell(){
        contentView.addSubview(container)
        container.addSubview(articleImageView)
        container.addSubview(articleSourceLable)
        container.addSubview(articleTitleLable)
        
        configureContainer()
        configureArticaleImageView()
        configureSourceLable()
        configureArticleTitleLable()
    }
    
    // Configuration for the container of all cell views
    private func configureContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        container.backgroundColor = ColorName.cellBackGround.color
        container.layer.cornerRadius = 20
        container.layer.shadowColor = UIColor(hexString: "#000000").cgColor
        container.layer.shadowOffset = CGSize(width: 2, height: 2)
        container.layer.shadowRadius = 20
        container.layer.shadowOpacity = 0.16

    }
    
    // Configuration for Artical image View
    private func configureArticaleImageView() {
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.clipsToBounds = false
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            articleImageView.topAnchor.constraint(equalTo: container.topAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 175)
        ])

    }
    
    // Configuration for Artical source View
    private func configureSourceLable() {
        articleSourceLable.numberOfLines = 1
        articleSourceLable.textColor = ColorName.sourceMainColor.color
        NSLayoutConstraint.activate([
            articleSourceLable.topAnchor.constraint(equalTo: articleImageView.bottomAnchor),
            articleSourceLable.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            articleSourceLable.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            articleSourceLable.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureArticleTitleLable() {
        articleTitleLable.numberOfLines = 2
        articleTitleLable.textColor = ColorName.titleColor.color
        NSLayoutConstraint.activate([
            articleTitleLable.topAnchor.constraint(equalTo: articleSourceLable.bottomAnchor),
            articleTitleLable.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            articleTitleLable.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            articleTitleLable.heightAnchor.constraint(equalToConstant: 65)
        ])
        articleTitleLable.adjustsFontSizeToFitWidth = true // shrink a bit to try to fit into the label
        articleTitleLable.lineBreakMode = .byWordWrapping
    }
}
