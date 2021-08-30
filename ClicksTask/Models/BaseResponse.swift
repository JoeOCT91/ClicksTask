//
//  BaseResponse.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 27/08/2021.
//

import Foundation

struct BaseResponse<Element: Codable>: Codable {    
    let status: String
    let totalResults: Int
    let articles: [Article]
}
