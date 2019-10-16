//
//  SignUpViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/9/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide the error label
        errorLabel.alpha = 0
        
        
    }
    
    func isPasswordValid(_ password: String) -> Bool {
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isEmailValid(_ email: String) -> Bool {
        return true
    }
    //if field is correct, this method returns nil, otherwise it returns the error message
    func validateFields() -> String? {
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (isPasswordValid(cleanedPassword) == false) {
            //password isn't secure
            return "please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
        
        //validate the fields
        let error = validateFields()
        if error != nil {
            //show error message
            showError(error!, errorLabel: errorLabel)
        } else {
            //Create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil {
                    //there was an error creating user
                    showError("Error creating user", errorLabel: self.errorLabel)
                }
                else {
                    //User was created successfully, now store first and last name
                    let db = Firestore.firestore() //return firestore obj
                    
                    db.collection("Users").addDocument(data: ["firstname":firstName, "lastname": lastName, "uid": result!.user.uid]) {(error) in
                        if error != nil {
                            //show error message
                            showError("user name could not be saved in db", errorLabel: self.errorLabel)
                        } else {
                            //sign in and transition to home
                            Auth.auth().signIn(withEmail: email, password: password) {
                                (result, error) in
                                if error != nil {
                                    //couldn't sign in
                                    self.errorLabel.text = error!.localizedDescription
                                    self.errorLabel.alpha = 1
                                }
                                else {
                                    // transition to the home screen
                                    
                                  //  self.transitionToHome()
                                    self.performSegue(withIdentifier: "loginFromSignUp", sender: nil)
                                   

                                    }
                            }
                        }
                
                    }
            
                }
            }
    
        }
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: ConstantVal.Storyboard.homeViewController) as? MasterTableViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
