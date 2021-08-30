//
//  ViewController.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 26/08/2021.
//

import UIKit

protocol NewsVCProtocol: class {
    func updateData(on followers: [Article])
    func showLoadingView()
    func dismissLoadingView ()
    func showEmptyStateView(with message: String, in view: UIView)
}

class NewsVC: DataLoadingVC {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Article>!
    
    //Outlets
    @IBOutlet var newsView: NewsView!
    
    //ViewModel
    private var viewModel: NewsVMProtocol!
    
    //ViewController Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsView.setupView(vcReference: self)
        configureDataSource()
        configureViewController()
        self.viewModel.getNews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        //        view.backgroundColor = .systemBackground
        //        //navigationController?.navigationBar.prefersLargeTitles = true
        //
        //        let addButton = UIBarButtonItem(
        //        (barButtonSystemItem: ", target: self, action: #selector(addButtonTapped))
        //        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        print("Tapped")
    }
    
    // MARK:- Public Methods
    
    class func create() -> NewsVC {
        let newsVC: NewsVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.newsVC)
        let viewModel = NewsVM(view: newsVC)
        newsVC.viewModel = viewModel
        return newsVC
    }
    
}

extension NewsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getDataListCount()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.scrollObserve(cellCount: indexPath.row)
    }
    // to know when  collection view item is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.getClickedArticle(in: indexPath.row)
        let articleVC = ArticleVC.create(article: article)
        self.navigationController?.pushViewController(articleVC, animated: true)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Article>(collectionView: newsView.collectionView,cellProvider: { [weak self] (collectionView, indexPath,follower) -> UICollectionViewCell? in
            guard let self = self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.reuseID, for: indexPath) as? ArticleCell
            cell?.set(article: (self.viewModel.getCellData(indexPath: indexPath)))
            cell?.delgate = self
            return cell
        })
    }
}

extension NewsVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.articlesFiltration(keyWords: searchController.searchBar.text)
    }
}

extension NewsVC: NewsVCProtocol {
    
    //use to populate collectionView with its cells depend on data sent from ViewModel
    func updateData(on articles: [Article]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(articles)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
extension NewsVC: ArticleCellDelegate {

    func shareArticleLink(url: String) {
        // Setting description
        let textToShare = "Share article Link.."
        // Setting url
        if let articleUrl = URL(string: url) {
            
            let objectsToShare = [textToShare, articleUrl] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop,
                                                UIActivity.ActivityType.addToReadingList,
                                                UIActivity.ActivityType.postToFacebook,
                                                UIActivity.ActivityType.postToWeibo,
                                                UIActivity.ActivityType.print,
                                                UIActivity.ActivityType.assignToContact,
                                                UIActivity.ActivityType.saveToCameraRoll,
                                                UIActivity.ActivityType.addToReadingList,
                                                UIActivity.ActivityType.postToFlickr,
                                                UIActivity.ActivityType.postToVimeo,
                                                UIActivity.ActivityType.postToTencentWeibo]
            
            activityVC.isModalInPresentation = true
            self.present(activityVC, animated: true, completion: nil)
        }
    
    }
}
