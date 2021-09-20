//
//  NoConnectionView.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 04/09/2021.
//

import UIKit

class NoConnectionView: UIView {
    
    private let noConnectionImageView: UIImageView = UIImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(noConnectionImageView)
        noConnectionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noConnectionImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noConnectionImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noConnectionImageView.heightAnchor.constraint(equalToConstant: 450),
            noConnectionImageView.widthAnchor.constraint(equalTo: noConnectionImageView.heightAnchor)
        ])
        
        noConnectionImageView.image = Asset.noInternetConnection.image
    }

}
