//
//  LoginViewController.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import UIKit

enum Registration: String {
    case isRegistered
    case mail
    case password
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBttn: UIButton!
    @IBOutlet weak var registrBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFildsAndBttns()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func hideKeyboardTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func setupTextFildsAndBttns() {
        self.registrBttn.addTarget(self, action: #selector(goToRegistration(_:)), for: .touchUpInside)
        self.loginBttn.addTarget(self, action: #selector(loginBttnPressed(_:)), for: .touchUpInside)
    }
    
    @objc func loginBttnPressed(_ sender: Any) {
        let presenter = LoginControllerPresenter(view: self)
        presenter.login(login: self.emailTextField.text, password: self.passwordTextField.text)
    }
    
    @objc func goToRegistration(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        
        if let nextVC = storyboard.instantiateInitialViewController() as? RegistrationViewController {
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    private func isAlreadyRegistered() {
        let isRegistered = UserDefaults.standard.bool(forKey: Registration.isRegistered.rawValue)
        if isRegistered {
            print("already Registered")
            self.emailTextField.text = UserDefaults.standard.string(forKey: Registration.mail.rawValue)
            self.passwordTextField.text = UserDefaults.standard.string(forKey: Registration.password.rawValue)
        }
    }




}
