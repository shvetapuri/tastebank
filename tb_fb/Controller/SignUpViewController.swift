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
    
    func isEmailValid1(_ email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    //if field is correct, this method returns nil, otherwise it returns the error message
    func validateFields() -> String? {
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedFirstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedLastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //check that all fields are filled in
        if (cleanedFirstName == "" || cleanedLastName == "" || cleanedEmail == "" || cleanedPassword == "") {
            return "Please fill in all fields"
        }
        
        if (isEmailValid1(cleanedEmail!) == false) {
            return "Please make sure your email format is correct"
        }
        
        if (isPasswordValid(cleanedPassword) == false) {
            //password isn't secure
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        
        
        return nil
    }
    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
        
        //validate the fields
        let error = validateFields()
        if error != nil {
            //show error message
            showError(error!, errorLabel: errorLabel)
            print("Helo i am in error")
        } else {
            //Create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            let errorFromCreatingUser = DataService.ds.createFirestoreDBUser(email: email, password: password, firstName: firstName, lastName: lastName, errorLabel: errorLabel)
            
            if(errorFromCreatingUser != "") {
                //print error
                showError(errorFromCreatingUser, errorLabel: errorLabel)
            } else {
//                    //sign in and transition to home
//                            Auth.auth().signIn(withEmail: email, password: password) {
//                                (result, error) in
//                                if error != nil {
//                                    //couldn't sign in
//                                    self.errorLabel.text = error!.localizedDescription
//                                    self.errorLabel.alpha = 1
//                                }
//                                else {
                                    // transition to the home screen
                                    
                                    //self.transitionToHome()
                                    //self.performSegue(withIdentifier: "loginFromSignUp", sender: nil)
                                    self.dismiss(animated: true, completion: nil)

                                    }
                            //}
                        }
                
       // }
            
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    

    
    func transitionToHome() {
//
//        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "MasterViewController") as? MasterTableViewController
//       // view.window?.rootViewController = homeViewController
//        var topMostVC = UIApplication.shared.keyWindow?.rootViewController
//        //topMostVC?.presentationController ho
//
//        view.window?.makeKeyAndVisible()
    }
    
    
}
