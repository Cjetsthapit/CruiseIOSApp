//
//  SelectCruiseController.swift
//  Team6_MAPD714_Project-Milestone2
//  *****Milestone 2*****
//  *****Team6*****
//  *****Team Members*****
//  Srijeet Sthapit - 301365217
//  Abi Chitrakar - 301369773
//  Promish Khaniya - 301369717
//
//  Created by Srijeet Sthapit on 2023-10-29.
//  Submitted on 2023-10-30

import UIKit

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //function for register click
    @IBAction func onRegisterClick(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginController
        control.modalPresentationStyle = .fullScreen
               present(control, animated: true)
    }
    
    //function to navigate ot login page
    @IBAction func onLoginClick(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginController
        control.modalPresentationStyle = .fullScreen
               present(control, animated: true)
    }
}

