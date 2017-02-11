//
//  ViewController.swift
//  AnimatedLogin
//
//  Created by Thom Pijnenburg on 09/02/2017.
//  Copyright © 2017 Thom Pijnenburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTitle: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var backgroundImage: UIView!

    var loginFieldsList = [UIView]()
    
    let topRowOffset: CGFloat = 150
    let midRowOffset: CGFloat = 100
    let bottomRowOffset: CGFloat = 50
    let shiftFields: CGFloat = 75
    
    var loginStatus: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        nameField.tag = 0
        
        emailField.delegate = self
        emailField.tag = 1
        passwordField.delegate = self
        passwordField.tag = 2
        
        loginFieldsList = [emailLabel, emailField, passwordLabel, passwordField, loginButton, registerButton]
        
        // dismiss keyboard when tapping screen
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginTitle.alpha = 0.0
        nameField.alpha = 0.0
        nameLabel.alpha = 0.0
        emailLabel.alpha = 0.0
        emailField.alpha = 0.0
        passwordField.alpha = 0.0
        passwordLabel.alpha = 0.0
        loginTitle.alpha = 0.0
        loginButton.alpha = 0.0
        registerButton.alpha = 0.0
        
        backgroundImage.alpha = 1.0
        
        nameLabel.center.x -= view.bounds.width
        nameField.center.x -= view.bounds.width
        nameField.isUserInteractionEnabled = false

        loginButton.center.y -= bottomRowOffset + shiftFields
        registerButton.center.y -= bottomRowOffset + shiftFields
        
        passwordField.center.y -= midRowOffset + shiftFields
        passwordLabel.center.y -= midRowOffset + shiftFields

        emailField.center.y -= topRowOffset + shiftFields
        emailLabel.center.y -= topRowOffset + shiftFields
        loginTitle.center.y -= topRowOffset + 20
        
        registerButton.addTarget(self, action: #selector(self.didTapRegisterButton), for: .touchUpInside)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 1.0, animations: {
            self.backgroundImage.alpha = 0.4
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 1.0,
                       options: [],
                       animations: {
                        self.loginButton.alpha = 1.0
                        self.registerButton.alpha = 1.0
                        self.loginButton.center.y += self.bottomRowOffset
                        self.registerButton.center.y += self.bottomRowOffset
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 1.0,
                       options: [],
                       animations: {
                        self.passwordField.alpha = 1.0
                        self.passwordLabel.alpha = 1.0
                        self.passwordField.center.y += self.midRowOffset
                        self.passwordLabel.center.y += self.midRowOffset
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 1.0,
                       options: [],
                       animations: {
                        self.emailField.alpha = 1.0
                        self.emailLabel.alpha = 1.0
                        self.loginTitle.alpha = 1.0
                        self.emailField.center.y += self.topRowOffset
                        self.emailLabel.center.y += self.topRowOffset
                        self.loginTitle.center.y += self.topRowOffset + 20
        }, completion: nil)
        
        
    }
    
    func didTapRegisterButton(_ sender: UIButton!) {
        shiftFields(loginStatus)
        changeLabels(loginStatus)
        // change button actions
        
        nameField.isUserInteractionEnabled = loginStatus
        loginStatus = !loginStatus
    }
    
    func didTapSubmitButton(_ sender: UIButton!) {
        if loginStatus {
            // log in the user
        }
        else {
            // register the user
        }
    }
    
    func shiftFields(_ loginStatus: Bool) {
        // if login screen
        if loginStatus {
            // shift fields down
            UIView.animate(withDuration: 0.5, delay: 0,
                           options: [],
                           animations: {
                            for item in self.loginFieldsList {
                                item.center.y += self.shiftFields
                            }
            }, completion: nil)
            
            // pull name fields into screen
            UIView.animate(withDuration: 0.5, delay: 0.5,
                           options: [],
                           animations: {
                            self.loginTitle.alpha = 0.0
                            self.nameLabel.center.x += self.view.bounds.width
                            self.nameField.center.x += self.view.bounds.width
            }, completion: nil)
            
            // fade in namefields
            UIView.animate(withDuration: 2.0, delay: 0,
                           options: [],
                           animations: {
                            self.nameLabel.alpha = 1.0
                            self.nameField.alpha = 1.0
            }, completion: nil)
            
            
        }
            
        // if register screen
        else {
            //fade out and shift namelabes out of screen
            UIView.animate(withDuration: 0.5, delay: 0.0,
                           options: [],
                           animations: {
                            self.nameLabel.alpha = 0.0
                            self.nameField.alpha = 0.0
                            self.nameLabel.center.x -= self.view.bounds.width
                            self.nameField.center.x -= self.view.bounds.width
            }, completion: nil)
            // shift login fields up
            UIView.animate(withDuration: 0.5, delay: 0.5,
                           options: [],
                           animations: {
                            self.loginTitle.alpha = 0.0
                            for item in self.loginFieldsList {
                                item.center.y -= self.shiftFields
                            }
            }, completion: nil)
            
        }
        
        
    }
    
    func changeLabels(_ loginStatus: Bool) {
        
        // if loginscreen
        if loginStatus {
            // change labels to register
            UIView.animate(withDuration: 1.0, delay: 1.0,
                           options: [],
                           animations: {
                            self.loginTitle.text = "Register"
                            self.loginButton.setTitle("Register", for: .normal)
                            self.registerButton.setTitle("or log in", for: .normal)
                            self.loginTitle.alpha = 1.0
            }, completion: nil)
        }
            
        // if register screen
        else {
            // change labels to login
            UIView.animate(withDuration: 1.0, delay: 1.0,
                           options: [],
                           animations: {
                            self.loginTitle.text = "Log in"
                            self.loginButton.setTitle("Log in", for: .normal)
                            self.registerButton.setTitle("or register", for: .normal)
                            self.loginTitle.alpha = 1.0
            }, completion: nil)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    // dismiss keyboard when tapping view
    func didTapView(){
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

