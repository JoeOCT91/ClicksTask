//
//  APIRouter.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 26/08/2021.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {
    //End Points names
    
    case getNews(_ page: Int)
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    //MARK:- End points path
    private var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    //MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        case .getNews:
            return nil
        }
    }
    
    private var query: [URLQueryItem]? {
        switch self {
        case .getNews(let page):
            let queryItems: [URLQueryItem]? = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "country", value: "eg"),
                URLQueryItem(name: "apiKey", value: "63b1f94dad044add871d1e319c630265"),
                URLQueryItem(name: "pagesize", value: "5"),
                ]
            return queryItems
        }
    }

    func asURLRequest() throws -> URLRequest {
        
        var urlComponents = URLComponents(string: URLs.base)!
        if let query = query {
            urlComponents.queryItems = query
        }
        let url =  try urlComponents.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        print(url)
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        
        //Http Headers
        switch self {
        case  .getNews:
            urlRequest.setValue("Accept-Language", forHTTPHeaderField: "en")
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
