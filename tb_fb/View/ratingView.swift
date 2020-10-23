//
//  ratingView.swift
//  tb_fb
//
//  Created by Shveta Puri on 3/10/20.
//  Copyright © 2020 Shveta Puri. All rights reserved.
//

import UIKit

@IBDesignable class ratingView: UIStackView {
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var imgView4: UIImageView!
    @IBOutlet weak var imgView5: UIImageView!

    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!

    var bArray = [UIButton]()
    
    var rating = 0
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
      ///  TableViewCell_WithImage.shared?.delegate = self
      ///  TableViewCell.shared?.delegate = self
        
        bArray = [b1, b2, b3, b4, b5]
        initializeImageArray()
        //createStars(rating: TableViewCell_WithImage)
        
        setAutolayout()
    }
    
    func setAutolayout() {
        
        for i in bArray {
            i.translatesAutoresizingMaskIntoConstraints = false
            i.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
            i.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        }
    }
    
    func initializeImageArray() {
        for i in 0...4 {
            bArray[i].setImage(UIImage(named:"star-1"), for: .normal)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        initializeImageArray()
        let yellowStar = UIImage(named:"star")
        let grayStar = UIImage(named:"star-1")
                
        //change button color depending on the color of buttons before
        if (sender.currentImage == grayStar) {
            rating = 0
            //change all buttons that are before to yellow star
            for i in 0...sender.tag {
                bArray[i].setImage(yellowStar, for: .normal)
                rating+=1
                
            }
            
        } else if(sender.currentImage == yellowStar) {
            //change all buttons that are after the clicked button to gray
            rating = 5
            for i in sender.tag...bArray.count-1 {
                bArray[i].setImage(grayStar, for: .normal)
                if (rating > 0) {
                    rating = rating - 1
                }
                
            }
            
        }
    }
    
    func createStars (rating:NSString) {
        //image views for stars and add appropriate number
        //of yellow and gray stars depending on rating
        initializeImageArray()
        if var ratingNum = Int(rating as String){
            if (ratingNum == 0 ) {ratingNum = 1}
            for i in 0...ratingNum-1 {
                bArray[i].setImage(UIImage(named: "star"), for: .normal)
            }
        }
    }
    
    func deactivateButtons() {
        for button in bArray {
            button.isUserInteractionEnabled = false
        }
    }
    
    func activateButtons() {
        for button in bArray {
            button.isUserInteractionEnabled = true
        }
    }
    
    func getRating() -> String {
        
        return String(rating)
        
    }
}

//protocol updateRating: AnyObject {
//    func createStars(rating:NSString)
//    func getRating() -> String
//}
