//
//  OauthNetworkingService.swift
//  TestTask
//
//  Created by Igor Ryazancev on 13.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import Foundation
import Alamofire

class OauthNetworkingService {
    
    
    func login(mail: String, password: String, with completion: @escaping (OauthRespond?, ErrorRespond?) -> Void ) {
        let parameters: [String : Any] = [
            "email": mail,
            "password": password
        ]
        
        var positiveResult: OauthRespond?
        var loginErrorRespond: ErrorRespond?
        
        Alamofire.request(Globals.API.Methods.login.url, method: .post, parameters: parameters).responseJSON { (response) in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                positiveResult = OauthRespond.deserialize(from: utf8Text)
                loginErrorRespond = ErrorRespond.deserialize(from: utf8Text)
                
                completion(positiveResult, loginErrorRespond)
                
            } else {
                completion(nil, nil)
            }
        }
    }
    
    
    func addRegistration(name: String, mail: String, password: String, with completion: @escaping (OauthRespond?, ErrorRespond?) -> Void) {
        let parameters: [String : Any] = [
            "name": name,
            "email": mail,
            "password": password
        ]
        var positiveResult: OauthRespond?
        var registrationErrorRespond: ErrorRespond?
        
        Alamofire.request(Globals.API.Methods.signup.url, method: .post, parameters: parameters).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") 
                
                positiveResult = OauthRespond.deserialize(from: utf8Text)
                registrationErrorRespond = ErrorRespond.deserialize(from: utf8Text)
                
                completion(positiveResult, registrationErrorRespond)
                
            } else {
                completion(nil, nil)
            }
        }
    }
    
}
