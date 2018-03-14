//
//  OauthRespond.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import HandyJSON

class OauthRespond: HandyJSON {
    
    var success: Bool!
    var data: User!
    
    required init() {}
}

class User: HandyJSON {
    
    var uid: Int!
    var name: String!
    var email: String!
    var access_token: String!

    required init() {}
}
