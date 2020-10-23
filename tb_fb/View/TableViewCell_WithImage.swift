//
//  TableViewCell_WithImage.swift
//  tb_fb
//
//  Created by Shveta Puri on 3/2/20.
//  Copyright © 2020 Shveta Puri. All rights reserved.
//

import UIKit



class TableViewCell_WithImage: UITableViewCell {


    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var rest_vine_brand_name: UILabel!
    
    @IBOutlet weak var add_type_year_label: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var notesLabel: UITextView!
    
    @IBOutlet weak var ratingView: ratingView!

    var taste: Tastes!

    ///weak var delegate:updateRating?
   /// static weak var shared: TableViewCell_WithImage?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   ///     TableViewCell_WithImage.shared = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell( taste: Tastes, tastesManager:TastesManager, ratingView: ratingView)
        {
        self.taste = taste
        self.imgView?.image = nil
            
        self.imgView?.image = UIImage(data: taste.image!)
        
        let labels = tastesManager.returnLabels(category: taste.category!)

    
            self.titleLabel.text = taste.dictionary["Name"] as? String
            
            //taste.dictionary["Rating"] as? String
    ///       delegate?.createStars(rating: taste.dictionary["Rating"]!! as NSString)
            ratingView.createStars(rating: taste.dictionary["Rating"]!! as NSString)
            
            self.categoryLabel.text = taste.dictionary["Category"] as? String
            
            self.rest_vine_brand_name.text = taste.dictionary[labels[2]] as? String
            if (labels.contains("Year")) {
                self.add_type_year_label.text = (((taste.dictionary[labels[3]] as? String)!) ) + " Year:" + ((taste.dictionary[labels[4]] as? String)!)
            } else {
                self.add_type_year_label.text = taste.dictionary[labels[3]] as? String
            }
            self.notesLabel.text = taste.dictionary["Notes"] as? String
            
    }
        
        
}
