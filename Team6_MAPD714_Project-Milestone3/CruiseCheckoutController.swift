//
//  SelectCruiseController.swift
//  Team6_MAPD714_Project-Milestone3
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

class CruiseCheckoutController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    struct Detail {
        let title: String
        let value: String
    }
    
    //dummy dataset
    let BookingDetails: [Detail] = [
        Detail(title: "Name", value: "Srijeet Sthapit"),
        Detail(title: "Email", value: "sthapitsrijeet@gmail.com"),
        Detail(title: "Phone Number", value: "647 646 6464"),
        Detail(title: "Address", value: "8 Sachems"),
        Detail(title: "Country", value: "Canada"),
        Detail(title: "Cruise", value: "Bahamas Cruise"),
        Detail(title: "Cruise Duration", value: "3 Days 4 nights"),
        Detail(title: "Adult", value: "2"),
        Detail(title: "Child", value: "3"),
        Detail(title: "Total Price", value: "$300"),
        Detail(title: "Reserved for", value: "2023-12-12"),
    ]
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        table.dataSource = self
        table.delegate = self
    }
    
    //set table row count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingDetails.count
    }
    
    //set table value for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selected = BookingDetails[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! BookedTableViewCell
        cell.title.text = selected.title
        cell.value.text = selected.value
        return cell
    }
    
    //set table row height size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    //navigation to home page
    @IBAction func bookingCompleted(_ sender: UIButton) {
        let  storyboard = UIStoryboard(name:"Main", bundle:nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "cruiseHome") as! CruiseHomeController
        screen.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(screen, animated: true)
    }
    

}

