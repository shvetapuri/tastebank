//
//  AddViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/19/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData: [String] = [String] ()
    
    @IBOutlet weak var addView: addView!
    
    var tastesManager: TastesManager?
    var category: String = "Dish"
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Dish", "Dessert", "Wine", "Coffee", "Beer", "Chocolate", "Cheese", "Other"]
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //when first loaded show dish in pickerview
        pickerView.selectRow(0, inComponent: 0, animated: true)
        let labels = tastesManager?.returnLabels(category: category)
        addView.show( labels: labels!)
        
        //tap will dismiss text field keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        imageView.isHidden = true
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
        category = pickerData[row]
        addView.show(labels: (tastesManager?.returnLabels(category: category))!)
        
    }
    
    
    
    
    @IBAction func addImage(_ sender: Any) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(UIImagePickerController.SourceType.camera)
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(UIImagePickerController.SourceType.photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        imagePicker.delegate = self 
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(_ sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //add button action

    @IBAction func addButtonTapped(_ sender: Any) {
        
        // !!!!check that there is a name and rating otherwise give error
        
        
        //
        //build a dictionary out of all data in text fields
        var dictOfTaste: [String: Any] = [:]
        
        for i in 0...addView.usedlabelsArray.count-1 {
            dictOfTaste[addView.usedlabelsArray[i].text!] = addView.usedTextFieldArray[i].text
        }
        dictOfTaste["Category"] = category
    
        var t: Tastes?
        if ((imageView.image) != nil) {
            //create a taste object
            dictOfTaste["image"] = createThumbnail(image:imageView.image!)
              t = Tastes(dictionary: dictOfTaste)
            imageView.image = nil
        } else {

            //create a taste object
              t = Tastes(dictionary: dictOfTaste)
            
        }
        
        if ((t) != nil) {
        let msg = tastesManager?.addTasteToDB(TasteObj: t!, BypassCheckFlag: false)
        
            //save in tastesManager
            if(msg == "duplicate") {
                //present alert
            
                let alertDup = UIAlertController(title:"Duplicate Taste", message: "You are entering a duplicate taste, would you like to continue to save it or cancel?",  preferredStyle: .alert)
                alertDup.addAction(UIAlertAction(title: "Continue Saving", style: .default, handler: {(action:UIAlertAction!) in
                    //self.tastesManager?.addTasteToDB(TasteObj: t!, BypassCheckFlag: true)
                    self.checkDish()
                }))
                alertDup.addAction(UIAlertAction(title: "Go Back", style: .cancel , handler: nil))
            
                present(alertDup, animated: true, completion: nil)
            } else {
                checkDish()
            }
            
       
        
        } else {
            print ("error saving taste")
        }
    }
    
    func checkDish() {
        
        if (category == "Dish") {
            //check to see if user wants to add more dishes to the current restaurant\
            let alert = UIAlertController(title:"Add Another Dish?", message: "Would you like to add another dish for this restauran?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action:UIAlertAction!) in self.addView.text1.text = ""
                self.addView.text2.text = ""
            }));
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {(action:UIAlertAction!) in self.dismiss(animated: true, completion: nil)}))
            
            present(alert, animated: true, completion: nil)
            
            
            
        } else {
            //go back to main controller
            dismiss(animated: true, completion: nil)
        }
    }
    
    func createThumbnail (image: UIImage) -> Data {
        let imageData = image.pngData()
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: 150] as CFDictionary
        let source = CGImageSourceCreateWithData(imageData! as CFData, nil)!
        let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
        let thumbnail = UIImage(cgImage: imageReference)
        return thumbnail.pngData()!
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

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.isHidden = false
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerController cancel")
    }

    
    
}
