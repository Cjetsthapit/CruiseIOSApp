//
//  SelectCruiseController.swift
//  Team6_MAPD714_Project-Milestone4
//  *****Milestone 4*****
//  *****Team6*****
//  *****Team Members*****
//  Srijeet Sthapit - 301365217
//  Abi Chitrakar - 301369773
//  Promish Khaniya - 301369717
//
//  Created by Srijeet Sthapit on 2023-10-29.
//  Submitted on 2023-12-01

import UIKit

class CruiseHomeController: UIViewController {
    
    // Outlets for the 'Book Cruise' and 'View Bookings' buttons
    @IBOutlet weak var bookCruiseBtn: UIButton!
    @IBOutlet weak var viewBookingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides the back button in the navigation bar
        self.navigationItem.hidesBackButton = true
    }
    
    // Action for 'View Bookings' button click
    @IBAction func onViewBookings(_ sender: Any) {
        // Navigates to the CruiseBookingListController
        navigateToController(withIdentifier: "cruiseBookingList", controllerType: CruiseBookingListController.self)
    }
    
    // Action for 'Logout' button click
    @IBAction func onLogout(_ sender: Any) {
        // Navigates to the LoginController
        navigateToController(withIdentifier: "login", controllerType: LoginController.self)
    }
    
    // Function to handle navigation to different view controllers
    private func navigateToController<T: UIViewController>(withIdentifier identifier: String, controllerType: T.Type) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


