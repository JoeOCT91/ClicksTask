//
//  UIViewController+Storyboard.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 26/08/2021.
//

import UIKit

extension UIViewController {
    class func create<T: UIViewController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }

}
