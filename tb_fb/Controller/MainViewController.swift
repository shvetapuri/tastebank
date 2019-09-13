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
                
                DB_BASE.collection("Users/\(user.uid)/Tastes").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                        }
                    }
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
