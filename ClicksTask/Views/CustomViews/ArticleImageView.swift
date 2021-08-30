//
//  ArticleImageView.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 29/08/2021.
//

import UIKit
import SDWebImage

class ArticleImageView: UIImageView {

    let cache = APIManager.shared().cache
    //let placeHolderImage = Images.placeHolder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds = true // sets the image to not have sharp corners in addition to the layer corner radius
        image = Asset.imagePlaceHolder.image // Place holder for ImageView
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String?) {
        guard let url = url else { return }
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async { self.image = image }
            return
        }
        guard let URL = URL(string: url) else { return }
        sd_setImage(with: URL) { [weak self] (image, _, imageCache, _)  in
            guard let self = self else { return }
            guard let image = image else { return }
            DispatchQueue.main.async { self.image = image }
            self.cache.setObject(image, forKey: cacheKey)
        }
    }
}

