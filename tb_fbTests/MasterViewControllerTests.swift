//
//  MasterViewControllerTests.swift
//  tb_fbTests
//
//  Created by Shveta Puri on 10/24/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import XCTest
@testable import tb_fb

class MasterViewControllerTests: XCTestCase {

    var sut: MasterViewController!
    var tableView: UITableView!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: "MasterViewController")
        sut = viewController as? MasterViewController
        
        //triggers call to view did load
        sut.loadViewIfNeeded()
        sut.tastesManager = TastesManager()
        
        tableView = sut.tableView
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TableViewIsNotNilAfterViewDidLoad() {
        
      
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_TableView_LoadingView_SetsTableViewDataSource() {
          XCTAssertTrue(sut.tableView.dataSource is MasterViewController)

    }
    
    func test_TableView_LoadingView_SetsTableViewDelegate() {
          XCTAssertTrue(sut.tableView.delegate is MasterViewController)
    }
    
    func test_TableView_NumberOfSections_IsOne() {
        let numberOfSections = sut.tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_TableView_NumberOfRows_IsTasteCount() {
    
        //add tastes
        sut.tastesManager.addTaste(Taste: Tastes(name: "foo", category: "cat", rating: "5"))
        //get tastes count from tastesmanager
        XCTAssertEqual(tableView.numberOfRows(inSection:0),1)
        sut.tastesManager.addTaste(Taste: Tastes(name: "bar", category: "cat", rating: "5"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection:0),2)


        
    }

    func test_CellForRow_ReturnsCustomTableViewCell() {
        sut.tastesManager.addTaste(Taste: Tastes(name: "foo", category: "cat", rating: "5"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TableViewCell)
    }
    
    func test_CellForRow_CallsConfigureCell() {
        sut.tastesManager.addTaste(Taste: Tastes(name: "foo", category: "cat", rating: "5"))
        tableView.reloadData()
        
        
    }
//    func test_CellForRow_DequeueCellFromTableView() {
//        let mockTableView = MockTableView()
//        mockTableView.dataSource = sut
//        mockTableView.register(MockCell.self, forCellReuseIdentifier: "mockcell")
//
//        sut.tastesManager?.addTaste(Taste: Tastes(name: "foo", category: "cat", rating: "5"))
//
//        mockTableView.reloadData()
//
//
//        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
//
//
//        XCTAssertTrue(mockTableView.cellGotDequeued)
//    }
//
//    func test_CellForRow_CallsConfigCell() {
//
//        let mockTableView = MockTableView()
//        mockTableView.dataSource = sut
//        mockTableView.register(
//            MockCell.self,
//            forCellReuseIdentifier: "cell")
//
//
//         sut.tastesManager?.addTaste(Taste: Tastes(name: "foo", category: "cat", rating: "5"))
//        mockTableView.reloadData()
//
//
//        let cell = mockTableView
//            .cellForRow(at: IndexPath(row: 0, section: 0)) as! MockCell
//
//
//        XCTAssertTrue(cell.configCellGotCalled)
//    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension MasterViewControllerTests {
    
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        
        override func dequeueReusableCell(
            withIdentifier identifier: String,
            for indexPath: IndexPath) -> UITableViewCell {
            
            
            cellGotDequeued = true
            
            
            return super.dequeueReusableCell(withIdentifier: identifier,
                                             for: indexPath)
        }
        
         func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "mockcell",
                for: indexPath)
            
            
            return cell
        }
        
    }
    
    class MockCell: TableViewCell {
        var configCellGotCalled = false
        func configCell(with item: Tastes) {
            configCellGotCalled = true
        }
    }
}
