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

class RegisterController: UIViewController {
    // Database manager instance
    var db = UserDbManager()
    
    // Outlets for user inputs
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var cPasswordValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Function for handling the Register button action
    @IBAction func onRegister(_ sender: Any) {
        guard let emailText = emailValue.text, !emailText.isEmpty,
              let passwordText = passwordValue.text, !passwordText.isEmpty,
              let confirmPasswordText = cPasswordValue.text, !confirmPasswordText.isEmpty else {
           showAlert(message: "Please fill in all fields")
            return
        }
        
        // Verifying email format
        guard Utilities.isValidEmail(emailText) else {
            showAlert(message: "Invalid email format")
            return
        }
        
        // Checking if the passwords match
        guard passwordText == confirmPasswordText else {
           showAlert(message: "Passwords do not match")
            return
        }
        
        // Attempting to insert the new user into the database
        let isSuccess = db.insert(email: emailText, password: passwordText)
        if isSuccess {
            showAlert(message: "Registration successful", isDismiss: true)
        } else {
            showAlert(message: "Registration failed")
        }
    }
    
    func showAlert(message: String, isDismiss: Bool = false) {
          let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
              if isDismiss {
                  let  storyboard = UIStoryboard(name:"Main", bundle:nil)
                  let screen = storyboard.instantiateViewController(withIdentifier: "cruiseHome") as! CruiseHomeController
                  screen.modalPresentationStyle = .fullScreen
                  self.navigationController?.pushViewController(screen, animated: true)
              }
          }))
          self.present(alert, animated: true)
      }
    
}


