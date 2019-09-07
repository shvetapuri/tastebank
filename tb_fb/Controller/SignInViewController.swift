//
//  SignInViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/4/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//
import Firebase

import FirebaseAuth
//import FirebaseGoogleAuthUI

import GoogleSignIn
import UIKit
import FirebaseAuthUI

class SignInViewController: UIViewController {
    
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth()
        ]
    let authUI = FUIAuth.defaultAuthUI()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.authUI?.providers = providers
        self.authUI!.delegate = self as! FUIAuthDelegate

        // Present the auth view controller and then implement the sign in callback.
        let authViewController = self.authUI!.authViewController()
        
    }
    func authUI(_ authUI: FUIAuth, didSignInWithAuthDataResult authDataResult: AuthDataResult?, error: Error?) {
        // handle user (`authDataResult.user`) and error as necessary
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
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
