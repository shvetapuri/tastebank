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
    
    var taste: Tastes!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(taste: Tastes) {
        self.taste = taste
        self.name.text = taste.name
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
