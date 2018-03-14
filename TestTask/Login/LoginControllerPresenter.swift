//
//  LoginControllerPresenter.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import UIKit

class LoginControllerPresenter {
    var view: LoginViewController?
    var networkingService: OauthNetworkingService
    
    init(view: LoginViewController, networkingService: OauthNetworkingService = OauthNetworkingService()) {
        self.view = view
        self.networkingService = networkingService
    }
    
    func login(login: String?, password: String?) {
        if login != "", password != "", let loginString = login, let passwordString = password {
            
            self.networkingService.login(mail: loginString, password: passwordString, with: { (respond, error) in
                
                
                if error?.success == false {
                    print("lllll")
                    let alertVC = UIAlertController(title: "Error 401", message: error?.errors[0].message, preferredStyle: .alert)
                    let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertVC.addAction(buttonOk)
                    return self.view!.present(alertVC, animated: true, completion: nil)
                }
                
                if respond?.data.access_token != nil {
                    Globals.API.AUTH.access_token = respond?.data.access_token
                    print(Globals.API.AUTH.access_token)
                    
                    if let login = UserDefaults.standard.string(forKey: Registration.mail.rawValue) {
                        UserDefaults.standard.set(Globals.API.AUTH.access_token, forKey: login)
                    }
                    self.goMain()
                }
                
            })
        }
    }
    
    func goMain() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyBoard.instantiateInitialViewController() as? ViewController {
            self.view?.present(nextVC, animated: true, completion: nil)
        }
    }
    
}
