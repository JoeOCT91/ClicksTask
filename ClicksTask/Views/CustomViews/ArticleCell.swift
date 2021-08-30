//
//  ArticalCell.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 27/08/2021.
//

import UIKit

@objc protocol ArticleCellDelgate: class {
    func shareArticleLink(url: String)
}

class ArticleCell: UICollectionViewCell {
    
    //Cell Delgate property
    weak var delgate: ArticleCellDelgate?
    
    static let reuseID = "ArticalCell"
    
    private let container = UIView(frame: .zero)
    private let articleImageView = ArticleImageView(frame: .zero)
    private let articleSourceLabel = ArticleLable(fontSize: 10, font: UIFont(font: FontFamily.Cairo.regular, size: 10))
    private let articleTitleLable = ArticleLable(fontSize: 12, font: UIFont(font: FontFamily.Cairo.bold, size: 12))
    private let shareButton = UIButton(frame: .zero)
    
    private var articleUrl = String()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        articleSourceLabel.text = article.source?.name
        articleTitleLable.text = article.title
        articleImageView.downloadImage(fromURL: article.urlToImage)
        articleUrl = article.url
    }
    
    private func configureCell(){
        contentView.addSubview(container)
        container.addSubview(articleImageView)
        container.addSubview(articleSourceLabel)
        container.addSubview(articleTitleLable)
        container.addSubview(shareButton)
        
        configureContainer()
        configureArticaleImageView()
        configureSourceLable()
        configureArticleTitleLable()
        configureShareButton()
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
        articleSourceLabel.numberOfLines = 1
        articleSourceLabel.textColor = ColorName.sourceMainColor.color
        NSLayoutConstraint.activate([
            articleSourceLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 12),
            articleSourceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            articleSourceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            articleSourceLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureArticleTitleLable() {
        articleTitleLable.numberOfLines = 2
        articleTitleLable.textColor = ColorName.titleColor.color
        NSLayoutConstraint.activate([
            articleTitleLable.topAnchor.constraint(equalTo: articleSourceLabel.bottomAnchor),
            articleTitleLable.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            articleTitleLable.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            articleTitleLable.heightAnchor.constraint(equalToConstant: 45)
        ])
        articleTitleLable.adjustsFontSizeToFitWidth = true // shrink a bit to try to fit into the label
        articleTitleLable.lineBreakMode = .byWordWrapping
    }
    
    private func configureShareButton() {
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.heightAnchor.constraint(equalToConstant: 25),
            shareButton.widthAnchor.constraint(equalToConstant: 25),
            shareButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            shareButton.centerYAnchor.constraint(equalTo: articleSourceLabel.centerYAnchor)
        ])
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: homeSymbolConfiguration)
        shareButton.setImage(image, for: .normal)
        shareButton.tintColor = UIColor(hexString: "#BBBBBB")
    }
    
    @objc private func shareButtonPressed(){
        delgate?.shareArticleLink(url: articleUrl)
    }
}
