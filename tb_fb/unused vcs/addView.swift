//
//  addView.swift
//  tb_fb
//
//  Created by Shveta Puri on 10/1/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class addView: UIView {
  
    @IBOutlet weak var l6: UILabel!
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l1: UILabel!
    var tastesLabelArray = [String]()
    var usedlabelsArray = [UILabel]()
    var availableLabels = [UILabel]()
    
   /// weak var delegate:updateRating?
   /// static weak var shared: addView?

  
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text5: UITextField!
    @IBOutlet weak var text6: UITextField!
    

    @IBOutlet weak var addAnotherDishBtn: UIButton!

    var usedTextFieldArray = [UITextField]()
    var availableTextfieldArray = [UITextField]()

    var image: UIImage?
    
    //var tasteObject = Tastes()


    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
      ///  addView.shared = self
    }
    func createUIarrays() {
        availableLabels = [l3, l4, l5, l6]
        availableTextfieldArray = [text1 , text2, text3, text4]
        
    }
    func setUsedLabelArray (labels: [String]) {
        //hide all previously used labels and clear array
        
        if (usedlabelsArray.count != 0) {
            for i in 0...usedlabelsArray.count-1 {
                usedlabelsArray[i].isHidden = true
            
            }
            usedlabelsArray = []
        }
        //set labels for name and rating
        l1.isHidden = false
        l1.text = labels[0]
        
        l2.isHidden = false
        l2.text = labels[1]
        
        //add rest of labels to usedlabelsarray
        for i in 0...labels.count-3 {
            usedlabelsArray.append(availableLabels[i])
            usedlabelsArray[i].isHidden = false
            usedlabelsArray[i].text = labels[i+2]
        }
    }
    
    
    func setUsedTextFieldArray (countOfNeededTextFields: Int) {
        //hide all previously used text fields and clear array
        if(usedTextFieldArray.count != 0) {
            for i in 0...usedTextFieldArray.count-1 {
                    usedTextFieldArray[i].isHidden = true
                    usedTextFieldArray[i].isAccessibilityElement = true
            }
        }
        usedTextFieldArray = []
        //add the needed text fields to usedtextfieldarray and show them
        for i in 0...countOfNeededTextFields-1 {
            usedTextFieldArray.append(availableTextfieldArray[i])
                usedTextFieldArray[i].isHidden = false
        }
    }
    
    func show(labels: [String]) {
       // category = tasteType
        let tastesLabelArray = labels
        createUIarrays()
        
        setUsedLabelArray(labels: labels)
        
        // set up the text fields subtract 2 because name and rating textfield / view are already setup
        setUsedTextFieldArray(countOfNeededTextFields:(tastesLabelArray.count-2))
        
    
        
    }
    
}
