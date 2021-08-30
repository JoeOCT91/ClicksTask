//
//  APIManager.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 26/08/2021.
//

import Foundation
import Alamofire

class APIManager {
    
    let cache = NSCache<NSString, UIImage>()
    
    // MARK:- Singleton
    private static let sharedInstance = APIManager()
    
    class func shared() -> APIManager {
        return APIManager.sharedInstance
    }
    // It seems like it's useless here, it will be handy when have more than one function
    typealias complationHandler<Element: Codable> = Result<BaseResponse<Element>, Error>
    
     func getNews<Element>(page: Int, complation: @escaping (complationHandler<Element>) -> () ) {
        request(APIRouter.getNews(page)) { (response) in
            complation(response)
        }
    }
}

extension APIManager {
    // MARK:- The request function to get results in a closure
    private func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }.responseJSON { response in
            //print(response)
        }
    }
}
