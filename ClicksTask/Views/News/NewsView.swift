//
//  NewsView.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 26/08/2021.
//

import UIKit

class NewsView: UIView {
    
    private weak var VCReference: NewsVC!

    //Outlets
    var collectionView: UICollectionView!
    var searchController: UISearchController!
    
    //Order is needed in this function
    func setupView(vcReference: NewsVC) {
        self.VCReference = vcReference
        configureCollectionView()
        configureSearchController()
        collectionView.delegate = vcReference
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createFlowLayout())
        self.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ColorName.bgGray.color
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.reuseID)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let width = self.bounds.width
        let padding: CGFloat = 25
        let availableWidth = width - (padding * 2)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.itemSize = CGSize(width: itemWidth, height: 275)
        return flowLayout
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = VCReference
        searchController.searchBar.placeholder = L10n.searchForAnArticle
        searchController.obscuresBackgroundDuringPresentation = false // removes light overlay on results below
        VCReference.navigationItem.searchController = searchController
    }
}
