//
//  ViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/10/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit
import Firebase

class MasterViewController: UIViewController , loadDataDelegate, UIPopoverPresentationControllerDelegate {
   
    var categoryButtonTapped: Bool = false
    
    @IBOutlet weak var showAll: UIButton!
    
    let searchController = UISearchController(searchResultsController: nil)
    

    ///weak var delegate:updateRating?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarView: UIView!

    var tastesManager = TastesManager()
    
    var currentTaste: Tastes!
    var tasteList: [Tastes] = []
    var filteredTastes = [Tastes]()
    var filteredByCategory = [Tastes]()
    
    
    var user: User!
    var handle: AuthStateDidChangeListenerHandle?
    
    let filterButtons = ["Show All", "Dish", "Dessert", "Chocolate", "Cheese", "Coffee" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        tastesManager.tb_delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Setup the Search Controller
        
        setupSearchBar()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        } 
        //set up observer for table reload requests
     //   NotificationCenter.default.addObserver(self, selector: #selector(reloadTBV), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        //Get current user
        let user = Auth.auth().currentUser
        if let user = user {
            self.user = user
            print("user info")
            print(user.uid, user.email as Any, user.photoURL as Any)
            
            self.navigationItem.title = "Welcome \(String(describing: user.displayName))"
            
            //load data from firebase
            tastesManager.loadTastesFromDBToTastesArr()
           // tableView.reloadData()
            print("data is being reloaded from db")
            
        }
        self.searchController.searchBar.text = ""
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        searchController.dismiss(animated: false, completion: nil)
//    }
    
    func dataWasLoaded() {
        tableView.reloadData()
        
    }
    @IBAction func showAllButtonTapped(_ sender: Any) {
        categoryButtonTapped = false
        tableView.reloadData()
    }
    
    
//    @objc func reloadTBV(notification: NSNotification) {
//        tableView.reloadData()
//    }
    
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
    //filter by tastes by keyword
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredTastes = tastesManager.filterTastesByKeyword(searchText: searchText)
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
        // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "showAddVC"
        {
            let vc = segue.destination as? addViewTableViewController
          //  let add_vc = nav_vc?.topViewController as? addViewTableViewController
            vc?.tastesManager = self.tastesManager
            
        }
        if segue.identifier == "ShowPopOver" {
            
//            if let indexPath = tableView!.indexPathForSelectedRow as NSIndexPath?{
//
//                print("in segue")
//                let nc = segue.destination as! UINavigationController
//                let vc = nc.topViewController as! DetailTableViewController
//
//                if (tableView.cellForRow(at: indexPath as IndexPath) is TableViewCell_WithImage) {
//                    let cell_w_image = tableView.cellForRow(at: indexPath as IndexPath) as? TableViewCell_WithImage
//                    vc.tasteInfo = cell_w_image!.taste
//
//                }
//                else   {
//                     let cell = tableView.cellForRow(at: indexPath as IndexPath) as? TableViewCell
//                    vc.tasteInfo = cell!.taste
//                }
//
//                if searchController.isActive {
//                    self.searchController.dismiss(animated: false) {
//                        // Do what you want here like perform segue or present
//
//                    }
//                }
//
//                vc.tastesManager = self.tastesManager
//
//
//            }
        }
     }
 }


extension MasterViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.black
        // searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.searchBarStyle = .minimal
        // searchController.searchBar.barTintColor = UIColor.clear
        
        
        searchController.searchBar.placeholder = "Search Tastes"
        
        //   let frame = CGRect(x: 0, y: 0, width: 100, height: 64)
        //   searchController.searchBar.frame = frame
        
        searchBarView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        searchBarView.addSubview(searchController.searchBar)
        definesPresentationContext = true
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filteredTastes = tasteList.filter({$0.prefix(searchText.count) == searchText})
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
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
        return 197
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taste: Tastes
        if isFiltering() {
            taste = filteredTastes[indexPath.row]
        } else if (categoryButtonTapped) {
            //categoryButtonTapped = false
            taste = filteredByCategory[indexPath.row]

        } else {
            // taste = tasteList[indexPath.row]
            taste = tastesManager.tastesArray[indexPath.row]
            
        }

        if (taste.image != nil) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_w_image") as! TableViewCell_WithImage
            let rv = cell.viewWithTag(123) as! ratingView
            cell.configureCell(taste: taste, tastesManager: tastesManager, ratingView: rv)
            //delegate?.createStars(rating: "5")

            tableView.beginUpdates()
            tableView.setNeedsDisplay()
            tableView.endUpdates()
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            let rv = cell.viewWithTag(124) as! ratingView

            cell.configureCell(taste: taste, tastesManager: tastesManager, ratingView: rv)
            
            tableView.beginUpdates()
            tableView.setNeedsDisplay()
            tableView.endUpdates()
            
            
            return cell
        }
        }
//        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//            return .none
//        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
//        if isFiltering() {
//            currentTaste = filteredTastes[indexPath.row]
//        } else if (categoryButtonTapped) {
//            //categoryButtonTapped = false
//            currentTaste = filteredByCategory[indexPath.row]
//
//        } else {
            // taste = tasteList[indexPath.row]
        
        if let view = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as? DetailTableViewController {
                
               // let nc = UINavigationController(rootViewController: view)
        
                view.tastesManager = self.tastesManager
            
             if (tableView.cellForRow(at: indexPath as IndexPath) is TableViewCell_WithImage) {
                                let cell_w_image = tableView.cellForRow(at: indexPath as IndexPath) as? TableViewCell_WithImage
                                view.tasteInfo = cell_w_image!.taste
            
                            }
                            else   {
                                 let cell = tableView.cellForRow(at: indexPath as IndexPath) as? TableViewCell
                                view.tasteInfo = cell!.taste
                            }
     
        
            
         //   view.tasteInfo = cell.taste
            
                let nc = UINavigationController(rootViewController: view)
                                
                if(searchController.isActive) {
                  //  searchController.isActive = false
                    searchController.present(nc, animated: true, completion: nil)

                } else {
                    self.present(nc, animated: true, completion: nil)
                }
              }
       
 }
    

}
extension MasterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       //return tastesManager.returnAllCategories().count
        return filterButtons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : CollectionViewCell
        
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        let category = filterButtons[indexPath.row]

        
        if (indexPath == [0,0]) {
            print ("indexpath", indexPath)
            cell.isSelected = true

            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            
            cell.selected()
        } else {
            cell.deselected()
        }
        
        //cell.configureCollectionCell(tastesManager.returnAllCategories()[indexPath.row])
        cell.configureCollectionCell(category)
       
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        
        //let category =  tastesManager.returnAllCategories()[indexPath.row]
        let category = filterButtons[indexPath.row]
        if (category != "Show All") {
            categoryButtonTapped = true
            filteredByCategory = tastesManager.filterTastesByCategory(category: category )
        } else {
            categoryButtonTapped = false
        }
        cell?.selected()
        tableView.reloadData()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            cell.deselected()
        }
    }
    
    
}
