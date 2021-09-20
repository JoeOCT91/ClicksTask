//
//  Article.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 27/08/2021.
//

import Foundation


struct Article: Codable, Hashable {
    
    let uuid = UUID()
    
    let source: Source?
    let title: String
    let articleDescription: String?
    let urlToImage: String?
    let url: String

    enum CodingKeys: String, CodingKey {
        case source, title
        case articleDescription = "description"
        case urlToImage
        case url
    }
}
extension Article {
    
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
