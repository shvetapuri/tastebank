//
//  addView.swift
//  tb_fb
//
//  Created by Shveta Puri on 10/1/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class addView: UIView {

    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l1: UILabel!
    var tastesLabelArray = [String]()
    var usedlabelsArray = [UILabel]()
    var availableLabels = [UILabel]()
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    var usedTextFieldArray = [UITextField]()
    var availableTextfieldArray = [UITextField]()

    var tasteObject = Tastes()

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    func createUIarrays() {
        availableLabels = [l1, l2, l3, l4]
        availableTextfieldArray = [text1 , text2, text3, text4]
    }
    func setUsedLabelArray (countOfNeededLabels: Int) {
        //hide all previously used labels and clear array
        if (usedlabelsArray.count != 0) {
            for i in 0...usedlabelsArray.count-1 {
                usedlabelsArray[i].isHidden = true
            
            }
            usedlabelsArray = []
        }
        for i in 0...countOfNeededLabels-1 {
            usedlabelsArray.append(availableLabels[i])
        }
    }
    
    func setUsedTextFieldArray (countOfNeededTextFields: Int) {
        //hide all previously used text fields and clear array
        if(usedTextFieldArray.count != 0) {
            for i in 0...usedTextFieldArray.count-1 {
                usedTextFieldArray[i].isHidden = true
            }
        }
        usedTextFieldArray = []
        //add the needed text fields to usedtextfieldarray
        for i in 0...countOfNeededTextFields-1 {
            usedTextFieldArray.append(availableTextfieldArray[i])
        }
    }
    
    func show(tasteType: String) {
        tasteObject.category = tasteType
        let tastesLabelArray = tasteObject.returnLabels()
        createUIarrays()
        setUsedLabelArray(countOfNeededLabels:tastesLabelArray.count)
        setUsedTextFieldArray(countOfNeededTextFields:tastesLabelArray.count)
        
//
//        switch tasteType {
//        case "Dish":
//            //get correct labels for type of taste
//            tastesLabelArray = Array(tasteObject.dishDict.keys)
//        case "Chocolate":
//            tastesLabelArray = Array(tasteObject.chocDict.keys)
//        default:
//            tastesLabelArray = Array(tasteObject.dishDict.keys)
//        }
        var i = 0
        for l in tastesLabelArray {
            if (i<tastesLabelArray.count) {
                usedlabelsArray[i].isHidden = false
                usedlabelsArray[i].text = l
                usedTextFieldArray[i].isHidden = false
                i = i + 1
            }
        }
        
        //return category
        //return tasteObject
    }
    
}
