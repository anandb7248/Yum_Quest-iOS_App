//
//  NearbyRestaurants.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/20/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation

class NearbyRestaurant {
    let venueID:String
    let name:String
    let hasMenu:Bool
    let distanceFromCurrentLocation:Int
    
    init(venueID:String, name:String, hasMenu:Bool, distanceFromCurrentLocation:String) {
        self.venueID = venueID
        self.name = name
        self.hasMenu = hasMenu
        self.distanceFromCurrentLocation = Int(distanceFromCurrentLocation)!
    }
}
