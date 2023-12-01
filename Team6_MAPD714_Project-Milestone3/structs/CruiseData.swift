
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

import Foundation

struct CruiseData {
    static let allCruises: [Cruise] = [
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
}
