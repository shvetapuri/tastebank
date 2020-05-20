//
//  addViewTableViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/5/20.
//  Copyright © 2020 Shveta Puri. All rights reserved.
//

import UIKit

class addViewTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData: [String] = [String] ()
    
    @IBOutlet weak var ratingView: ratingView!
            
    var tastesManager: TastesManager?
    var category: String = "Dish"
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var c1_TF: UITextField!
    @IBOutlet weak var c2_TF: UITextField!
    @IBOutlet weak var c3_TF: UITextField!
    @IBOutlet weak var notesTF: UITextView!
    
    var labelsArr: [String] = []
    
    @IBOutlet weak var c1: UITableViewCell!
    @IBOutlet weak var c2: UITableViewCell!
    @IBOutlet weak var c3: UITableViewCell!
    @IBOutlet weak var c4: UITableViewCell!
    
    var cellIsHidden: Bool = true
    
    var cellArray: [UITableViewCell] = []
    var cellTFArray: [UITextField] = []

    override func awakeFromNib() {
       super.awakeFromNib()

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerData = ["Dish", "Dessert", "Wine", "Coffee", "Beer", "Chocolate", "Cheese", "Other"]
        pickerView.delegate = self
        pickerView.dataSource = self
        
        notesTF.delegate = self
        
        //when first loaded show dish in pickerview
        pickerView.selectRow(0, inComponent: 0, animated: true)
        let labels = tastesManager?.returnLabels(category: category)
        changeLabels( labels: labels!)
        
        //tap will dismiss text field keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        //text view border
        
        notesTF.layer.cornerRadius = 5
        notesTF.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        notesTF.layer.borderWidth = 0.7
        notesTF.clipsToBounds = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 126.0
        }
        
        if indexPath.row == 1 {
            return 105.0
        }
        
        if indexPath.row == 7 {
            return 69.0
        }
        if indexPath.row == 6 && cellIsHidden {
            
                return 0.0
        }
            
        return 52.0
    }

    func changeLabels(labels: [String]) {
        //labels is a list of labels that are required for the current category
        //selected on the picker
        
        resetHiddenCell()
        //the first two labels, name and rating have already been created statically since those are required for every category
        //show the rest of the labels
        labelsArr = Array(labels[2...])
         cellArray = [c1, c2, c3]
         cellTFArray = [c1_TF, c2_TF, c3_TF]

        for i in 0...cellArray.count-1 {
            if (labels[i+2].count != 0 && labels[i+2] != "Notes") {
                
                if (i == 2) {
                    c3.isHidden = false
                    c3_TF.isHidden = false
                    cellIsHidden = false
                }
                cellTFArray[i].placeholder = labels[i+2]
                
                
                tableView.reloadData()
            }
        }
        
    }
    
    
    
    func resetHiddenCell()
    {
       //c3 is an extra cell for certain categories it will be shown when needed
            c3.isHidden = true
            c3_TF.isHidden = true
            cellIsHidden = true
            tableView.reloadData()

    }
    // picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        category = pickerData[row]
        //addView.show(labels: (tastesManager?.returnLabels(category: category))!)
        changeLabels(labels: (tastesManager?.returnLabels(category: category))!)
    }
    
    //add placeholder text to text view
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        notesTF.textColor = .black

        if(notesTF.text == "Notes") {
            notesTF.text = ""
        }

    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if(notesTF.text == "") {
            notesTF.text = "Notes"
            notesTF.textColor = .lightGray
        }
        textView.resignFirstResponder()

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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        //build a dictionary out of all data in text fields
        var dictOfTaste: [String: Any] = [:]
        
        //let rating = delegate?.getRating()
        let rating = ratingView.getRating()
        
        //save the name of the taste in new struct
        if (nameTF.text != "") && (rating != "0") {
            dictOfTaste["Name"] = nameTF.text
        
            dictOfTaste["Rating"] = rating
        
            //save all other fields
            for i in 0...labelsArr.count-1 {
                dictOfTaste[labelsArr[i]] = cellTFArray[i].text
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
            
            //save in database

                let msg = tastesManager?.addTasteToDB(TasteObj: t!, BypassCheckFlag: false)
         
                if(msg == "duplicate") {
                 //present alert if duplicate entry
             
                    let alertDup = UIAlertController(title:"Duplicate Taste", message: "You are entering a duplicate taste, would you like to continue to save it or cancel?",  preferredStyle: .alert)
                    alertDup.addAction(UIAlertAction(title: "Continue Saving", style: .default, handler: {(action:UIAlertAction!) in
                     self.tastesManager?.addTasteToDB(TasteObj: t!, BypassCheckFlag: true)
                     self.checkDish()
                    }))
                    alertDup.addAction(UIAlertAction(title: "Go Back", style: .cancel , handler: nil))
             
                 present(alertDup, animated: true, completion: nil)
                } else {
                //check if the user would like to add another dish
                 checkDish()
                }

             } else {
                print ("error saving taste")
            }
        
        
        } else {
            alertUser(message: "Please enter taste name and rating to save taste.")
        }
    
    
    }
   
    
    func alertUser(message: String) {
            
        let alert = UIAlertController(title:"Taste Not Saved", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                 
                 present(alert, animated: true, completion: nil)
        
    }
    
    //ask the user if they would like to add another dish
    //for the same restaurant
     func checkDish() {
         
         if (category == "Dish") {
             //check to see if user wants to add more dishes to the current restaurant\
             let alert = UIAlertController(title:"Add Another Dish?", message: "Would you like to add another dish for this restauran?", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action:UIAlertAction!) in
                self.nameTF.text = ""
                 // clear rating
             }))
             alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {(action:UIAlertAction!) in self.dismiss(animated: true, completion: nil)}))
             
             present(alert, animated: true, completion: nil)
             
             
             
         } else {
             //go back to main controller
             dismiss(animated: true, completion: nil)
         }
     }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        //go back to main controller
        dismiss(animated: true, completion: nil)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension addViewTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
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

extension addViewTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
    
    

}
