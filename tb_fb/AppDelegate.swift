//
//  AppDelegate.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/10/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit
import GooglePlaces
import Firebase
import GoogleSignIn
//import FirebaseAuthUI


//https://tastebank-1550295921926.firebaseapp.com/__/auth/handler

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GMSPlacesClient.provideAPIKey("AIzaSyCoXNK3n-PHKFOOO6dk9MsHZS6c33hcbWU")
  
        
        
        // Override point for customization after application launch.
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
           // return GIDSignIn.sharedInstance().handle(url,
                          //                           sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                           //          annotation: [:])
            return GIDSignIn.sharedInstance().handle(url)

    }
    fileprivate func setupGoogleButtons() {
        //add google sign in button
       // let googleButton = GIDSignInButton()
       // googleButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 50)
       // view.addSubview(googleButton)
        
       // GIDSignIn.sharedInstance().uiDelegate = self as? GIDSignInUIDelegate
    }
    

    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

