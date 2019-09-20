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

    private lazy var addViewController: AddViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        // Add the view controller to the container.
        viewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        addChild(viewController)

        view.addSubview(viewController.view)
            
        viewController.didMove(toParent: self)
            
        return viewController
            
        }()
    private lazy var searchViewContoller: SearchViewController = {

        // Create a child view controller and add it to the current view controller.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            // Add the view controller to the container.
        viewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        addChild(viewController)

        view.addSubview(viewController.view)
            
            // Notify the child view controller that the move is complete.
        viewController.didMove(toParent: self)
        return viewController
       
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addVC(asChildViewController: searchViewContoller)

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
            remove(asChildViewController: addViewController)
            addVC(asChildViewController: searchViewContoller)
        } else {
            remove(asChildViewController: searchViewContoller)
            addVC(asChildViewController: addViewController)
        }
    }
    
    
//    func setupSearchViewController() {
//        // Create a child view controller and add it to the current view controller.
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        if let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewContoller")
//            as? SearchViewController {
//            // Add the view controller to the container.
//            addChild(viewController)
//            view.addSubview(viewController.view)
//
//            // Create and activate the constraints for the child’s view.
//            //onscreenConstraints = configureConstraintsForContainedView(containedView: viewController.view,
//                                                                    //   stage: .onscreen)
//           // NSLayoutConstraint.activate(onscreenConstraints)
//
//            // Notify the child view controller that the move is complete.
//            viewController.didMove(toParent: self)
//            searchViewContoller = viewController
//        }
//
//    }
    private func addVC(asChildViewController: UIViewController) {
        addChild(asChildViewController)
        view.addSubview(asChildViewController.view)
        asChildViewController.didMove(toParent: self)
    }
//    func setupAddViewController () {
//        // Create a child view controller and add it to the current view controller.
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        if let viewController = storyboard.instantiateViewController(withIdentifier: "AddViewContoller")
//            as? AddViewController {
//            // Add the view controller to the container.
//            addChild(viewController)
//            view.addSubview(viewController.view)
//
//            // Create and activate the constraints for the child’s view.
//            //onscreenConstraints = configureConstraintsForContainedView(containedView: viewController.view,
//            //   stage: .onscreen)
//            // NSLayoutConstraint.activate(onscreenConstraints)
//
//            // Notify the child view controller that the move is complete.
//            viewController.didMove(toParent: self)
//            addViewController = viewController
//        }
//
//    }
    
    private func remove(asChildViewController: UIViewController) {
        // Notify Child View Controller
        asChildViewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        asChildViewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        asChildViewController.removeFromParent()
    }
    
    
}

