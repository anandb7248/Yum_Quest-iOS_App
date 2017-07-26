//
//  NearbyRestaurants.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/20/17.
//  Copyright © 2017 anandb7248. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation
import MapKit
import Firebase

let metersToMilesConversionRate:Double = 0.000621371

class NearbyRestaurant {
    let venueID:String
    let name:String
    let menuItems:Menu?
    var hasMenu:Bool
    let menuBackgroundColor:UIColor
    let distanceFromCurrentLocationMiles:Double
    
    var rating:String?
    var ratingColor:String?
    var priceTier:String?
    let address:String?
    //let cityStateZip:String?
    //let country:String?
    var category:String?
    
    /* lat and lon will be used to show restaurant location annotations on the map */
    //let lat:Double
    //let lon:Double
    var coordinate: CLLocationCoordinate2D
    var databaseRef:DatabaseReference?
    
    init(venueID:String, name:String, hasMenu:Bool, distanceFromCurrentLocation inMeters:String,lat:String,lon:String,address:String?,tableView:UITableView, databaseRef: DatabaseReference?) {
        self.venueID = venueID
        self.name = name
        //self.hasMenu = hasMenu
        // If the restaurant allows the user to view the menu, then do an API call to obtain all the menu information.
        
        if hasMenu == true {
            self.menuItems = Menu(venueID: venueID, databaseRef: databaseRef)
            self.hasMenu = true
            self.menuBackgroundColor = UIColor.orange
        }else{
            self.menuItems = nil
            self.hasMenu = false
            self.menuBackgroundColor = UIColor.white
        }
        
        let miles = Double(inMeters)! * metersToMilesConversionRate
        
        // Save the miles value to two significant figures
        self.distanceFromCurrentLocationMiles = Double(round(10*miles)/10)
        
        self.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
        self.address = address
        
        // Call Foursquare API using the venueID to obtain additional information regarding the restaurant
        let venueDetailsURL:URLConvertible = "https://api.foursquare.com/v2/venues/\(venueID)?client_id=RT1SBOGHXRKX5KCQIAKDKDIOMHIYEDSPHXPHJTYYRPDUHVCX&client_secret=QNAZYTA3UEMCGMZQBZTB5FUHSQHYXH0N4KAQ4J5TOF354DKL&v=20170721"
        
        Alamofire.request(venueDetailsURL).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let venueDetailsJSON = JSON(responseData.result.value!)

                if (venueDetailsJSON["meta"]["code"].stringValue == "200") {
                    //PriceTier - Works
                    self.priceTier = venueDetailsJSON["response"]["venue"]["attributes"]["groups"][0]["summary"].stringValue
                    
                    if self.priceTier == "Credit Cards" {
                        self.priceTier = " "
                    }
                    
                    //Rating - Might need fixing in the future here
                    //print(venueDetailsJSON["response"]["venue"]["rating"])
                    self.rating = venueDetailsJSON["response"]["venue"]["rating"].stringValue
                    //print(self.rating)
                    if (self.rating?.characters.count)! > 3 {
                        self.rating = self.rating?.substring(to: (self.rating?.index((self.rating?.startIndex)!, offsetBy: 3))!)
                    }
            
                    //Rating Color - Works
                    //print(venueDetailsJSON["response"]["venue"]["ratingColor"])
                    self.ratingColor = venueDetailsJSON["response"]["venue"]["ratingColor"].stringValue
                    //Category - Works
                    //print(venueDetailsJSON["response"]["venue"]["categories"][0]["name"])
                    self.category = venueDetailsJSON["response"]["venue"]["categories"][0]["name"].stringValue
                    /* Works!
                    print(self.priceTier!)
                    print(self.category!)
                    print(self.rating!)
                    print(self.ratingColor!)
                    */
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }else{
                    // Handle error
                }
                //print(venueDetailsJSON)
            }
        }
    }
}
