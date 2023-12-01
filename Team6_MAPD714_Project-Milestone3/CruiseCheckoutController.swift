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

class CruiseCheckoutController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Struct for holding title and value for booking details
    struct Detail {
        let title: String
        let value: String
    }
    
    var bookingId: String?
    var canNavigateBack: Bool = false
    var BookingDetails: [Detail] = []
    
    var db = BookingDbManager() // Database manager for bookings
    
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides the back button if navigation back is not allowed
        if !canNavigateBack {
            self.navigationItem.hidesBackButton = true
        }

        // Setting up the table view
        table.dataSource = self
        table.delegate = self
        table.allowsSelection = false
        
        // Fetching booking details from the database and populating the BookingDetails array
        if let data = db.getBookingById(id: bookingId!) {
            let cruiseText = data.cruiseExtraCare ? "Yes" : "No"
            populateBookingDetails(with: data, cruiseText: cruiseText)
        }
    }

    // Populates the BookingDetails array with booking data
    private func populateBookingDetails(with data: Booking, cruiseText: String) {
        BookingDetails.append(Detail(title: "Name", value: data.name))
        BookingDetails.append(Detail(title: "Email", value: data.email))
        BookingDetails.append(Detail(title: "Phone Number", value: data.contactNumber))
        BookingDetails.append(Detail(title: "Address", value: data.address))
        BookingDetails.append(Detail(title: "Postal Code", value: data.postalCode))
        BookingDetails.append(Detail(title: "State", value: data.state))
        BookingDetails.append(Detail(title: "Country", value: data.country))
        BookingDetails.append(Detail(title: "Cruise", value: data.cruiseName))
        BookingDetails.append(Detail(title: "Cruise Duration", value: data.cruiseDuration))
        BookingDetails.append(Detail(title: "Visiting Places", value: data.cruiseVisitingPlaces))
        BookingDetails.append(Detail(title: "Adult", value: data.cruiseAdultCount))
        BookingDetails.append(Detail(title: "Child", value: data.cruiseChildCount))
        BookingDetails.append(Detail(title: "Total Price", value: data.cruiseTotalPrice))
        BookingDetails.append(Detail(title: "Reserved for", value: data.cruiseReservationDate))
        BookingDetails.append(Detail(title: "Need Extra Care", value: cruiseText))
        BookingDetails.append(Detail(title: "Payment Method", value: data.cardType))
    }
    
    // Table view data source method to set the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingDetails.count
    }
    
    // Table view data source method to configure each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selected = BookingDetails[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! BookedTableViewCell
        cell.title.text = selected.title
        cell.value.text = selected.value
        return cell
    }
    
    // Table view delegate method to set the height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    // Action method for the booking completed button
    @IBAction func bookingCompleted(_ sender: UIButton) {
        navigateToHomeScreen()
    }

    // Navigates to the home screen
    private func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeController = storyboard.instantiateViewController(withIdentifier: "cruiseHome") as! CruiseHomeController
        homeController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(homeController, animated: true)
    }
}

