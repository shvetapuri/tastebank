//
//  addViewControllerTests.swift
//  tb_fbTests
//
//  Created by Shveta Puri on 10/29/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import XCTest
@testable import tb_fb

class addViewControllerTests: XCTestCase {
    var sut: AddViewController!
    var textfieldArray: [UITextField]!
    var labelArray: [UILabel]!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "AddViewController")
            as? AddViewController
        
        
        sut.tastesManager = TastesManager()
        
        sut.loadViewIfNeeded()

         textfieldArray = [sut.addView.text1 , sut.addView.text2, sut.addView.text3, sut.addView.text4, sut.addView.text5, sut.addView.text6]
         labelArray = [sut.addView.l1, sut.addView.l2, sut.addView.l3, sut.addView.l4, sut.addView.l5, sut.addView.l6]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AddView_HasAllTextFields() {
        
        for i in 0...textfieldArray.count-1 {
            let textFieldIsSubView = textfieldArray[i].isDescendant(of: sut.view)
            XCTAssertTrue(textFieldIsSubView)
        }
    }
    
    func test_AddView_HasAllLabels() {
        
        for i in 0...labelArray.count-1 {
            let labelIsSubView = labelArray[i].isDescendant(of: sut.view)
            XCTAssertTrue(labelIsSubView)
        }
    }
    
    func test_AddView_setUsedLabelArray_WhenTwoLabelsAreNeeded_ReturnsTwoLabels() {
        //tell method 2 labels are needed
        sut.addView.setUsedLabelArray(countOfNeededLabels: 2)
        
        XCTAssertEqual(sut.addView.usedlabelsArray.count, 2, "Used labels array should be 2 ")
        
    }
    
    func test_AddView_setUsedLabelArray_WhenUsedLabelsArrayEmpty_CheckAllLabelsHidden() {
        //tell method 2 labels are needed
        sut.addView.setUsedLabelArray(countOfNeededLabels: 2)
        
        for i in 0...labelArray.count-1 {
            XCTAssertTrue(labelArray[i].isHidden, "label \(i) should be hidden")
        }

    }
    
    func test_AddView_setUsedLabelArray_WhenUsedLabelsArrayIsNotEmpty_CheckUsedLabelCount() {
        //put all labels in the usedlabelsarray
        sut.addView.usedlabelsArray = labelArray
        
        //call method that should clear out the used labels array and reset it to have 3 labels
        sut.addView.setUsedLabelArray(countOfNeededLabels: 3)

        XCTAssertEqual(sut.addView.usedlabelsArray.count, 3, "Used labels array should be 3")

    }
    
    func test_AddView_setUsedLabelArray_WhenUsedLabelsArrayIsNotEmpty_CheckAllLabelsHidden() {
        
        //put all labels in the usedlabelsarray
        sut.addView.usedlabelsArray = labelArray
        //unhide labels to simulate labels being displayed
        for i in 0...labelArray.count-1 {
            labelArray[i].isHidden = false
        }
        
        //tell method 4 labels are needed , make sure all the labels are hidden at end of method
        sut.addView.setUsedLabelArray(countOfNeededLabels: 4)
        
        for i in 0...labelArray.count-1 {
            XCTAssertTrue(labelArray[i].isHidden, "label \(i) should be hidden")
        }
        
    }
    
    func test_AddView_setUsedTextFieldArray_WhenTwoTextFieldsAreNeeded_ReturnsTwoTextFields() {
        //tell method 2 text fields are needed
        sut.addView.setUsedTextFieldArray(countOfNeededTextFields: 2)
        
        XCTAssertEqual(sut.addView.usedTextFieldArray.count, 2, "Count of used text field array should be 2 ")
    }
    
    func test_AddView_setUsedLabelArray_WhenUsedTextFieldArrayEmpty_CheckAllTextFieldsHidden() {
        //tell method 2 labels are needed
        sut.addView.setUsedTextFieldArray(countOfNeededTextFields: 2)
        
        for i in 0...textfieldArray.count-1 {
            XCTAssertTrue(textfieldArray[i].isHidden, "Text field \(i) should be hidden")
        }
        
    }
    
    func test_AddView_setUsedTextFieldArray_WhenUsedTextFieldIsNotEmpty_CheckTextFieldArrCount() {
        //put all labels in the usedlabelsarray
        sut.addView.usedTextFieldArray = textfieldArray
        
        //call method that should clear out the used labels array and reset it to have 3 labels
        sut.addView.setUsedTextFieldArray(countOfNeededTextFields: 3)
        
        XCTAssertEqual(sut.addView.usedTextFieldArray.count, 3, "Used labels array should be 3")
        
    }
    
    func test_AddView_setUsedTextFieldArray_WhenUsedTextFieldArrayIsNotEmpty_CheckAllTextFieldsHidden() {
        
        //put all labels in the usedtextfieldsarray
        sut.addView.usedTextFieldArray = textfieldArray
        
        //unhide text fields to simulate text fields being displayed
        for i in 0...textfieldArray.count-1 {
            textfieldArray[i].isHidden = false
        }
        
        //tell method 4 text fields are needed , make sure all the text fields are hidden at end of method
        sut.addView.setUsedTextFieldArray(countOfNeededTextFields: 4)
        
        for i in 0...textfieldArray.count-1 {
            XCTAssertTrue(textfieldArray[i].isHidden, "Text fields \(i) should be hidden")
        }
        
    }
    
    //Show method shows the correct labels and textfield associated with a particular category of taste
    //
    func test_AddView_showMethod_WhenTypeIsDish_UnhideCorrectTextFields() {
        sut.addView.show(labels: ["Name", "Rating", "Restaurant", "Address",  "Notes"])
        
        //check text fields 1-5 are unhidden
        
        for i in 0...4 {
            XCTAssertFalse(textfieldArray[i].isHidden, "Text fields \(i) should be showing")
        }
        
        // check text fields 6 is hidden still since it is not needed , there are only 5 labels needed
        
        
        XCTAssertTrue(textfieldArray[5].isHidden, "Text fields 6 should be hidden")
        
    }
    
    func test_AddView_showMethod_WhenTypeIsWine_UnhideCorrectLabels() {
        sut.addView.show(labels: ["Name","Rating", "Vineyard name", "Type", "Year", "Notes" ])
        
        //check labels 1-6 are unhidden
        
        for i in 0...5 {
            XCTAssertFalse(labelArray[i].isHidden, "Labels \(i) should be showing")
        }
        
    }
    
    func test_addViewShowscorrectfieldswhenPickerViewChanged () {
        
    }
    
    //add button tests
    func testAddButton_IsInitialized() {
       // XCTAssert(hasValue(sut.addButton))
    }
    func test_addButtonHasAddAction() {
        //let addButton: UIButton = sut.addButton
        
        //guard let actions = addButton
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
