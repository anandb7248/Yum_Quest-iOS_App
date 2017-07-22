//
//  NearbyRestaurants.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/20/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//


import Foundation

let metersToMilesConversionRate:Double = 0.000621371

class NearbyRestaurant {
    let venueID:String
    let name:String
    let menuItems:Menu?
    let hasMenu:Bool
    let distanceFromCurrentLocationMiles:Double
    
    init(venueID:String, name:String, hasMenu:Bool, distanceFromCurrentLocation inMeters:String) {
        self.venueID = venueID
        self.name = name
        self.hasMenu = hasMenu
        // If the restaurant allows the user to view the menu, then do an API call to obtain all the menu information.
        
        if hasMenu == true {
            self.menuItems = Menu(venueID: venueID)
        }else{
            self.menuItems = nil
        }

        let miles = Double(inMeters)! * metersToMilesConversionRate
        
        // Save the miles value to two significant figures
        self.distanceFromCurrentLocationMiles = Double(round(10*miles)/10)
    }
}
