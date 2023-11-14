//
//  CruiseSelection.swift
//  Team6_MAPD714_Project-Milestone3
//
//  Created by Srijeet Sthapit on 2023-11-12.
//

import UIKit

class CruiseSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    struct Cruise {
        let title: String
        let imageName: String
        let cruiseDescription: String
        let visitingPlaces: String
        let durationDays: String
        let durationNight: String
        let duration: String
        let adultPrice: String
        let childPrice: String
    }
    
    let cruiseArray: [Cruise] = [
        Cruise(title: "Bahamas Cruise" ,
               imageName: "Cruise1",
               cruiseDescription:"Bhamas Surf, sand and sun await on a Bahamas cruise. Indulge in rest and relaxation while lounging on unspoiled beaches that offer breathtaking views of the Atlantic Ocean.",
               visitingPlaces:"Nassau, Freeport, Grand Bahama Island, Half Moon Cay (Private Island), CocoCay (Private Island)",
               durationDays: "3", 
               durationNight:"2",
               duration:"3 days 2 nights",
               adultPrice:"300",
               childPrice: "200"
              ),
        Cruise(title: "Cuba Cruise" , imageName: "Cruise2",
               cruiseDescription:"Cuba Surf, sand and sun await on a Bahamas cruise. Indulge in rest and relaxation while lounging on unspoiled beaches that offer breathtaking views of the Atlantic Ocean.",
               visitingPlaces:"Nassau, Freeport, Grand Bahama Island, Half Moon Cay (Private Island), CocoCay (Private Island)",
               durationDays: "3",
               durationNight:"2",
               duration:"3 days 2 nights",
               adultPrice:"300",
               childPrice: "200"),
        Cruise(title: "Caribbean Cruise" , imageName: "Cruise3",
               cruiseDescription:"Caribbean Surf, sand and sun await on a Bahamas cruise. Indulge in rest and relaxation while lounging on unspoiled beaches that offer breathtaking views of the Atlantic Ocean.",
               visitingPlaces:"Nassau, Freeport, Grand Bahama Island, Half Moon Cay (Private Island), CocoCay (Private Island)",
               durationDays: "3",
               durationNight:"2",
               duration:"5 days 4 nights",
               adultPrice:"300",
               childPrice: "200"),
        Cruise(title: "Sampler Cruise" , imageName: "Cruise4",
               cruiseDescription:"Sampler Surf, sand and sun await on a Bahamas cruise. Indulge in rest and relaxation while lounging on unspoiled beaches that offer breathtaking views of the Atlantic Ocean.",
               visitingPlaces:"Nassau, Freeport, Grand Bahama Island, Half Moon Cay (Private Island), CocoCay (Private Island)",
               durationDays: "3",
               durationNight:"2",
               duration:"8 days 9 nights",
               adultPrice:"300",
               childPrice: "200"),
        Cruise(title: "Star Cruise" , imageName: "Cruise5",
               cruiseDescription:"Star Surf, sand and sun await on a Bahamas cruise. Indulge in rest and relaxation while lounging on unspoiled beaches that offer breathtaking views of the Atlantic Ocean.",
               visitingPlaces:"Nassau, Freeport, Grand Bahama Island, Half Moon Cay (Private Island), CocoCay (Private Island)",
               durationDays: "3",
               durationNight:"2",
               duration:"7 days 7 nights",
               adultPrice:"200",
               childPrice: "100"),
        Cruise(title: "Atlantis Cruise" , imageName: "Cruise1",
               cruiseDescription:"Atlantis Surf, sand and sun await on a Bahamas cruise. Indulge in rest and relaxation while lounging on unspoiled beaches that offer breathtaking views of the Atlantic Ocean.",
               visitingPlaces:"Nassau, Freeport, Grand Bahama Island, Half Moon Cay (Private Island), CocoCay (Private Island)",
               durationDays: "3",
               durationNight:"2",
               duration:"3 days 4 nights",
               adultPrice:"300",
               childPrice: "200"),
        Cruise(title: "Pacific Cruise" , imageName: "Cruise2",
               cruiseDescription:"Pacific Surf, sand and sun await on a Bahamas cruise. Indulge in rest and relaxation while lounging on unspoiled beaches that offer breathtaking views of the Atlantic Ocean.",
               visitingPlaces:"Nassau, Freeport, Grand Bahama Island, Half Moon Cay (Private Island), CocoCay (Private Island)",
               durationDays: "3",
               durationNight:"2",
               duration:"4 days 3 nights",
               adultPrice:"300",
               childPrice: "200"),
    ]
    
    var filteredCruises: [Cruise] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
    }
    
    //setting table row count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBar.text?.isEmpty ?? true ? cruiseArray.count : filteredCruises.count
    }

    //filling table values
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selected = searchBar.text?.isEmpty ?? true ? cruiseArray[indexPath.row] : filteredCruises[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.cruiseName.text = selected.title
        cell.cruiseImage.image = UIImage(named: selected.imageName)
        cell.cruiseDuration.text = selected.duration
        return cell
    }

    //setting table row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    //table row click function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedCruise = cruiseArray[indexPath.row]
        let  storyboard = UIStoryboard(name:"Main", bundle:nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "cruiseDetail") as! CruiseDetailController
        screen.modalPresentationStyle = .fullScreen
        screen.cName = selectedCruise.title
        screen.cDescription = selectedCruise.cruiseDescription
        screen.cVisitingPlaces = selectedCruise.visitingPlaces
        screen.cDuration = selectedCruise.duration
        screen.cAdultPrice = selectedCruise.adultPrice
        screen.cChildPrice = selectedCruise.childPrice
        self.navigationController?.pushViewController(screen, animated: true)
     }
}


//extension of CruiseSelction for search bar
extension CruiseSelectionController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCruises = cruiseArray
        } else {
            filteredCruises = cruiseArray.filter { cruise in
                return cruise.title.lowercased().contains(searchText.lowercased())
            }
        }
        table.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() 
    }
}

