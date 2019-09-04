//
//  styleButton.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/4/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class styleButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6 ).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }

}
