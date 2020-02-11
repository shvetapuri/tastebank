//
//  TastesManagerTests.swift
//  tb_fbTests
//
//  Created by Shveta Puri on 10/25/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import XCTest
@testable import tb_fb

class TastesManagerTests: XCTestCase {

    var sut: TastesManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = TastesManager()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TasteCount_Initially_IsZero() {
        
        XCTAssertEqual(sut.tastesCount, 0)
    }
    
    func test_AddItems_IncreasesTastesCountToOne() {
        let addedTaste = Tastes(name: "Foo", category: "Dish", rating: "4" )
        sut.addTaste(Taste: addedTaste)
        
        XCTAssertEqual(sut.tastesCount, 1)

    }
    
    func test_getTasteAt_ReturnsAddedTaste() {
        let addedTaste = Tastes(name: "test", category: "cat", rating: "7")
        
        sut.addTaste(Taste: addedTaste)
        let returnedTaste = sut.getTaste(at: 0)
        
        XCTAssertEqual(returnedTaste, addedTaste)
    }
    
    func test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount() {
        let addedTaste = Tastes(name: "test", category: "cat", rating: "7")
        
        sut.addTaste(Taste: addedTaste)
        sut.addTaste(Taste: addedTaste)

        XCTAssertEqual(sut.tastesCount, 1)
    }
    func test_getTasteAt_multipleTastes_ReturnsAddedTastes() {
        let addedTaste = Tastes(name: "test", category: "cat", rating: "5")
        let addedTaste2 = Tastes(name: "test1", category: "categoryTest", rating: "4", restaurant: "", vineyardName: "Coppola", brandName: "", type: "", comments: "", year: "", address: "" )
        let addedTaste3 = Tastes(dictionary: ["Name": "Foo", "Rating": "4", "Category": "Dish", "Address": "123 Main St.", "Restaurant": "TestRestaurant", "Notes": "Order Foo with Bar"])
        
        sut.addTaste(Taste: addedTaste)
        sut.addTaste(Taste: addedTaste2)
        sut.addTaste(Taste: addedTaste3!)
        
        XCTAssertEqual(sut.tastesCount, 3)

        let returnedTaste1 = sut.getTaste(at: 0)

        XCTAssertEqual(returnedTaste1, addedTaste)
        
        let returnedTaste2 = sut.getTaste(at: 1)

        XCTAssertEqual(returnedTaste2, addedTaste2)
        
        let returnedTaste3 = sut.getTaste(at: 2)

        XCTAssertEqual(returnedTaste3, addedTaste3)

        
    }
    
    func test_removeTaste_CheckArrayCount () {
        let addedTaste = Tastes(name: "test", category: "cat", rating: "5")
        sut.addTaste(Taste: addedTaste)
        let addedTaste2 = Tastes(name: "test1", category: "categoryTest", rating: "4", restaurant: "", vineyardName: "Coppola", brandName: "", type: "", comments: "", year: "", address: "" )
        sut.addTaste(Taste: addedTaste2)

        XCTAssertEqual(sut.tastesCount, 2, "Check count before removing taste")

        sut.removeTaste(at: 0)
        
        XCTAssertEqual(sut.tastesCount, 1, "Count after removing taste")

        
    }
    
    func test_editTaste_ReturnsEdittedTaste() {
        let addedTaste = Tastes(name: "test", category: "cat", rating: "5")
        sut.addTaste(Taste: addedTaste)

        let edittedTaste = Tastes(name: "editedTastes", category: "cat2", rating: "2")

        sut.editTaste(at: 0, taste: edittedTaste )
        
        let returnedTaste = sut.getTaste(at: 0)
        
        XCTAssertEqual(edittedTaste, returnedTaste)
    }
    
    func test_tasteExists_ReturnsTrueForDuplicate() {
        let addedTaste = Tastes(name: "test", category: "cat", rating: "5")
        sut.addTaste(Taste: addedTaste)
        
        let newAddedTaste = Tastes(name: "test", category: "cat", rating: "5")
        
        XCTAssertTrue(sut.checkDuplicate(taste: newAddedTaste))

    }
    
    func test_tasteExists_ReturnsFalseNotDuplicate() {
        let addedTaste = Tastes(name: "test", category: "cat", rating: "5")
        sut.addTaste(Taste: addedTaste)
        
        let newAddedTaste = Tastes(name: "testEditted", category: "cat", rating: "5")
        
        
        XCTAssertFalse(sut.checkDuplicate(taste: newAddedTaste))

    }
    
    func test_returnLabels() {
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
