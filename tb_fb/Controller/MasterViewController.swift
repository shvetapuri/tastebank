//
//  ViewController.swift
//  tb_fb
//
//  Created by Shveta Puri on 5/10/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var addContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
    }

    private func setupSegmentedControl(){
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Search Tastes", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Add Taste", at: 1, animated: false)
        
        
        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
               // self.searchContainerView.alpha = 1
                //self.addContainerView.alpha = 0
                self.searchContainerView.isHidden = false
                self.addContainerView.isHidden = true
            })
            
            //remove(asChildViewController: addViewController)
          //  addVC(asChildViewController: searchViewContoller)
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                // self.searchContainerView.alpha = 1
                //self.addContainerView.alpha = 0
                self.searchContainerView.isHidden = true
                self.addContainerView.isHidden = false
            })
        //    remove(asChildViewController: searchViewContoller)
         //   addVC(asChildViewController: addViewController)
        }
    }
    
    
    
    
}

