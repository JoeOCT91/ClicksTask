//
//  AppDelegate.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 26/08/2021.
//

import UIKit
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        let newsVC = NewsVC.create()
        let navigationController = UINavigationController(rootViewController: newsVC)
        window?.rootViewController = navigationController
        return true
    }
}

