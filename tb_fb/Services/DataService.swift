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
    
    func showError(_ message:String, errorLabel:UILabel) {
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func createFirestoreDBUser(email: String, password: String, firstName: String, lastName: String, errorLabel: UILabel) -> String {
        var err1: String = ""
    
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            //check for errors
            if err != nil {
                //there was an error creating user
                self.showError("Error creating user", errorLabel: errorLabel)
                err1 = "Error creating user"
                print(err1)
                
            } else {
                if (result!.user.uid != "") {
                //User was created successfully, now store first and last name
                
                //DB_BASE.collection("Users").addDocument(data: ["firstname":firstName, "lastname": lastName, "uid": result!.user.uid])
                   DB_BASE.collection("Users").document(result!.user.uid).setData([
                    "firstname": firstName,
                    "lastname" : lastName,
                    "uid": result!.user.uid
                    ]) {(error) in
                    if error != nil {
                        //show error message
                        self.showError("user name could not be saved in db", errorLabel: errorLabel)
                        err1 = "user name could not be saved in db"
                        print(err1)
                    }
                    }
                } else {
                    err1 = "Could not create user entry in db"
                    print(err1)
                }
            }
        }
//        Auth.auth().createUser(withEmail: withEmail, password: withPassword) { user, error in
//            if error == nil {
//                //create user entry in database
//                DB_BASE.collection("Users").addDocument(data:["uid": user!.user.uid]) {(error) in
//
//                    if error != nil {
//                        errorLabel.text = error!.localizedDescription
//                        errorLabel.alpha = 1
//                        err1 = error!.localizedDescription
//                        print("in ERRRRROOORRR")
//                        print(error?.localizedDescription)
//                    }
//                }
////                Auth.auth().signIn(withEmail: withEmail, password: withPassword) {
////                (result, error) in
////                if error != nil {
////                    //couldn't sign in
////                    errorLabel.text = error!.localizedDescription
////                    errorLabel.alpha = 1
////                }
//
//            } else {
//                //couldn't create user
//                errorLabel.text = error!.localizedDescription
//                errorLabel.alpha = 1
//                err1 = error!.localizedDescription
//                print("in ERRRRROOORRR1")
//
//                print(error?.localizedDescription)
//
//               }
 
        return err1
        }


                    
    
    func createTasteEntryDB(TasteDict: Tastes) -> String  {
        //find user id
        var docId = ""
        if let user = Auth.auth().currentUser {
            
            
        //create taste under that user
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
            ref = DB_BASE.collection("Users/\(user.uid)/Tastes").addDocument(data: TasteDict.dictionaryImage as [String : Any]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                docId = ref!.documentID
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        } else {
            print ("Error, no user was found")
        }
        
       return docId
    }
    
    func EditTasteEntryDB(TasteDict: Tastes, ID: String) {
//    //edit existing entry
        if let user = Auth.auth().currentUser {
            
            DB_BASE.collection("Users").document(user.uid).collection("Tastes").document(ID).updateData(TasteDict.dictionaryImage as [String : Any]) { (error:Error?) in
              if let error = error {
                print("Data could not be saved: \(error).")
              } else {
                print("Data saved successfully!")
              }
            }
            
        } else {
            print ("Error, no user was found")
        }
        
    }
    func loadDBTastes( completion: @escaping ((_ tastesArr: [Tastes] ) -> Void))   {
        //var snapshot
        
        //find user id
        if let user = Auth.auth().currentUser {
            
            DB_BASE.collection("Users/\(user.uid)/Tastes").getDocuments() { (querySnapshot, err) in
                var tastes = [Tastes] ()
                if let err = err {
                    print ("Error in getting Tastes: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        print ("query snapthop", document.data())
                        print("doc id,", document.documentID)
                        var t = Tastes(dictionary: document.data())
                        t?.id = document.documentID
                        print("hi i am turning snapshot into struct \(String(describing: t)))")
                    
                        if (t != nil) {
                            tastes.append(t!)
                        }
                    
                    }
                completion(tastes)
                

            }

        }
        } else {
             print ("Error, no user was found while trying to load tastes")
        }

    }
}
