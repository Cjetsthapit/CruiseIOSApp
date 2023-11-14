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

class CruiseDetailController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let cruiseImages = ["Cruise1","Cruise2","Cruise3","Cruise4","Cruise5"]
    //reference objects for labels
    @IBOutlet weak var cruiseTitle: UILabel!
    @IBOutlet weak var cruiseDescription: UILabel!
    @IBOutlet weak var cruiseVisitingPlaces: UILabel!
    @IBOutlet weak var cruiseDuration: UILabel!
    @IBOutlet weak var cruiseAdultPrice: UILabel!
    @IBOutlet weak var cruiseChildPrice: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    //variable for passed data
    var cName:String?
    var cDescription:String?
    var cVisitingPlaces:String?
    var cDuration:String?
    var cAdultPrice:String?
    var cChildPrice:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting label value
        collection.dataSource = self
        collection.delegate = self
        self.title = cName
//        cruiseTitle.text = cName
        cruiseDescription.text = cDescription
        cruiseVisitingPlaces.text = cVisitingPlaces
        cruiseDuration.text = cDuration
        cruiseAdultPrice.text = "Adult: \(cAdultPrice ?? "0" )"
        cruiseChildPrice.text = "Child: \(cChildPrice ?? "0")"

        // Do any additional setup after loading the view.
    }
    
    //collection number count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cruiseImages.count
    }
    
    //image set for collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CustomCollectionViewCell
        cell.cruiseImageCarousel.image = UIImage(named: cruiseImages[indexPath.row])
        return cell
    }
    
    //setting image size for collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width, height: collection.frame.height)
    }
    


}

