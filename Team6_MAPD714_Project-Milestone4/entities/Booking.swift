//
//  User.swift
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

import Foundation

// Class representing detailed information about a cruise booking
class Booking{
    var id: String
    var userId: Int
    var cruiseName: String
    var cruiseDescription: String
    var cruiseVisitingPlaces: String
    var cruiseDuration: String
    var cruiseAdultPrice: String
    var cruiseChildPrice: String
    var cruiseAdultCount: String
    var cruiseChildCount: String
    var cruiseReservationDate: String
    var cruiseExtraCare: Bool
    var cruiseTotalPrice: String
    var email: String
    var contactNumber: String
    var cardType: String
    var cardNumber: String
    var cardCVC: String
    var cardExpiryDate: String
    var name: String
    var address: String
    var postalCode: String
    var state: String
    var country: String
    
    // Initializer for setting up a booking overview
    init(id:String,userId:Int, cruiseName: String, cruiseDescription: String, cruiseVisitingPlaces: String, cruiseDuration: String, cruiseAdultPrice: String, cruiseChildPrice: String, cruiseAdultCount: String, cruiseChildCount: String, cruiseReservationDate: String, cruiseExtraCare: Bool, cruiseTotalPrice: String, email: String, contactNumber: String, cardType: String, cardNumber: String, cardCVC: String, cardExpiryDate: String, name: String, address: String, postalCode: String, state: String, country: String) {
            self.id = id
            self.userId = userId
            self.cruiseName = cruiseName
            self.cruiseDescription = cruiseDescription
            self.cruiseVisitingPlaces = cruiseVisitingPlaces
            self.cruiseDuration = cruiseDuration
            self.cruiseAdultPrice = cruiseAdultPrice
            self.cruiseChildPrice = cruiseChildPrice
            self.cruiseAdultCount = cruiseAdultCount
            self.cruiseChildCount = cruiseChildCount
            self.cruiseReservationDate = cruiseReservationDate
            self.cruiseExtraCare = cruiseExtraCare
            self.cruiseTotalPrice = cruiseTotalPrice
            self.email = email
            self.contactNumber = contactNumber
            self.cardType = cardType
            self.cardNumber = cardNumber
            self.cardCVC = cardCVC
            self.cardExpiryDate = cardExpiryDate
            self.name = name
            self.address = address
            self.postalCode = postalCode
            self.state = state
            self.country = country
        }
}

//Class for brief booking details
class BookingBrief{
    var id: String
    var userId: Int
    var cruiseName: String
    var cruiseReservationDate: String
    
    // Initializer for setting up a brief booking overview
    init(id: String, userId: Int, cruiseName: String, cruiseReservationDate:String) {
        self.id = id
        self.userId = userId
        self.cruiseName = cruiseName
        self.cruiseReservationDate = cruiseReservationDate
    }
}

