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
    @IBOutlet weak var collectionCellButton: UIButton!
    
    func configureCollectionCell(_ category: String) {
    //   collectionCellButton.titleLabel?.text = category
    }
}
