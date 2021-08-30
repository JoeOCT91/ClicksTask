//
//  ArticleLabel.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 29/08/2021.
//

import UIKit

class ArticleLabel: UILabel {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(textAlignment: NSTextAlignment = .right, fontSize: CGFloat, font: UIFont? = UIFont(font: FontFamily.Cairo.regular, size: 12)) {
        super.init(frame: .zero)
        self.font = font
        self.textAlignment = textAlignment
        self.font = self.font.withSize(fontSize)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = ColorName.black.color
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }

}
