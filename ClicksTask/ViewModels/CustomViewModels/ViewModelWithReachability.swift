//
//  ViewModelWithReachability.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 11/09/2021.
//

import Foundation

protocol ViewModelWithReachabilityProtocol {
    func stateChanged()
}

class ViewModelWithReachability<T: VCWithReachabilityProtocol>  {

    internal weak var view: T?
    
    init(view: T) {
        self.view = view
    }
    
    func stateChanged() {
        switch NetworkStateManger.Shared.status {
        case .unreachable:
            print("internet connection has been lost")
        default:
            print("internet connection has been return")
        }
    }
    
}
