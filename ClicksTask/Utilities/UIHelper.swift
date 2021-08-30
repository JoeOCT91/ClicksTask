//
//  UIHelper.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 28/08/2021.
//

import UIKit

enum UIHelper {
    
    static func createThreeColFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 28
        let availableWidth = width - (padding * 2)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)

        return flowLayout
    }
}
