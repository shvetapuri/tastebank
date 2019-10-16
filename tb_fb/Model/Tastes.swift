//
//  Tastes.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/16/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import Foundation
import Firebase

struct Tastes {

    var name: String?
    var category: String?
    var rating: String?
    var restaurant: String?
    var vineyardName: String?
    var brandName: String?
    var type: String?
    var comments: String?
    var year: String?
    var address: String?
    var dictionary: [String: String?] {
        return [
            "Name": name,
            "Category": category,
            "Rating": rating,
            "Restaurant": restaurant, // as Any? as Any,
            "Vineyard name": vineyardName,
            "Brand name": brandName,
            "Type": type,
            "Notes": comments,
            "Year": year,
            "Address": address
        ]
    }
    
    func returnLabels() -> [String] {
        switch category {
        case "Dish", "Dessert":
            return ["Name", "Restaurant", "Address", "Rating", "Notes"]
        
        case "Chocolate", "Cheese", "Coffee", "Beer":
            return ["Name", "Brand name", "Type", "Rating", "Notes"]
        
        case "Wine":
            return ["Name", "Vineyard name", "Year", "Type", "Rating", "Notes" ]
        
        case "Other":
            return ["Name", "Brand name", "Type", "Rating", "Notes"]

        default:
            return []
        }
    }
    
}



extension Tastes: DocumentSerializable {
    init?( dictionary: [String : Any]) {
        //guard let id = id as? String,
        guard let name = dictionary["Name"] as? String,
            let category = dictionary["Category"] as? String,
            let rating = dictionary["Rating"] as? String,
            let address = (dictionary["Address"] != nil) ? dictionary["Address"] as? String : "none",
            let restaurant = (dictionary["Restaurant"] != nil) ? dictionary["Restaurant"] as? String : "none",
            let vineyardName = (dictionary["Vineyard name"] != nil) ? dictionary["Vineyard name"] as? String : "none",
            let brandName = (dictionary["Brand name"] != nil) ? dictionary["Brand name"] as? String : "none",
            let type = (dictionary["Type"] != nil) ? dictionary["Type"] as? String : "none",
            let comments = (dictionary["Notes"] != nil) ? dictionary["Notes"] as? String : "none",
            let year = (dictionary["Year"] != nil) ? dictionary["Year"] as? String : "none"
           // let date = dictionary["timestamp"] as? Timestamp else { return nil }
        
        else {
            print("Error, Tastes struct was not created for this entry")
            return nil}
//        let restaurant = "none"
//        let vineyardName = "none"
//        let brandName = "none"
//        let type = "none"
//        let comments = "none"
//        let year = "none"
       // let address = "none"
        
        self.init(name: name, category: category, rating: rating, restaurant: restaurant, vineyardName: vineyardName, brandName: brandName, type: type, comments: comments, year: year, address: address)
    }
    
//    init? (snapshot: DataSnapshot) {
//        //guard let id = id as? String,
//        guard let value = snapshot.value as? [String: AnyObject],
//            let name = value["Name"] as? String,
//            let category = value["Category"] as? String,
//            let rating = value["Rating"] as? String,
//            let restaurant = (value["Restaurant"] != nil) ? value["Restaurant"] as? String : "none",
//            let vineyardName = (value["vineyard name"] != nil) ? value["vineyard name"] as? String : "none"
//            // let date = dictionary["timestamp"] as? Timestamp else { return nil }
//            else { return nil}
//
//        self.init(name: name, category: category, rating: rating, restaurant: restaurant, vineyardName: vineyardName)
//    }

    
//    init?(dictionaryRestaurant: [String: Any] ) {
//        //guard let id = id as? String,
//        guard let name = dictionaryRestaurant["Name"] as? String,
//            let category = dictionaryRestaurant["Category"] as? String,
//            let rating = dictionaryRestaurant["Rating"] as? String,
//            let restaurant = dictionaryRestaurant["Restaurant"] as? String
//            // let date = dictionary["timestamp"] as? Timestamp else { return nil }
//            else { return nil}
    
       // self.init(name: name, category: category, rating: rating, restaurant: restaurant)
   // }

    
    }
//}
   // self.init(name: name,categoryName: categoryName, id: id, rating: rating)

