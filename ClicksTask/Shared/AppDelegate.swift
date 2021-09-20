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
        
        initialeseReachability()
        IQKeyboardManager.shared.enable = true
        let newsVC = NewsVC.create()
        let navigationController = UINavigationController(rootViewController: newsVC)
        window?.rootViewController = navigationController
        
        
        return true
    }
    
    private func initialeseReachability() {
        do {
            try NetworkStateManger.Shared = Reachability(hostname: "www.google.com")
            
        } catch {
            switch error as? NetworkStateManger.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
}
