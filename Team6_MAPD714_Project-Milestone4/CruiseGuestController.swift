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

class CruiseGuestController: UIViewController {
    
    // UI element references
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var oldAgeSwitch: UISwitch!
    @IBOutlet weak var adultCount: UITextField!
    @IBOutlet weak var childCount: UITextField!
    @IBOutlet weak var childCalculation: UILabel!
    @IBOutlet weak var adultCalculation: UILabel!
    @IBOutlet weak var totalCalculation: UILabel!
    
    var selectedCruise: Cruise?
    var selectedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupTargets()
    }
    
    // Sets up initial values and states for UI components
    private func setupInitialView() {
        oldAgeSwitch.isOn = false
        datePicker.datePickerMode = .date
        datePicker.date = Date() // Set to today's date
        
        formatDateAndSetSelectedDate()
        updateCalculations()
    }
    
    // Sets up target actions for UI elements
    private func setupTargets() {
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        adultCount.addTarget(self, action: #selector(adultChildCountChanged(_:)), for: .editingChanged)
        childCount.addTarget(self, action: #selector(adultChildCountChanged(_:)), for: .editingChanged)
    }
    
    // Updates calculations when adult or child count is changed
    @objc private func adultChildCountChanged(_ textField: UITextField) {
        updateCalculations()
    }
    
    // Formats the selected date and updates the selectedDate variable
    private func formatDateAndSetSelectedDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        selectedDate = dateFormatter.string(from: datePicker.date)
    }
    
    // Updates the price calculations based on input values
    private func updateCalculations() {
        let adultTotal = calculateTotal(count: adultCount.text ?? "0", price: selectedCruise?.adultPrice)
        let childTotal = calculateTotal(count: childCount.text ?? "0", price: selectedCruise?.childPrice)
        
        adultCalculation.text = "\(selectedCruise?.adultPrice ?? "0") * \(adultCount.text ?? "0") = \(adultTotal)"
        childCalculation.text = "\(selectedCruise?.childPrice ?? "0") * \(childCount.text ?? "0") = \(childTotal)"
        totalCalculation.text = String(childTotal + adultTotal)
    }
    
    // Calculates the total price based on count and price
    private func calculateTotal(count: String, price: String?) -> Int {
        let countInt = Int(count) ?? 0
        let priceInt = Int(price ?? "0") ?? 0
        return countInt * priceInt
    }
    
    // Handler for date picker value change
    @objc private func datePickerChanged(picker: UIDatePicker) {
        formatDateAndSetSelectedDate()
    }
    
    // Handler for navigating to the payment screen
    @IBAction func onNavigateToPayment(_ sender: Any) {
        if isValidForNavigation() {
            navigateToPayment()
        } else {
            showAlert(message: "Adult count is mandatory")
        }
    }
    
    // Validates if the navigation to payment is allowed
    private func isValidForNavigation() -> Bool {
        let adultCountValue = Int(adultCount.text ?? "0") ?? 0
        return adultCountValue > 0
    }
    
    // Navigates to the payment screen
    private func navigateToPayment() {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "cruisePayment") as! CruisePaymentController
        screen.modalPresentationStyle = .fullScreen
        screen.selectedCruise = selectedCruise
        let adultCountValue = Int(adultCount.text ?? "0") ?? 0
        let childCountValue = Int(childCount.text ?? "0") ?? 0
        let defaults = UserDefaults.standard
        
        defaults.set(selectedDate, forKey: "date")
        defaults.set(oldAgeSwitch.isOn, forKey: "extraCare")
        defaults.set(adultCountValue, forKey: "adultCount")
        defaults.set(childCountValue, forKey: "childCount")
        defaults.set(totalCalculation.text, forKey: "totalPrice")
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    // Function to show alert messages
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
