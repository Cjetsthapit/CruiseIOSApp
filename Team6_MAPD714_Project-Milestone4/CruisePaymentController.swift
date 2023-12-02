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

class CruisePaymentController: UIViewController {
    
    // UI element references
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expiryDate: UITextField!
    @IBOutlet weak var cvc: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var cardType: UISegmentedControl!

    var selectedCruise: Cruise?
    var db = BookingDbManager()
    var cards = ["Credit Card","Debit Card"]

    override func viewDidLoad() {
        super.viewDidLoad()
        preloadEmail()
    }
    
    // Preloads email field with user's email from UserDefaults if available
    private func preloadEmail() {
        let defaults = UserDefaults.standard
        emailAddress.text = defaults.string(forKey: "email")
    }
    
    // Handles the navigation to the booking confirmation
    @IBAction func onNavigateToBooking(_ sender: Any) {
        if validateFields() {
            saveBookingAndNavigate()
        }
    }
    
    // Validates all input fields
    private func validateFields() -> Bool {
        // Check if any of the fields is empty
        let fields = [emailAddress, contactNumber, cardNumber, expiryDate, cvc, name, address, postalCode, state, country]
        for field in fields {
            if field?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                showAlert(message: "All fields must be filled")
                return false
            }
        }
        
        // Validate contact number (expected to be 10 digits)
        if let contactNum = contactNumber.text, contactNum.count != 10 || !contactNum.allSatisfy({ $0.isNumber }) {
            showAlert(message: "Phone number is incorrect")
            return false
        }
        
        // Validate card number (expected to be 16 digits)
        if let cardNum = cardNumber.text, cardNum.count != 16 || !cardNum.allSatisfy({ $0.isNumber }) {
            showAlert(message: "Card number must be 16 digits")
            return false
        }

        // Validate expiry date (expected pattern: MM/YY)
        let expiryDateRegex = "^(0[1-9]|1[0-2])\\/(\\d{2})$"
        if let expiry = expiryDate.text, !NSPredicate(format:"SELF MATCHES %@", expiryDateRegex).evaluate(with: expiry) {
            showAlert(message: "Expiry date pattern must be MM/YY")
            return false
        }
        
        // Validate CVC (expected to be 3 digits)
        if let cvcNum = cvc.text, cvcNum.count != 3 || !cvcNum.allSatisfy({ $0.isNumber }) {
            showAlert(message: "CVC must be 3 digits")
            return false
        }
        
        return true
    }

    // Saves booking information and navigates to the next screen
    private func saveBookingAndNavigate() {
        // Create a new booking instance
        let defaults = UserDefaults.standard
        let newBooking = Booking(
            id: UUID().uuidString,
            userId: defaults.integer(forKey: "id"),
            cruiseName: selectedCruise!.title,
            cruiseDescription: selectedCruise!.cruiseDescription,
            cruiseVisitingPlaces: selectedCruise!.visitingPlaces,
            cruiseDuration: selectedCruise!.duration,
            cruiseAdultPrice: selectedCruise!.adultPrice,
            cruiseChildPrice: selectedCruise!.childPrice,
            cruiseAdultCount: defaults.string(forKey: "adultCount")!,
            cruiseChildCount: defaults.string(forKey: "childCount")!,
            cruiseReservationDate: defaults.string(forKey: "date")!,
            cruiseExtraCare: defaults.bool(forKey: "extraCare"),
            cruiseTotalPrice: defaults.string(forKey: "totalPrice")!,
            email: defaults.string(forKey: "email")!,
            contactNumber: contactNumber.text!,
            cardType: cards[cardType.selectedSegmentIndex],
            cardNumber: cardNumber.text!,
            cardCVC: cvc.text!,
            cardExpiryDate: expiryDate.text!,
            name: name.text!,
            address: address.text!,
            postalCode: postalCode.text!,
            state: state.text!,
            country: country.text!
        )

        // Insert the booking into the database
        let bookingId = db.insert(booking: newBooking)
        if bookingId != "-1" {
            navigateToCheckout(with: bookingId)
        } else {
            showAlert(message: "Payment failed")
        }
    }

    // Navigates to the checkout screen with the given booking ID
    private func navigateToCheckout(with bookingId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "cruiseCheckout") as! CruiseCheckoutController
        screen.modalPresentationStyle = .fullScreen
        screen.bookingId = bookingId
        self.navigationController?.pushViewController(screen, animated: true)
    }

    // Displays an alert with a provided message
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

