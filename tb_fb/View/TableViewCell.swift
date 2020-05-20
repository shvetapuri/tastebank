//
//  TableViewCell.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/11/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  
    
 
    
   // @IBOutlet weak var ratingLabel: UILabel!
    
    var taste: Tastes!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rest_vine_brand_name: UILabel!
    @IBOutlet weak var add_type_year_label: UITextView!
    @IBOutlet weak var notesLabel: UITextView!
    //@IBOutlet weak var rv: ratingView!
    
   /// weak var delegate:updateRating?
  ///  static weak var shared: TableViewCell?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     ///   TableViewCell.shared = self
        
    }
  
      
      
    func configureCell( taste: Tastes, tastesManager: TastesManager, ratingView: ratingView) {
        self.taste = taste
   //     self.name.text = taste.name
    //    self.ratingLabel.text = taste.ratin
       /// for view in vStackView.subviews {
         ///   view.removeFromSuperview()
        self.imageView?.image = nil
        
        ///}
//        var xVal=0

//        if (taste.image != nil) {
//            //display image if it exists
//           self.imageView?.image = UIImage(data: taste.image!)
//           xVal = 160
//        }
//
       let labels = tastesManager.returnLabels(category: taste.category!)
//
//     ///   var createdLabelsArray = [UILabel]()
//      ///  var y = 10
//      ///  var i = 0
//
//        self.titleLabel.frame = CGRect(x: CGFloat(xVal), y: CGFloat(10), width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
//        self.titleLabel.numberOfLines = 0
        self.titleLabel.text = taste.dictionary["Name"] as? String
        //self.ratingLabel.text = taste.dictionary["Rating"] as? String
        //delegate?.createStars(rating: taste.dictionary["Rating"]!! as NSString)
        //ratingView.createStars(rating: taste.dictionary["Rating"]!! as NSString)
        ratingView.createStars(rating: taste.dictionary["Rating"]!! as NSString)
        self.rest_vine_brand_name.text = taste.dictionary[labels[2]] as? String
        if (labels.contains("Year")) {
            self.add_type_year_label.text = (taste.dictionary[labels[3]]!!) + " Year:" + (taste.dictionary[labels[4]]!!)
        } else {
            self.add_type_year_label.text = taste.dictionary[labels[3]] as? String
        }
        self.notesLabel.text = taste.dictionary["Notes"] as? String
        
        
//        for l in labels {
//
//            let label = UILabel()
//            label.text = String(format: "\(l): ")
//            label.sizeToFit()
//           // label.numberOfLines = 0
//            label.font = UIFont(name: "AvenirNext-Bold", size: 18)
//            label.frame = CGRect(x: CGFloat(xVal), y: CGFloat(y), width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
//            label.numberOfLines = 0
//
//            let label2 = UILabel()
//            label2.text = taste.dictionary[l]!
//            label2.sizeToFit()
//            //label2.numberOfLines = 0
//            label2.font = UIFont(name: "AvenirNext-Regular", size: 18)
//            label2.frame = CGRect(x: (CGFloat(label.bounds.size.width) + CGFloat(xVal)), y: CGFloat(y), width: label2.intrinsicContentSize.width, height: label2.intrinsicContentSize.height)
//            label2.numberOfLines = 0
//
//
//            vStackView.addSubview(label)
//            vStackView.addSubview(label2)
//
//
//          //  cell.contentView.addSubview(label)
//            createdLabelsArray.append(label)
//            y = y + 20
//            i = i + 1
//
//        }
        
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
