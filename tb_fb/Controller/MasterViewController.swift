//
//  ViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/10/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit
import Firebase

class MasterViewController: UIViewController  {
   
    

    var categoryButtonTapped: Bool = false
    
    @IBOutlet weak var showAll: UIButton!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarView: UIView!
    
    var tastesManager = TastesManager()
    
    var tasteList: [Tastes] = []
    var filteredTastes = [Tastes]()
    var filteredByCategory = [Tastes]()
    
    var user: User!
    var handle: AuthStateDidChangeListenerHandle?
    
    let sectionInsets = UIEdgeInsets(top: 1.0,
                                     left: 1.0,
                                     bottom: 1.0,
                                     right: 1.0)
    
 //   static let notificationName = Notification.Name("notificationReloadTBV")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Setup the Search Controller
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Tastes"
        searchBarView.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTBV), name: NSNotification.Name(rawValue: "load"), object: nil)

        let user = Auth.auth().currentUser
        if let user = user {
            self.user = user
            print("user info")
            print(user.uid, user.email as Any, user.photoURL as Any)
            
            
            self.navigationItem.title = "Welcome \(String(describing: user.email))"
            
            //load data from firebase
            tastesManager.loadTastesFromDBToTastesArr()
            
            
        }
    }
    
    @IBAction func showAllButtonTapped(_ sender: Any) {
        categoryButtonTapped = false
        tableView.reloadData()
    }
    
    
    @objc func reloadTBV(notification: NSNotification) {
        tableView.reloadData()
    }
    @IBAction func signOutTapped(_ sender: Any) {
        //signout
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            let homeViewController = storyboard?.instantiateViewController(withIdentifier: ConstantVal.Storyboard.homeViewController) as? SignInViewController
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
            
            self.dismiss(animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    
    //Search Bar
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    //filter by taste name
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredTastes = tastesManager.filterTastesByKeyword(searchText: searchText)
        
        //taste.name!.lowercased().contains(searchText.lowercased()) || taste.category!.lowercased().contains(searchText.lowercased()) || taste.restaurant!.lowercased().contains(searchText.lowercased()) ||
        //taste.vineyardName!.lowercased().contains(searchText.lowercased())
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
//    func searchAllValuesInTaste ( searchString: String, taste: Tastes) -> Bool {
//        for (_,value) in taste.dictionary {
//            if (value!.lowercased().contains(searchString.lowercased())) {
//                return true
//            }
//        }
//        return false
//    }
    
    //Collection of buttons
    
//    @IBAction func categoryButtonsTapped(_ sender: UIButton) {
//        let btnTitle = sender.currentTitle!
//        if (btnTitle != "Show All") {
//            categoryButtonTapped = true
//            filteredByCategory = tasteList.filter({( taste: Tastes) -> Bool in
//                return (taste.category!.lowercased().contains(btnTitle.lowercased()))
//            })
//        } else {
//            categoryButtonTapped = false
//        }
//        print ("fbc starts \(filteredByCategory)")
//        tableView.reloadData()
//    }
    

        // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.destination is AddViewController
        {
            let vc = segue.destination as? AddViewController
            vc?.tastesManager = self.tastesManager
        }
     }
 
    
}

extension MasterViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filteredTastes = tasteList.filter({$0.prefix(searchText.count) == searchText})
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredTastes.count
        } else if (categoryButtonTapped) {
            return filteredByCategory.count
        }
        // return tasteList.count
        return tastesManager.tastesCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taste: Tastes
        
        if isFiltering() {
            taste = filteredTastes[indexPath.row]
        } else if (categoryButtonTapped) {
            categoryButtonTapped = false
            taste = filteredByCategory[indexPath.row]
        } else {
            // taste = tasteList[indexPath.row]
            taste = tastesManager.tastesArray[indexPath.row]
            
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell {
            cell.configureCell(taste: taste, tastesManager: tastesManager)
            
            
            return cell
        } else {
            return TableViewCell()
        }
        
    }
    

}
extension MasterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return tastesManager.returnAllCategories().count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : CollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        //cell.collectionCellButton.setTitle(tastesManager.returnAllCategories()[indexPath.row], for: .normal)
        
            cell.collectionCellLabel.text = tastesManager.returnAllCategories()[indexPath.row]
        cell.configureCollectionCell(tastesManager.returnAllCategories()[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category =  tastesManager.returnAllCategories()[indexPath.row]
    
        categoryButtonTapped = true
        filteredByCategory = tastesManager.filterTastesByCategory(category: category )
            print ("I am in didselect, here is cat \(category), filteredBycat \(filteredByCategory)")
        tableView.reloadData()
    }
    
    //flow layout
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //2
//        let paddingSpace = sectionInsets.left * (3 + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / 3
//
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
    
    //3
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    // 4
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//
}
