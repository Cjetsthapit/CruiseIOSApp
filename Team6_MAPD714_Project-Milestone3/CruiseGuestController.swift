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

class CruiseGuestController: UIViewController {

    //reference for ui elements
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var oldAgeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        oldAgeSwitch.isOn = false
        datePicker.datePickerMode = .date
               datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let selectedDate = dateFormatter.string(from: picker.date)
            print("Selected date is \(selectedDate)")
        }
    

    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
                   print("Switch is ON")
               } else {
                   print("Switch is OFF")
               }
    }
    

    
}

