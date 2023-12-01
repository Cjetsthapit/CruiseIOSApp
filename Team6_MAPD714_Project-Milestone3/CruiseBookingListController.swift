//
//  CruiseBookingListController.swift
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

class CruiseBookingListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //variable declaration
    var db = BookingDbManager()
    var data :[BookingBrief]=[]
    
    //reference object for table
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        let defaults = UserDefaults.standard
        let id = (defaults.integer(forKey: "id"))
        data = db.readBookingsByUserId(userId: id)
    }
    
    //setting table row count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //setting table row value
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selected = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "bookingList", for: indexPath) as! CustomBookingList
        cell.reservationDate.text = selected.cruiseReservationDate
        cell.cruiseName.text = selected.cruiseName
        return cell
    }
    
    //setting table row click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCruise = data[indexPath.row]
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "cruiseCheckout") as! CruiseCheckoutController
        screen.modalPresentationStyle = .fullScreen
        screen.bookingId = selectedCruise.id
        screen.canNavigateBack = true
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    
    
    
}
