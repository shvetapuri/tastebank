//
//  MainViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/11/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var labelMisc: UILabel!
    
    let ref = Database.database()
    var tasteList: [Tastes] = []
    var user: User!
    var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // get current user by setting up listener
            let user = Auth.auth().currentUser
            if let user = user {
                self.user = user
                print("user info")
                print(user.uid, user.email, user.photoURL)
                
                loadData(user: self.user)
//                DB_BASE.collection("Users/\(user.uid)/Tastes").getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        for document in querySnapshot!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
//                    }
//                }
            }
        }
        
        func loadData( user: User) {
            if let name = user.email {
                self.navigationItem.title = "Welcome \(name)"
                print (" found!!!! \(name)")
            }
            
            DB_BASE.collection("Users/\(user.uid)/Tastes").getDocuments() { (querySnapshot, err) in
                var tastes = [Tastes] ()
                if let err = err {
                    print ("Error in getting Tastes: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        print ("query snapthop", document.data())
                        let t = Tastes(dictionary: document.data())
                        print("hi i am here \(String(describing: t)))")
                        
                        if (t != nil) {
                            tastes.append(t!)
                        }
                        //print("hi i am here \(document.documentID) => \(document.data())")
                        
                    }
                    print ("here is \(String(describing: tastes))")
                    
                    // if (tastes != nil) {
                    
                    //                let tastes1 = querySnapshot!.documents.compactMap { (document) -> Tastes? in
                    //                    if let model = Tastes(dictionary: document.data()) {
                    //                        return model
                    //                    } else {
                    //                        print("error parsing document: \(document.data())")
                    //                        return nil
                    //                    }
                    //                }
                    //                self.tastesArray = tastes1
                    //                //self.documents = snapshot.documents
                    self.tasteList = tastes
                    //print (self.tastesArray)
                    
                    self.tableView.reloadData()
                    //}
                    
                }
                
            }
            
        }
//        ref.collection("Users/Tastes").getDocuments() {(querySnapshot, err) in
//            if let err = err {
//                print ("Error getting documents: \(err))
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID)=>\(document.data()")
//                }
//            }
//        }
//        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
//            var newItems: [Tastes] = []
//            print(snapshot)
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                    let tasteItem = Tastes(snapshot: snapshot) {
//                    newItems.append(tasteItem)
//                }
//            }
//
//            self.tasteList = newItems
//            //self.tableView.reloadData()
//            print(self.tasteList)
//        })
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    @IBAction func signOutTapped(_ sender: Any) {
        //signout
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
