//
//  MasterTableViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/16/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit
import Firebase


class MasterTableViewController: UITableViewController {
    var db: Firestore!
    var tastesArray: [Tastes] = []
    let searchController = UISearchController(searchResultsController: nil)
    var user: User!
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = user
            
//
//            
//            self.db = Firestore.firestore()
//            self.loadData(user: user)
//            
        }
        print("FOUND",user)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
        
//        // 1
//        let user = Auth.auth().currentUser!
//        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
//
//        // 2
//        onlineRef.removeValue { (error, _) in
//
//            // 3
//            if let error = error {
//                print("Removing online failed: \(error)")
//                return
//            }
//
//            // 4
//            do {
//                try Auth.auth().signOut()
//                self.dismiss(animated: true, completion: nil)
//            } catch (let error) {
//                print("Auth sign out failed: \(error)")
//            }
//        }
        
        
    }
    func loadData( user: User) {
        if let name = user.email {
            self.navigationItem.title = "Welcome \(name)"
            print (" found!!!! \(name)")
        }
        
        db.collection("Users/\(user)/Tastes").getDocuments() { (querySnapshot, err) in
            var tastes = [Tastes] ()
            if let err = err {
                print ("Error in getting Tastes: \(err)")
            
            } else {
                for document in querySnapshot!.documents {
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
                    self.tastesArray = tastes
                    print (self.tastesArray)
                
                    self.tableView.reloadData()
                //}
            
            }

            }
        
        }
        
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tastesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        
        let taste = tastesArray[indexPath.row]
        
        cell.textLabel?.text = taste.name
        print("Array is populated \(tastesArray)")
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MasterTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}
