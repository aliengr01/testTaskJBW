//
//  RegistrationViewController.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextFiewld: UITextField!
    @IBOutlet weak var signUpBttn: UIButton!
    @IBOutlet weak var closeBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextFieldAndBttns()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func hideKeyboardTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func setupTextFieldAndBttns() {
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.repeatPasswordTextFiewld.delegate = self
        
        self.signUpBttn.addTarget(self, action: #selector(signUpBttnPressed(_:)), for: .touchUpInside)
        self.closeBttn.addTarget(self, action: #selector(closeBttnPressed(_:)), for: .touchUpInside)
        
    }
    
    @objc func signUpBttnPressed(_ sender: Any) {
        let presenter = RegistrationPresenter(with: self)
        
        presenter.addNewRegistration(name: self.nameTextField.text!,
                                     mail: self.emailTextField.text!,
                                     password: self.passwordTextField.text!,
                                     repeatPassword: self.repeatPasswordTextFiewld.text!)
    
    }
    
    @objc func closeBttnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let chars = textField.text! + string
        
        switch textField {
        case nameTextField:
            if chars.count <= 16  {
                return true
            }
            let index = chars.index(chars.startIndex, offsetBy: 16)
            nameTextField.text = String(chars[..<index])
            return false
            
        case emailTextField:
            return true
            
        case passwordTextField, repeatPasswordTextFiewld:
            if chars.count <= 32 {
                return true
            }
            let index = chars.index(chars.startIndex, offsetBy: 32)
            passwordTextField.text = String(chars[..<index])
            return false
            
        default:
            return false
        }
    }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            switch textField {
            case nameTextField:
                if textField.text!.count != 0 {
                    nameTextField.becomeFirstResponder()
                }

            case emailTextField:
                if textField.text!.contains("@") {
                    passwordTextField.becomeFirstResponder()
                }
            case passwordTextField:
                if textField.text!.count >= 6 {
                    repeatPasswordTextFiewld.becomeFirstResponder()
                }
            case repeatPasswordTextFiewld:
                if textField.text!.count >= 6 {
                    signUpBttnPressed(repeatPasswordTextFiewld)
                }
            default:
                return false
            }
            return true
        }
}

extension UIViewController {
    
    func showGrayBackground(forTextField: UITextField) {
        forTextField.becomeFirstResponder()
        UIView.animate(withDuration: 0.75, delay: 0.1, options: [], animations: {
            forTextField.backgroundColor = UIColor.red
        }, completion: { _ in
            forTextField.backgroundColor = .white
        })
    }
}
