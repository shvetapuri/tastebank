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
    
    //var id: String?
    var name: String?
    var category: String?
    var rating: String?
    var restaurant: String?
    var vineyardName: String?
    var dictionary: [String: Any] {
        return [
            "name": name as Any,
            "category": category as Any,
            "rating": rating as Any,
            "restaurant": restaurant as Any? as Any,
            "vineyardName": vineyardName as Any? as Any
            //"id": id as Any
        ]
    }
    
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
        guard let name = dictionary["name"] as? String,
            let category = dictionary["category"] as? String,
            let rating = dictionary["rating"] as? String,
        let restaurant = (dictionary["Restaurant"] != nil) ? dictionary["Restaurant"] as? String : "none",
        let vineyardName = (dictionary["vineyard name"] != nil) ? dictionary["vineyard name"] as? String : "none"
           // let date = dictionary["timestamp"] as? Timestamp else { return nil }
        else { return nil}
    
        self.init(name: name, category: category, rating: rating, restaurant: restaurant, vineyardName: vineyardName)
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

