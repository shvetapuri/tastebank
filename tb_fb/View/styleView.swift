//
//  styleView.swift
//  tb_fb
//
//  Created by Shveta Puri on 9/4/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class styleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.3 ).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:1.0, height: 1.0)
        
    
       // layer.insertSublayer(gradient(frame:self.bounds), at: 0)

        
 
        
        
        //layer.contentsScale =  UIView.ContentMode.scaleAspectFill
        //layer.contents = #imageLiteral(resourceName:"waffles").cgImage
        

    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [
            UIColor.white.cgColor,UIColor.white]
        return layer
    }

}
