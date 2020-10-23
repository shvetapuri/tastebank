//
//  DetailTableViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 7/6/20.
//  Copyright © 2020 Shveta Puri. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate{

    var tasteInfo = Tastes()
    var tastesManager: TastesManager?

    @IBOutlet weak var nameCell: UITableViewCell!
    
    @IBOutlet weak var imageCell1: UITableViewCell!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var rightButton: UIBarButtonItem!
    @IBOutlet weak var ratingCell: UITableViewCell!
    
        
    
    @IBOutlet weak var navItem: UINavigationItem!

    @IBOutlet weak var ratingView: ratingView!

    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var c1_TF: UITextField!
    @IBOutlet weak var c2_TF: UITextField!
    @IBOutlet weak var c3_TF: UITextField!
    @IBOutlet weak var notesTF: UITextView!
    var cellTFArray = [UITextField] ()
    
    @IBOutlet weak var c1: UITableViewCell!
    @IBOutlet weak var c2: UITableViewCell!
    @IBOutlet weak var c3: UITableViewCell!
    @IBOutlet weak var c4: UITableViewCell!
    
    @IBOutlet weak var done_cancel_button: UIBarButtonItem!
    var labelsArr = [String] ()
    @IBOutlet weak var c1_label: UILabel!
    @IBOutlet weak var c2_label: UILabel!
    @IBOutlet weak var c3_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        if(tasteInfo.image != nil) {
            imageCell1.isHidden = false
            imageView.isHidden = false
            imageView.image = UIImage(data:(tasteInfo.image)!)
     
            notesTF.delegate = self
          //  navItem.title = "Taste Detail"
            
        }
        
        setupTextFields()
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func setupTextFields() {
        
        //get labels for taste category
        let labels = tastesManager?.returnLabels(category: tasteInfo.category!)
        
        labelsArr = Array(labels![2...])
       // let cellLabelsArr = [c1_label, c2_label, c3_label]
        //c1_TF and c2_TF are needed text fields for all categories, c3_TF is only needed for wine
        let allTFArray = [c1_TF, c2_TF, c3_TF]
        let allCellArray = [c1, c2, c3]
        
        for i in 0...labelsArr.count-2 {
//          //  cellLabelsArr[i]!.text = labelsArr[i]
//            //cellTFArray[i]?.borderStyle = .none
////            cellTFArray[i]?.isHidden = false
            print (tasteInfo.dictionary[labelsArr[i]] as? String)
            if ((allTFArray[i]?.isHidden) == true) {
                allTFArray[i]?.isHidden = false
                allCellArray[i]?.isHidden = false
            }
            cellTFArray.append(allTFArray[i]!)
            cellTFArray[i].text = tasteInfo.dictionary[labelsArr[i]] as? String
            
            
//            print(tasteInfo.dictionary[labelsArr[i]] as? String)
//
//            if((tasteInfo.dictionary[labelsArr[i]])  == "none" || tasteInfo.dictionary[labelsArr[i]] == "")  {
//                cellTFArray[i]?.borderStyle = .none
//                cellTFArray[i]?.isHidden = true
//            }
//            if ( (tasteInfo.dictionary[labelsArr[i]] as? String)  != "none" ) {
//                cellTFArray[i]!.text = tasteInfo.dictionary[labelsArr[i]] as? String
//            } else {
//                cellTFArray[i]!.placeholder = labelsArr[i]
//
//            }
        }
        
        nameTF.text = tasteInfo.name
        notesTF.text = tasteInfo.comments
        categoryTF.text = tasteInfo.category
        
        ratingView?.createStars(rating: tasteInfo.rating as NSString)
        ratingView?.deactivateButtons()
        
        print(cellTFArray)
        tableView.reloadData()
    }
    
    func updateTextFields () {
        //cellTFArray = [c1_TF, c2_TF, c3_TF]

        if(isEditing) {
            nameTF.isUserInteractionEnabled = true
            nameTF.borderStyle = .roundedRect
            ratingView.isUserInteractionEnabled = true
            notesTF.isUserInteractionEnabled = true
            notesTF.isEditable = true
            notesTF.layer.borderWidth = 0.5
            notesTF.layer.cornerRadius = 5
            //notesTF. = .roundedRect
            categoryTF.isUserInteractionEnabled = true
            categoryTF.borderStyle = .roundedRect
            cellTFArray.forEach {
                $0.borderStyle = .roundedRect
                $0.isUserInteractionEnabled = true
            }
            ratingView?.activateButtons()
        
            
            
        } else {
            nameTF.isUserInteractionEnabled = false
            nameTF.borderStyle = .none
            ratingView.isUserInteractionEnabled = true
            notesTF.isEditable = false
            notesTF.isUserInteractionEnabled = false
            notesTF.layer.borderWidth = 0
            notesTF.layer.cornerRadius = 5
            notesTF.layer.borderColor = UIColor.lightGray.cgColor
            categoryTF.isUserInteractionEnabled = false
            categoryTF.borderStyle = .none
            cellTFArray.forEach {
                $0.borderStyle = .none
                $0.isUserInteractionEnabled = false
            }
            ratingView?.deactivateButtons()
            tableView.reloadData()


        }
    }
    
    func updateButtons() {
        if (isEditing) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(doneTapped))
        } else {
            navigationItem.rightBarButtonItem = editButtonItem
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelAction(_:)))
        }
    }
    @objc func doneTapped() {
        setEditing(false, animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
       
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped() {
        
        // create a dictionary that stores all the
        //editted data in the text fields , send it to the taste manager to format
        //and save in database
       
        var taste_dict: [String: Any] = [:]
        
        taste_dict["Name"] = nameTF.text
        taste_dict["Category"] = categoryTF.text
        taste_dict["Rating"] = ratingView.getRating()
        
      
        for i in 0...cellTFArray.count-1 {
           taste_dict[labelsArr[i]] = cellTFArray[i].text
        }
        
        //let t = Tastes(dictionary: taste_dict as [String : Any])
        tastesManager?.editTasteInDB(tasteObj: tasteInfo , textFieldData: taste_dict)
        
        
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return ""
            case 1: return "Name"
            case 2: return "Rating"
            case 3: return "Category"
            //offset index by 4 since section names for first  sections are unchanging
            case 4,5:
                if(section-4 < labelsArr.count ) {
                    return labelsArr[section-4 ]
                } else {
                    return ""
                }
            case 6:
                if(c3.isHidden == false && section-4 < labelsArr.count  ) {
                    return labelsArr[section-4]
                } else {
                    return ""
                }
            case 7:
                return "Notes"
            default: return ""
        
        }
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)

        updateTextFields()
        updateButtons()

    }
    @IBAction func editAction(_ sender: Any) {
       // tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.rightBarButtonItem!.title = tableView.isEditing ? "Save" : "Edit"
    
    
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        if section == 6 && c3.isHidden == true  {
            //header height for selected section
            return CGFloat.leastNonzeroMagnitude
        }

        //keeps all other Headers unaltered
        return 25
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 6 && c3.isHidden == true {
//            return CGFloat.leastNonzeroMagnitude
//        }
//      return 20
//    }
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if section == 6 && c3.isHidden == true  {
//            let headerView = view as! UITableViewHeaderFooterView
//            headerView.textLabel!.textColor = UIColor.clear
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//        if section == 6 && c3.isHidden == true  {
//            //header height for selected section
//            return 0
//        }
//        
//        return super.tableView(tableView, heightForFooterInSection: section)
//    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if (indexPath.section == 0) {
        if indexPath.row == 1 {
            if (imageCell1.isHidden) {            
                return 0.0
            } else  {
                return 126.0
            }
        }
        }
        
        if indexPath.section == 7 {
            return 130.0
        }
        
        if (indexPath.section == 6 && c3.isHidden == true ){
            return CGFloat.leastNonzeroMagnitude
        } 
        
        return 52.0
 
    }
    
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }


    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        
//        if (section == 6 && c3.isHidden == true ){
//            return 0
//        } else {
//            return super.tableView(tableView, numberOfRowsInSection: section)
//        }
//    }

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
