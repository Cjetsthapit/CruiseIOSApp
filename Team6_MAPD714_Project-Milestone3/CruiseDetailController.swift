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

class CruiseDetailController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Array of image names for the cruise
    let cruiseImages = ["Cruise1", "Cruise2", "Cruise3", "Cruise4", "Cruise5"]

    // Outlets for various UI components
    @IBOutlet weak var cruiseTitle: UILabel!
    @IBOutlet weak var cruiseDescription: UILabel!
    @IBOutlet weak var cruiseVisitingPlaces: UILabel!
    @IBOutlet weak var cruiseDuration: UILabel!
    @IBOutlet weak var cruiseAdultPrice: UILabel!
    @IBOutlet weak var cruiseChildPrice: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    // Variable to hold the selected cruise details
    var selectedCruise: Cruise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up the collection view
        collection.dataSource = self
        collection.delegate = self
        
        // Populating the UI with the selected cruise details
        updateCruiseDetails()
    }
    
    // Function to update the UI elements with cruise details
    private func updateCruiseDetails() {
        self.title = selectedCruise?.title
        cruiseDescription.text = selectedCruise?.cruiseDescription
        cruiseVisitingPlaces.text = selectedCruise?.visitingPlaces
        cruiseDuration.text = selectedCruise?.duration
        cruiseAdultPrice.text = "Adult: \(selectedCruise?.adultPrice ?? "0" )"
        cruiseChildPrice.text = "Child: \(selectedCruise?.childPrice ?? "0")"
    }
    
    // UICollectionViewDataSource method for item count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cruiseImages.count
    }
    
    // UICollectionViewDataSource method to set up cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CustomCollectionViewCell
        cell.cruiseImageCarousel.image = UIImage(named: cruiseImages[indexPath.row])
        return cell
    }
    

    // UICollectionViewDelegateFlowLayout method to set item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 200)
    }

    // Action for navigating to the guest information screen
    @IBAction func onNavigateToGuest(_ sender: Any) {
        navigateToGuestScreen()
    }

    // Function to handle navigation to the CruiseGuestController
    private func navigateToGuestScreen() {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let guestScreen = storyboard.instantiateViewController(withIdentifier: "cruiseGuest") as! CruiseGuestController
        guestScreen.modalPresentationStyle = .fullScreen
        guestScreen.selectedCruise = selectedCruise
        self.navigationController?.pushViewController(guestScreen, animated: true)
    }
}
