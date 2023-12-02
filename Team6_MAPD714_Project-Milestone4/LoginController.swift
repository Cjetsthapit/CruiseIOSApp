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

class LoginController: UIViewController {
    
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    var db = UserDbManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Additional setup after loading the view
    }
    
    // Function for handling the login button click
    @IBAction func onLoginClick(_ sender: Any) {
        // Ensure all fields are filled
        guard let emailText = emailValue.text, !emailText.isEmpty,
              let passwordText = passwordValue.text, !passwordText.isEmpty else {
            showAlert(message: "Please fill in all fields")
            return
        }
        
        // Check if the email is valid
        guard Utilities.isValidEmail(emailText) else {
            showAlert(message: "Invalid email format")
            return
        }
        
        // Attempt to log in the user
        if let user = db.getUser(email: emailText, password: passwordText) {
            let defaults = UserDefaults.standard
            defaults.set(user.email, forKey: "email")
            defaults.set(user.id, forKey: "id")
            print(defaults.integer(forKey: "id"))
            showAlert(message: "Login successful", isDismiss: true)
        } else {
            showAlert(message: "Login failed. Enter correct credentials")
        }
    }
    
    // Function to show alerts with an optional dismiss action
    func showAlert(message: String, isDismiss: Bool = false) {
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if isDismiss {
                self.transitionToHomeScreen()
            }
        }))
        self.present(alert, animated: true)
    }

    // Function to transition to the home screen after successful login
    private func transitionToHomeScreen() {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let homeController = storyboard.instantiateViewController(withIdentifier: "cruiseHome") as! CruiseHomeController
        homeController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(homeController, animated: true)
    }
}
