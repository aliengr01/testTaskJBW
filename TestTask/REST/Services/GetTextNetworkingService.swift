//
//  GetTextNetworkingService.swift
//  TestTask
//
//  Created by Igor Ryazancev on 14.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import Foundation
import Alamofire


class GetTextNetworkingService {
    
    
    func getText(with completion: @escaping (TextRespond?) -> Void) {
        let parameters: [String : Any] = [:]

        Request.serverRequest(APIMethod: Globals.API.Methods.getText, parameters: parameters) { (result) in
            completion(result)
        }
    }
    

    
    
    
}
