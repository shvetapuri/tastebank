//
//  AddViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/19/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    var textFieldArray = [String]()
    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData: [String] = [String] ()
    
    @IBOutlet weak var addView: addView!
    var category: String = "none"
    var tasteObject = Tastes()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Dish", "Dessert", "Wine", "Coffee", "Beer", "Chocolate", "Cheese", "Other"]
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //when first loaded show dish in pickerview
        pickerView.selectRow(0, inComponent: 0, animated: true)
        addView.show(tasteType: "Dish")

    }
    
    //Picker view
    //number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        
        addView.show(tasteType: pickerData[row])
        
    }
    
    
    
    //add button action
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        // !!!!check that there is a name and rating otherwise give error
        
        
        
        //build a dictionary out of all data in text fields
        var dictOfTaste: [String: String] = [:]
        
        for i in 0...addView.usedlabelsArray.count-1 {
            dictOfTaste[addView.usedlabelsArray[i].text!] = addView.usedTextFieldArray[i].text
        }
        dictOfTaste["Category"] = addView.tasteObject.category

        
        //save in database
        DataService.ds.createTasteEntryDB(TasteDict: dictOfTaste)
        
        //go back to main controller
        dismiss(animated: true, completion: nil)

        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        //go back to main controller
        dismiss(animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
