//
//  NotificationName.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 03/09/2021.
//

import Foundation

extension Notification.Name {
    static let flagsChanged = Notification.Name("FlagsChanged")
}

@objc public extension NSNotification {
    static var flagsChanged: NSString { return "FlagsChanged" }
}
