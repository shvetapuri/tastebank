//
//  SearchViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/19/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var categoryButtons: [UIButton]!
    var categoryButtonTapped: Bool = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    
    
    var tasteList: [Tastes] = []
    var filteredTastes = [Tastes]()
    var filteredByCategory = [Tastes]()
    
    var user: User!
    var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Setup the Search Controller
        searchController.delegate = self as? UISearchControllerDelegate
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Tastes"
        searchController.searchBar.tintColor = UIColor.clear
        searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barTintColor = UIColor.clear
        searchBarView.addSubview(searchController.searchBar)
        
    
        definesPresentationContext = true

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        
        let user = Auth.auth().currentUser
        if let user = user {
            self.user = user
            print("user info")
            print(user.uid, user.email!, user.photoURL!)
            
            loadData(user: self.user)
            
            
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
                    
                }
                print ("here is \(String(describing: tastes))")
                               
                self.tasteList = tastes
                self.tableView.reloadData()
   
            }
            
        }
        
    }
    
    //Search Bar
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    //filter by taste name
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredTastes = tasteList.filter({( taste : Tastes) -> Bool in
            //return (searchAllValuesInTaste(searchString: searchText, taste: taste))
            return ((taste.dictionary).contains {(key, value) -> Bool in
                value!.lowercased().contains(searchText.lowercased()) })
        })
        //taste.name!.lowercased().contains(searchText.lowercased()) || taste.category!.lowercased().contains(searchText.lowercased()) || taste.restaurant!.lowercased().contains(searchText.lowercased()) ||
        //taste.vineyardName!.lowercased().contains(searchText.lowercased())
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchAllValuesInTaste ( searchString: String, taste: Tastes) -> Bool {
        for (_,value) in taste.dictionary {
            if (value!.lowercased().contains(searchString.lowercased())) {
                return true
            }
        }
        return false
    }
    
    //Collection of buttons
    
    @IBAction func categoryButtonsTapped(_ sender: UIButton) {
        let btnTitle = sender.currentTitle!
        if (btnTitle != "Show All") {
            categoryButtonTapped = true
            filteredByCategory = tasteList.filter({( taste: Tastes) -> Bool in
                return (taste.category!.lowercased().contains(btnTitle.lowercased()))
        })
        } else {
            categoryButtonTapped = false
        }
        print ("fbc starts \(filteredByCategory)")
        tableView.reloadData()
    }
    
    //Table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredTastes.count
        } else if (categoryButtonTapped) {
            return filteredByCategory.count
        }
        return tasteList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var taste: Tastes
//        
//        if isFiltering() {
//            taste = filteredTastes[indexPath.row]
//        } else if (categoryButtonTapped) {
//            categoryButtonTapped = false
//            taste = filteredByCategory[indexPath.row]
//        } else {
//            taste = tasteList[indexPath.row]
//        }
        
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell {
           // cell.configureCell(taste: taste)
            return cell
        } else {
            return TableViewCell()
        }
        
    }
    
    
    
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filteredTastes = tasteList.filter({$0.prefix(searchText.count) == searchText})
        filterContentForSearchText(searchController.searchBar.text!)

    }
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
