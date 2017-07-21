//
//  RestaurantsNearMeVC.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/20/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

// Foursquare API - VenueMenu
//  https://api.foursquare.com/v2/
//                                  venues/VENUE_ID/menu

// How can we obtain the VENUE_ID of the nearby restaurants of the user?
//  https://api.foursquare.com/v2/venues/search?
//                                              ll=SOMETHING,SOMETHING&oath_token=


// https://api.foursquare.com/v2/venues/search?v=20161016&ll=35.305%2C%20-120.6625&intent=checkin&radius=10000&categoryId=4d4b7105d754a06374d81259&client_id=RT1SBOGHXRKX5KCQIAKDKDIOMHIYEDSPHXPHJTYYRPDUHVCX&client_secret=QNAZYTA3UEMCGMZQBZTB5FUHSQHYXH0N4KAQ4J5TOF354DKL

import UIKit
import CoreLocation
import Alamofire

class RestaurantsNearMeVC: UIViewController,UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var currentLat:CLLocationDegrees?
    var currentLon:CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configureLocationManager will set up the location manager and also set the currentLat and currentLon implicitly
        configureLocationManager()
        
    }
    
    func configureLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        
        // One-time call to obtain the users current location. This calls the method locationManager(didUpdateLocations)
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        
        currentLat = currentLocation.coordinate.latitude
        currentLon = currentLocation.coordinate.longitude
        
        getNearbyVenues(from:currentLat, from:currentLon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        return
    }
    
    func getNearbyVenues(from latitude: CLLocationDegrees?, from longitude: CLLocationDegrees?) {
        guard let lat = latitude, let lon = longitude
            else {
                return
            }
        
        // Create URL based on users current location in order to get the nearby restaurants.
        // This categoryID corresponds to venues related to Food, as research from Foursquare documentation-> categoryId=4d4b7105d754a06374d81259
        let foursquareSearchNearbyFoodURL = "https://api.foursquare.com/v2/venues/search?v=20161016&ll=\(lon)%2C%20\(lat)&intent=checkin&radius=10000&categoryId=4d4b7105d754a06374d81259&client_id=RT1SBOGHXRKX5KCQIAKDKDIOMHIYEDSPHXPHJTYYRPDUHVCX&client_secret=QNAZYTA3UEMCGMZQBZTB5FUHSQHYXH0N4KAQ4J5TOF354DKL"
        
        print(foursquareSearchNearbyFoodURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoCell", for: indexPath) as? RestaurantInfoTVCell
        
        return cell!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}