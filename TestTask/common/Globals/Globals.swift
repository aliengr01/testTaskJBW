//
//  Globals.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import UIKit
import Alamofire


class Globals {
    
    struct Characters {
        static let arrayChars: [String] = [" ", "A", "a", "B", "b", "C", "c", "D", "d", "E", "e", "F", "f", "G", "g", "H", "h", "I", "i", "J", "j", "K", "k", "L", "l", "M", "m", "N", "n", "O", "o", "P", "p", "Q", "q", "R", "r", "S", "s", "T", "t", "U", "u", "V", "v", "W", "w", "X", "x", "Y", "y", "Z", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "-", "+", "=", "|", "/", "`", "[", "]", "{", " }", ".", "?", "<", ">", "\"", ",", "~", ":", ";", "±", "§" ]
    }
    
    struct API {
        
        
        static let baseUrl = "https://apiecho.cf/"
        
        static let headers: HTTPHeaders = [
            "Authorization": "\(Globals.API.AUTH.tokenType) \(Globals.API.AUTH.access_token)"
        ]
    
    
        enum Methods: String {
            case login
            case signup
            case getText
        
            var url: URL {
                switch self {
                case .login: return URL(string:"\(baseUrl)api/login/")!
                case .signup: return URL(string:"\(baseUrl)api/signup/")!
                case .getText: return URL(string:"\(baseUrl)api/get/text/")!
                }
            }
        }
        
        struct AUTH {
            struct oauthRespond {
                var access_token: String!
                var token_type: String!
            }
            
            static let tokenType = "Bearer"
            static var access_token: String!
            
        }
    }
    
}
