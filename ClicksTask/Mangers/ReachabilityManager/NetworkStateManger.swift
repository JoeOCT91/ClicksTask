//
//  NetworkStateManger.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 06/09/2021.
//

import Foundation

struct NetworkStateManger {
    
    
    static var Shared: Reachability!
    
    enum Status: String {
        case unreachable, wifi, wwan
    }
    
    enum Error: Swift.Error {
        case failedToSetCallout
        case failedToSetDispatchQueue
        case failedToCreateWith(String)
        case failedToInitializeWith(sockaddr_in)
    }
}
