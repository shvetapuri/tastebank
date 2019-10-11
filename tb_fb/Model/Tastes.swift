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
    
    //var dishes: [Dish]
    //var id: String?
    var name: String?
    var category: String?
    var rating: String?
    var restaurant: String?
    var vineyardName: String?
    var brandName: String?
    var type: String?
    var comments: String?
    var dictionary: [String: String?] {
        return [
            "Name": name,
            "Category": category,
            "Rating": rating,
            "Restaurant": restaurant, // as Any? as Any,
            "Vineyard name": vineyardName,
            "Brand name": brandName,
            "Type": type,
            "Comments": comments
        ]
    }
    
//    func returnLabels () -> [String] {
//        return
//    }
//
    func returnLabels() -> [String] {
        switch category {
        case "Dish":
            return ["Name", "Restaurant", "Rating"]
        
        case "Chocolate":
            return ["Name", "Brand name", "Type", "Rating"]
        default:
            return []
        }
    }
    
    func setLabels(inputValues:[String: String]) {
        
    }
//    var dishDict: [String: String?] {
//        return ["Name": name, "Restaurant": restaurant, "Rating": rating]
//    }
//
//    var chocDict: [String: String?] {
//        return ["Name": name, "Brand Name": brandName, "Type": type, "Rating": rating]
//    }
   
//    var dictionaryRestaurant: [String: Any] {
//        return [
//            "name": name as Any,
//            "category": category as Any,
//            "rating": rating as Any,
//            "restaurant": restaurant as Any?,
//            //"id": id as Any
//        ]
//    }
    
}



extension Tastes: DocumentSerializable {
    init?( dictionary: [String : Any]) {
        //guard let id = id as? String,
        guard let name = dictionary["Name"] as? String,
            let category = dictionary["Category"] as? String,
            let rating = dictionary["Rating"] as? String,
        let restaurant = (dictionary["Restaurant"] != nil) ? dictionary["Restaurant"] as? String : "none",
        let vineyardName = (dictionary["Vineyard name"] != nil) ? dictionary["Vineyard name"] as? String : "none",
        let brandName = (dictionary["Brand name"] != nil) ? dictionary["Brand name"] as? String : "none",
        let type = (dictionary["Type"] != nil) ? dictionary["Type"] as? String : "none",
            let comments = (dictionary["Comments"] != nil) ? dictionary["Comments"] as? String : "none"
           // let date = dictionary["timestamp"] as? Timestamp else { return nil }
        else {
            print("Error, Tastes struct was not created for this entry")
            return nil}
    
        self.init(name: name, category: category, rating: rating, restaurant: restaurant, vineyardName: vineyardName, brandName: brandName, type: type, comments: comments)
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

