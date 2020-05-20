//
//  SignInViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/4/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.

import Firebase

import GoogleSignIn
import UIKit

class SignInViewController: UIViewController, GIDSignInDelegate,  UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var signInBtn: styleButton!
    @IBOutlet weak var passwordField: StyleTextField!
    @IBOutlet weak var emailField: StyleTextField!
    
    @IBOutlet weak var errorLabel: UILabel!

    var googleSignIn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide the error label
        errorLabel.alpha = 0
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

        //GIDSignIn.sharedInstance().uiDelegate = self
        
        //GIDSignIn.sharedInstance().signIn()
        
      //  GIDSignIn.sharedInstance().presentingViewController = self

        // Automatically sign in the user.
      //has   GIDSignIn.sharedInstance()?.restorePreviousSignIn()

//
//        let googleButton = GIDSignInButton()
//        googleButton.frame = CGRect(x: 0, y: 180, width: view.frame.width - 32, height: 50)
//        view.addSubview(googleButton)
//
        
        googleSignIn = GIDSignInButton()
        googleSignIn.frame = CGRect(x: 35, y: 620, width: view.frame.width - 64, height: 70)
       // googleSignIn.frame = CGRect(x: 15, y: 625, width: view.frame.width - 32, height: 50)
        //googleSignIn.center = view.center
        
        view.addSubview(googleSignIn)
        
  }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
    //once user logged in, perform segue
        Auth.auth().addStateDidChangeListener() { auth, user in
    
        if user != nil {
            
            self.performSegue(withIdentifier: "login", sender: nil)
    //                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: ConstantVal.Storyboard.homeViewController) as? MasterTableViewController
    //                self.view.window?.rootViewController = homeViewController
    //                self.view.window?.makeKeyAndVisible()
    
            self.passwordField.text = nil
            self.emailField.text = nil
            }
        }
    
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields (email: String?, password: String?) -> String? {
        //check that all fields are filled in
        if  emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (isPasswordValid(cleanedPassword) == false) {
            //password isn't secure
            return "please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        //validate fields
        let error = validateFields(email: emailField.text, password: passwordField.text)
        if error != nil {
            showError(error!, errorLabel: errorLabel)
        
        } else {
        
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //sign in user
            
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if error != nil {
                //couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                //transition to home view controller
               self.performSegue(withIdentifier: "login", sender: nil)
            }
         }
        }
    }
    //google sign in
    
    @IBAction func googleSignIn(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        // When user is signed in
        Auth.auth().signIn(with: credential, completion: { (result, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            } else {
                //if no error add user to database if user does not already exist
                
                DB_BASE.document("Users/\(Auth.auth().currentUser!.uid)").getDocument() { (document, err) in
                    if let err = err {
                        print("Error verifying user in database \(err)")
                    } else {
                        if let document = document, !document.exists {
                            //if user does not exist then create
                            DB_BASE.collection("Users").document(Auth.auth().currentUser!.uid).setData([
                                "firstname": user.profile.name,
                                "lastname" : user.profile.familyName,
                                "uid": Auth.auth().currentUser!.uid
                                ]) {(error) in
                                if error != nil {
                                    //show error message
                                    showError("google user information could not be saved in db", errorLabel: self.errorLabel)
                                }
                        }
                    }
                }
                
            }
                
                //after confirming user has db entry or adding db entry show new view controller
                //once signed in , and database entry verified , present main view controller
                self.performSegue(withIdentifier: "login", sender: nil)
                    
            
        }
        })
    }
    //    // Start Google OAuth2 Authentication
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        // Showing OAuth2 authentication window
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    //    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        // Close OAuth2 authentication window
        dismiss(animated: true) {() -> Void in }
    }
    
    
    
//    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
//
//        let alert = UIAlertController(title: "Register",
//                                      message: "Register",
//                                      preferredStyle: .alert)
//
//        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//
//            if (self.validateFields(email: alert.textFields![0].text, password: alert.textFields![1].text ) != nil) {
//                //set lable to show error
//            } else {
//                let error = DataService.ds.createFirestoreDBUser(email: alert.textFields![0].text!, password: alert.textFields![1].text!, firstName: "test", lastName: "test", errorLabel: self.errorLabel)
//                if (error != "") {
//                    //print out error
//                    self.errorLabel.text = error
//                    self.errorLabel.alpha = 1
//
//                }
//            }
//        }
//            let cancelAction = UIAlertAction(title: "Cancel",
//                                             style: .cancel)
//
//            alert.addTextField { textEmail in
//                textEmail.placeholder = "Enter your email"
//            }
//
//            alert.addTextField { textPassword in
//                textPassword.isSecureTextEntry = true
//                textPassword.placeholder = "Enter your password"
//            }
//
//            alert.addAction(saveAction)
//            alert.addAction(cancelAction)
//
//            present(alert, animated: true, completion: nil)
//
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        if textField == passwordField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
    */


    
}

