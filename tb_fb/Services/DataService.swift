//
//  DataService.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/11/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Firestore.firestore()
//contains references to data base
class DataService {
    //singleton only one instance of class
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
 //   private var _REF_USERS = DB_BASE.child("users")
    
//    var REF_BASE: FIRDatabaseReference {
//        return _REF_BASE
//    }
//    var REF_USERS: FIRDatabaseReference {
//        return _REF_USERS
//    }
    
    func createFirestoreDBUser(withEmail: String, withPassword: String, errorLabel: UILabel) -> String? {
        var err1: String = ""
        Auth.auth().createUser(withEmail: withEmail, password: withPassword) { user, error in
            if error == nil {
                //create user entry in database
                DB_BASE.collection("Users").addDocument(data:["uid": user!.user.uid]) {(error) in

                    if error != nil {
                        errorLabel.text = error!.localizedDescription
                        errorLabel.alpha = 1
                        err1 = error!.localizedDescription
                        print("in ERRRRROOORRR")
                        print(error?.localizedDescription)
                    }
                }
//                Auth.auth().signIn(withEmail: withEmail, password: withPassword) {
//                (result, error) in
//                if error != nil {
//                    //couldn't sign in
//                    errorLabel.text = error!.localizedDescription
//                    errorLabel.alpha = 1
//                }
                
            } else {
                //couldn't create user
                errorLabel.text = error!.localizedDescription
                errorLabel.alpha = 1
                err1 = error!.localizedDescription
                print("in ERRRRROOORRR1")

                print(error?.localizedDescription)

            }
        }
        return err1
    }
    
    
    func createDBUserEntry () {
        
    }
    
    func createTasteEntryDB(TasteDict: [String: String]) {
        //find user id
        if let user = Auth.auth().currentUser {
            
        //create taste under that user
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
            ref = DB_BASE.collection("Users/\(user.uid)/Tastes").addDocument(data: TasteDict as [String : Any]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        } else {
            print ("Error, no user was found")
        }
    }

}
