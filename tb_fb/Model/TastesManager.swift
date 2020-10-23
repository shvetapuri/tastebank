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
            
           // if ((TasteObj.image) != nil) {
                //
           // }
            let id = DataService.ds.createTasteEntryDB(TasteDict: TasteObj)
            var tasteObjWithID = TasteObj
            tasteObjWithID.id = id
            tastesArray.append(tasteObjWithID)

            self.tb_delegate?.dataWasLoaded()
            return "success"
        } else {
            
            return "duplicate"
        }

    }

   
        
    func editTasteInDB(tasteObj: Tastes, textFieldData: [String: Any]) {
        
        //take the edited data in the taste dictionary and convert it to a taste object
        //create a new taste object with the edited data, and set its ID to the old object
        
        var newTasteObject = (tasteObj.image != nil) ? Tastes(dictionary: textFieldData, image: tasteObj.image! ) : Tastes(dictionary: textFieldData)
        newTasteObject?.id = tasteObj.id
        
        //replace the original object with the editted object
        print("here is the index of taste",  tastesArray.index(of: tasteObj)!)
        tastesArray[tastesArray.index(of: tasteObj)!] = newTasteObject!
        
//        for taste in tastesArray {
//            if taste == tasteObj {
//                tastesArray[tastesArray.index(of: taste)!] = newTasteObject
//            }
//        }
        
        if (newTasteObject?.getID() != "") {
            DataService.ds.EditTasteEntryDB(TasteDict: tasteObj, ID: (newTasteObject?.getID())!)
            // tastesArray.append(TasteObj)
            self.tb_delegate?.dataWasLoaded()
           
        } else {
            print ("Error, no ID found for the taste entry")
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
            
        case "Chocolate", "Cheese", "Coffee", "Beer":
            return ["Name", "Rating", "Brand name", "Type", "Notes"]
            
        case "Wine":
            return ["Name","Rating", "Vineyard name", "Type", "Year", "Notes" ]
            
        case "Other":
            return ["Name", "Rating", "Brand name", "Category", "Notes"]
            
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
