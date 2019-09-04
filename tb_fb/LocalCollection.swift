//
//  LocalCollection.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/22/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import FirebaseFirestore

// A type that can be initialized from a Firestore document.
protocol DocumentSerializable {
    init?( dictionary: [String: Any])
   // init?( dictionaryRestaurant: [String: Any] )
}
