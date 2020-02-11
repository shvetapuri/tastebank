//
//  TastesManager.swift
//  tb_fb
//
//  Created by Shveta Puri on 10/25/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import Foundation
import Firebase


class TastesManager {
    
    var tastesCount: Int {return tastesArray.count}
    var tastesArray: [Tastes] = []
    var tb_delegate: loadDataDelegate?

    func addTaste(Taste: Tastes ) {
        if !checkDuplicate(taste: Taste) {
            tastesArray.append(Taste)
           
        }
        
    }
    
    func addTasteToDB(TasteObj: Tastes, BypassCheckFlag: Bool) -> String{
        if (!checkDuplicate(taste: TasteObj) || BypassCheckFlag) {
            tastesArray.append(TasteObj)
           // if ((TasteObj.image) != nil) {
                //
           // }
            DataService.ds.createTasteEntryDB(TasteDict: TasteObj)
            return "success"
        } else {
            
            return "duplicate"
        }

    }

    func loadTastesFromDBToTastesArr() {

        DataService.ds.loadDBTastes{[weak self] (tastesArr: [Tastes]) in
                self?.tastesArray = tastesArr
            
            //delegate
            self?.tb_delegate?.dataWasLoaded()
            //notify the master view controller to reload table view
            //    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        }
        
    }
    
    func returnAllCategories() -> [String] {
        return ["Dish", "Dessert", "Chocolate", "Cheese", "Coffee", "Beer", "Wine", "Other"]
    }
    
   
    
    
    func getTaste(at index: Int) -> Tastes {
        return tastesArray[index]
    }
    
    func removeTaste(at index: Int) {
        tastesArray.remove(at: index)
    }
    
    func editTaste(at index: Int, taste: Tastes) {
        tastesArray.remove(at: index)
        tastesArray.insert(taste, at: index)
    }
    
    func checkDuplicate(taste: Tastes) -> Bool {
       return tastesArray.contains(taste)
    }
    
    func returnLabels(category: String) -> [String] {
        switch category {
        case "Dish", "Dessert":
            return ["Name", "Rating", "Restaurant", "Address",  "Notes"]
            
        case "Chocolate", "Cheese", "Coffee", "Beer", "Other":
            return ["Name", "Rating", "Brand name", "Type", "Notes"]
            
        case "Wine":
            return ["Name","Rating", "Vineyard name", "Type", "Year", "Notes" ]
            
        default:
            return ["Name", "Rating", "Restaurant", "Address",  "Notes"]
        }
    }
    
    func filterTastesByCategory(category: String) -> [Tastes] {
        var filteredTastes = [Tastes]()
        filteredTastes = tastesArray.filter({( taste: Tastes) -> Bool in
            return (taste.category!.contains(category))
        })
        return filteredTastes
    }
    
    func filterTastesByKeyword(searchText: String) -> [Tastes] {
        var filteredTastes = [Tastes]()
        filteredTastes = tastesArray.filter({( taste : Tastes) -> Bool in
            //return (searchAllValuesInTaste(searchString: searchText, taste: taste))
            return ((taste.dictionary).contains {(key, value) -> Bool in
                value!.lowercased().contains(searchText.lowercased()) })
        })
        return filteredTastes
    }
}

protocol loadDataDelegate {
    func dataWasLoaded()
}
