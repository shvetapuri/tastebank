//
//  Tastes.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/16/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import Foundation
import Firebase

struct Tastes : Equatable{

    var name: String?
    var category: String?
    var rating = "1"
    var restaurant: String?
    var vineyardName: String?
    var brandName: String?
    var type: String?
    var comments: String?
    var year: String?
    var address: String?
    var image: Data?
    var id = ""
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
            "Address": address,
        ]
    }
    
    var dictionaryImage: [String: Any?] {
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
            "Address": address,
            "image": image
        ]}
    
    
    func getImage() -> Data? {
        if (image != nil) {
            return image!
        } else {
            return nil
        }
        
    }
    
    func getID() -> String {
        return id
    }
    mutating func setImage(imageToSave: Data) {
        self.image = imageToSave
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
           // let image = (dictionary["image"] != nil) ? dictionary["image"] as? Data : nil
           // let date = dictionary["timestamp"] as? Timestamp else { return nil }
        
        else {
            print("Error, Tastes struct was not created for this entry")
            return nil}
        
        self.init(name: name, category: category, rating: rating, restaurant: restaurant, vineyardName: vineyardName,  brandName: brandName, type: type, comments: comments, year: year, address: address, image: dictionary["image"] as? Data)
    }
    
    init?( dictionary: [String : Any], image: Data) {
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
            
            else {
                print("Error, Tastes struct was not created for this entry")
                return nil}
        
        self.init(name: name, category: category, rating: rating, restaurant: restaurant, vineyardName: vineyardName, brandName: brandName, type: type, comments: comments, year: year, address: address, image: image)
        
    }
        
    init (name: String, category: String, rating: String) {
        self.name = name
        self.category = category
        self.rating = rating
        self.restaurant = "none"
        self.vineyardName = "none"
        self.brandName = "none"
        self.type = "none"
        self.comments = "none"
        self.year = "none"
        self.address = "none"
        
    }
    init (name: String, category: String, rating: String, restaurant: String? = nil, vineyardName: String? = nil, brandName: String? = nil, type: String? = nil, comments: String? = nil, year: String? = nil, address: String? = nil , image: Data? = nil) {
        
         self.name = name
         self.category = category
         self.rating = rating
         self.restaurant = restaurant
         self.vineyardName = vineyardName
         self.brandName = brandName
         self.type = type
         self.comments = comments
         self.year = year
         self.address = address
         self.image = image
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

