//
//  TableViewCell.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/11/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
        
    @IBOutlet weak var vStackView: UIStackView!
    var taste: Tastes!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell( taste: Tastes, tastesManager: TastesManager) {
        self.taste = taste
   //     self.name.text = taste.name
    //    self.ratingLabel.text = taste.ratin
        for view in vStackView.subviews {
            view.removeFromSuperview()
            self.imageView?.image = nil
        }

        if (taste.image != nil) {
            //display image if it exists
           self.imageView?.image = UIImage(data: taste.image!)
        } 
        
        let labels = tastesManager.returnLabels(category: taste.category!)
        
        var createdLabelsArray = [UILabel]()
        var y = 0
        var i = 0
        
        
        for l in labels {
            
            let label = UILabel()
            label.text = String(format: "\(l): ")
            label.sizeToFit()
           // label.numberOfLines = 0
            label.font = UIFont(name: "AvenirNext-Bold", size: 18)
            label.frame = CGRect(x: 0, y: CGFloat(y), width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
            label.numberOfLines = 0
            
            let label2 = UILabel()
            label2.text = taste.dictionary[l]!
            label2.sizeToFit()
            //label2.numberOfLines = 0
            label2.font = UIFont(name: "AvenirNext-Regular", size: 18)
            label2.frame = CGRect(x: (CGFloat(label.bounds.size.width )), y: CGFloat(y), width: label2.intrinsicContentSize.width, height: label2.intrinsicContentSize.height)
            label2.numberOfLines = 0
            
            
            vStackView.addSubview(label)
            vStackView.addSubview(label2)
            
            
          //  cell.contentView.addSubview(label)
            createdLabelsArray.append(label)
            y = y + 20
            i = i + 1
            
        }
        
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
