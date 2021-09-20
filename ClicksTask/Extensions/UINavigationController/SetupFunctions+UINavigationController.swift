//
//  SetupFunction+UINavigationController.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 28/08/2021.
//

import UIKit

extension UINavigationController {

    func setNavigationBarBackground(with backgroundColor: UIColor = ColorName.navbarbg.color) {
        // change navigation bar background behivor
        //self.navigationBar.tintColor = .clear
        //self.navigationBar.isTranslucent = true
        
        //self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        //self.navigationBar.backgroundColor = .black
    }
    internal func setupShareButton(){
        var settingIcon = UIImage(systemName: "square.and.arrow.up")
        settingIcon = settingIcon?.withRenderingMode(.alwaysOriginal)
        let settingButton = UIBarButtonItem(image: settingIcon, style: .plain, target: self, action: #selector(settingsButton))
        navigationItem.rightBarButtonItem = settingButton
    }
    //Share Button pressed
    @objc private func settingsButton(_ sender:UIBarButtonItem){
        print("dddd")
    }
}
