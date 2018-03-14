//
//  Request.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
typealias JSONDictionary = [String : AnyObject]

class Request {
    
    static func serverRequest<T: HandyJSON>(APIMethod: Globals.API.Methods,
                                            parameters: Parameters,
                                            completion: @escaping (T?) -> Void) {
        request(url: APIMethod.url, parameters: parameters,
                successComplletion: { (value) in
                    let resultValue: T? = self.deserialize(value as? JSONDictionary)
                    completion(resultValue)
                    
        }) {
            completion(nil)
        }
    }
    
    static private func request(url: URL, parameters: Parameters,
                                successComplletion: @escaping (Any) -> Void,
                                failCompletion: @escaping () -> Void) {
        
        let encoding: URLEncoding = setEncoding(url: url)
        
        let headers: HTTPHeaders = [
             "Authorization": "\(Globals.API.AUTH.tokenType) \(Globals.API.AUTH.access_token ?? "")"
        ]
        
        Alamofire
            .request(url, method: .get, parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON { (response) in
                                
                switch response.result {
                case .success(let value):
                    successComplletion(value)
                case .failure:
                    failCompletion()
                }
        }
        
        
        
        
    }
    
    static private func setEncoding(url: URL) -> URLEncoding {
        return (url == Globals.API.Methods.signup.url) ? URLEncoding.httpBody : URLEncoding.queryString
    }
    
    static private func deserialize<T: HandyJSON>(_ toDeserialize: JSONDictionary?) -> T? {
        return JSONDeserializer<T>.deserializeFrom(json: toDeserialize?.toJSONString())
    }
}
