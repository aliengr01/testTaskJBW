//
//  RegistrationErrorRespond.swift
//  TestTask
//
//  Created by Igor Ryazancev on 14.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import Alamofire
import HandyJSON

class ErrorRespond: HandyJSON {
    
    var success: Bool = false
    var errors: [ErrorField]!
    
    required init() {}
}

class ErrorField: HandyJSON {
    var field: String!
    var message: String!
    
    required init() {}
}
