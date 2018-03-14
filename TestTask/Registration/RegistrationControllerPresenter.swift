//
//  RegistrationControllerPresenter.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import Foundation
import UIKit


class RegistrationPresenter {
    
    var view: RegistrationViewController
    var networkingService: OauthNetworkingService
    
    init(with view: RegistrationViewController, networkingService: OauthNetworkingService = OauthNetworkingService()) {
        self.view = view
        self.networkingService = networkingService
    }
    
    func addNewRegistration(name: String, mail: String, password: String, repeatPassword: String) {
        
        guard isValid(mail) else {
            print("Invalid email adress")
            self.view.showGrayBackground(forTextField: self.view.emailTextField)
            return
        }
        
        guard password != "", password == repeatPassword  else {
            print("Passwords doesn't match")
            self.view.showGrayBackground(forTextField: self.view.repeatPasswordTextFiewld)
            return
        }
        
        self.networkingService.addRegistration(name: name, mail: mail, password: password) { (result, error) in
            
            if result?.data.access_token != nil {
                Globals.API.AUTH.access_token = result?.data.access_token
                
                if let login = UserDefaults.standard.string(forKey: Registration.mail.rawValue) {
                    UserDefaults.standard.set(Globals.API.AUTH.access_token, forKey: login)
                }
                self.goMain()
            }
        }
        
        
    }
    
    func goMain() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyBoard.instantiateInitialViewController() as? ViewController {
            self.view.present(nextVC, animated: true, completion: nil)
        }
    }
        
    
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
