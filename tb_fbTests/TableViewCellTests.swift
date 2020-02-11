//
//  TableViewCellTests.swift
//  tb_fbTests
//
//  Created by Shveta Puri on 10/29/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import XCTest
@testable import tb_fb


class TableViewCellTests: XCTestCase {

    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: TableViewCell!
    let tasteManagerMock = TastesManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: "MasterViewController") as! MasterViewController
        
        //triggers call to view did load
        viewController.loadViewIfNeeded()
        //viewController.tastesManager = TastesManager()
        
        tableView = viewController.tableView
        tableView.dataSource = dataSource
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell",  for: IndexPath(row: 0, section: 0)) as? TableViewCell
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_ConfigureCell_ConfirmCreatedLabelsEqualNeededLabels() {
        cell.configureCell(taste: Tastes(name: "foo", category: "Dish", rating: "3"), tastesManager: tasteManagerMock)
        
       
        
        XCTAssertEqual( cell.vStackView.subviews.count, tasteManagerMock.returnLabels(category: "Dish").count*2)
        
    }
    

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension TableViewCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath)
            -> UITableViewCell {
                return UITableViewCell()
        }
    }
    

}

