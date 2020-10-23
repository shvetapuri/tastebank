//
//  CollectionViewCell.swift
//  tb_fb
//
//  Created by Shveta Puri on 11/13/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionCellLabel: UILabel!
    
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        
    }
    func configureCollectionCell(_ category: String) {
       // collectionCellLabel.backgroundColor = UIColor(patternImage: UIImage(named: "star")!)
            
        
        collectionCellLabel.text = category
        collectionCellLabel.layer.masksToBounds = true
        collectionCellLabel.layer.cornerRadius = 6
        
    }
    
    func selected() {
        collectionCellLabel.backgroundColor = #colorLiteral(red: 0.986794099, green: 0.9701784753, blue: 0.8416773197, alpha: 1)
        

    }
    
    func deselected() {
        collectionCellLabel.backgroundColor = nil
    }
}
