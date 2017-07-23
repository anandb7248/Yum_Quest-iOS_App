//
//  RestaurantLocale.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/22/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation
import MapKit

class RestaurantLocale : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var rating: String?
    //var category: String?
    
    init(coord: CLLocationCoordinate2D, named: String, detail: String) {
        coordinate = coord
        title = named
        
        super.init()
    }
    
}
