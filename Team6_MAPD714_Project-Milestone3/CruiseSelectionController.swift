//
//  CruiseSelection.swift
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

class CruiseSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets for the table and search bar
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //setting cruise list
    let cruiseArray: [Cruise] = CruiseData.allCruises
    
    // Array for storing filtered cruises based on search
    var filteredCruises: [Cruise] = []
    
    // Setting up the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assigning table data source and delegate to self
        table.dataSource = self
        table.delegate = self
    }
    
    // Number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return count based on whether the search bar is used or not
        return searchBar.text?.isEmpty ?? true ? cruiseArray.count : filteredCruises.count
    }
    
    // Configuring each cell in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Choosing the right cruise array based on search bar use
        let selected = searchBar.text?.isEmpty ?? true ? cruiseArray[indexPath.row] : filteredCruises[indexPath.row]
        // Dequeueing and setting up the cell
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.cruiseName.text = selected.title
        cell.cruiseImage.image = UIImage(named: selected.imageName)
        cell.cruiseDuration.text = selected.duration
        return cell
    }
    
    // Setting the row height in the table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // Handling selection of a table row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Getting the selected cruise
        let selectedCruise = searchBar.text?.isEmpty ?? true ? cruiseArray[indexPath.row] : filteredCruises[indexPath.row]
        // Navigating to the details screen
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "cruiseDetail") as! CruiseDetailController
        screen.modalPresentationStyle = .fullScreen
        screen.selectedCruise = selectedCruise
        self.navigationController?.pushViewController(screen, animated: true)
    }
}


// Extension for CruiseSelectionController to handle search bar functionality
extension CruiseSelectionController: UISearchBarDelegate {
    // Updating the list as the user types in the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCruises = searchText.isEmpty ? cruiseArray : cruiseArray.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        table.reloadData()
    }
    
    // Dismissing the keyboard when the search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

