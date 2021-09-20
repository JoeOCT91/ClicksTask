//
//  NoConnectionVC.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 04/09/2021.
//

import UIKit

protocol NoConnectionVCProtocol {
    
    
}

class NoConnectionVC: UIViewController  {
    
    //ViewModel property
    private var viewModel: ArticleVMProtocol!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = NoConnectionView()
    }
    
    
    class func create() -> NoConnectionVC {
        let noConnectionView: NoConnectionVC = NoConnectionVC()
        //let viewModel = NewsVM(view: newsVC)
        //noConnectionView.viewModel = viewModel
        return noConnectionView
    }
    

}

extension NoConnectionVC: NoConnectionVCProtocol {
    
    
    
}
