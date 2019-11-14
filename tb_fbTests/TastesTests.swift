//
//  TastesTests.swift
//  tb_fbTests
//
//  Created by Shveta Puri on 10/21/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import XCTest
@testable import tb_fb

class TastesTests: XCTestCase {
    
    var tasteObject:Tastes!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      //  let tasteObject = Tastes(dictionary: ["Name": "Foo", "Rating": "4", "Category": "Dishes"])
         tasteObject = Tastes(dictionary: ["Name": "Foo", "Rating": "4", "Category": "Dish"])
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        tasteObject = nil
    }
    //Test that taste object is created
    func test_Init_WhenGivenTasteObject_NotNil() {
       
        XCTAssertNotNil(tasteObject)

    }
    //Test that when name is not given, nil is returned
    func test_Init_WhenNotGivenName() {
         XCTAssertNil(Tastes(dictionary: ["Rating": "4", "Category": "Dish"]))
    }
    
    func test_Init_WhenNotGivenCategory() {
        XCTAssertNil(Tastes(dictionary: ["Name": "Foo", "Rating": "4"]))
    
    }
    
    func test_Init_WhenNotGivenRating() {
        XCTAssertNil(Tastes(dictionary: ["Name": "Foo", "Category": "Dish"]))
    }
    
    //test that value are setup correctly
    func test_Init_WhenGivenName_SetsValues() {
        
        XCTAssertEqual(tasteObject!.name, "Foo")

        // let TO =  try XCTUnwrap(tastObject)
       // XCTAssertFalse(TO.isEmpty)
    }
    
    func test_Init_WhenGivenRating_SetsValues() {
  
        XCTAssertEqual(tasteObject!.rating, "4")
    }

    func test_Init_WhenGivenCategory_SetsValues() {
        XCTAssertEqual(tasteObject!.category, "Dish")
        
    }
    
    func test_Init_WhenNotGivenAddress_SetsValues() {

        XCTAssertEqual(tasteObject!.address, "none")
    }
    
    func test_Init_WhenNotGivenRestaurant_SetsValues() {
 
        XCTAssertEqual(tasteObject!.restaurant, "none")
    }
    
    func test_Init_WhenNotGivenVineyardName_SetsValues() {

        XCTAssertEqual(tasteObject!.vineyardName, "none")
    }
    
    func test_Init_WhenNotGivenBrandName_SetsValues() {

        XCTAssertEqual(tasteObject!.brandName, "none")
    }

    func test_Init_WhenNotGivenType_SetsValues() {

        XCTAssertEqual(tasteObject!.type, "none")
    }
    
    func test_Init_WhenNotGivenNotes_SetsValues() {

        XCTAssertEqual(tasteObject!.comments, "none")
    }
    
    func test_Init_WhenNotGivenYear_SetsValues() {

        XCTAssertEqual(tasteObject!.year, "none")
    }
    
    //test to see that the optional values are accurate when set
    
    func test_Init_WhenGivenAddress_SetsValues() {
        tasteObject.address = "123 Test St"
        XCTAssertEqual(tasteObject!.address, "123 Test St")

    }
    
    func test_Init_WhenGivenRestaurant_SetsValues() {
        tasteObject.address = "Test Restaurant"
        XCTAssertEqual(tasteObject!.address, "Test Restaurant")
    }

    func test_Init_WhenGivenVineyardName_SetsValues() {
        tasteObject.vineyardName = "Test Vineyard"
        XCTAssertEqual(tasteObject!.vineyardName, "Test Vineyard")

    } //to do for brandname, type, comments, year
    
    
    //write tests for  init (name: String, category: String, rating: String) {
    //write tests for init (name: String, category: String, rating: String, restaurant: String? = nil, vineyardName: String? = nil, brandName: String? = nil, type: String? = nil, comments: String? = nil, year: String? = nil, address: String? = nil ) {
    


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
