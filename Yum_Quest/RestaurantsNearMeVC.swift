//
//  RestaurantsNearMeVC.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/20/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class RestaurantsNearMeVC: UIViewController,UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    var currentLat:CLLocationDegrees?
    var currentLon:CLLocationDegrees?
    
    var listOfNearbyRestaurants = [NearbyRestaurant]()
    
    @IBOutlet weak var tableView: UITableView!
    
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
        // Work in progress.
        return
    }
    
    func getNearbyVenues(from latitude: CLLocationDegrees?, from longitude: CLLocationDegrees?) {
        guard let lat = latitude, let lon = longitude
            else {
                // Will find a way to handle this potential error. Work in Progress
                return
            }
        
        // Create URL based on users current location in order to get the nearby restaurants.
        // This categoryID corresponds to venues related to Food, as research from Foursquare documentation-> categoryId=4d4b7105d754a06374d81259
        let foursquareSearchNearbyFoodURL:URLConvertible = "https://api.foursquare.com/v2/venues/search?v=20161016&ll=\(lat)%2C%20\(lon)&intent=checkin&radius=10000&categoryId=4d4b7105d754a06374d81259&client_id=RT1SBOGHXRKX5KCQIAKDKDIOMHIYEDSPHXPHJTYYRPDUHVCX&client_secret=QNAZYTA3UEMCGMZQBZTB5FUHSQHYXH0N4KAQ4J5TOF354DKL"
        
        // Traverse through the JSON object obtained from the foursquare API
        Alamofire.request(foursquareSearchNearbyFoodURL).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let nearbyRestaurantsJSON = JSON(responseData.result.value!)
                
                // Check the ["meta"]["code"] for 200 (OK).
                if(nearbyRestaurantsJSON["meta"]["code"].stringValue == "200"){
                    
                    self.listOfNearbyRestaurants = [NearbyRestaurant]()
                    
                    for (_,restaurantJSON) in nearbyRestaurantsJSON["response"]["venues"].enumerated(){
                        
                        //print(restaurantJSON.1["location"]["address"])
                        
                        /*
                        // Everything works as intended
                        print(restaurantJSON.1["name"])
                        print(restaurantJSON.1["location"]["distance"])
                        print(restaurantJSON.1["id"])
                        print(restaurantJSON.1["hasMenu"]) // Will be either "true" or "null"
                            // ["categories"]["id"]// In the future it looks like I need to filter out venues where it is not traditionally known as restaurants e.g. Gas Stations
                            //["categories"]["pluralName"]
                        */
                        //print(restaurantJSON.1["location"]["lat"])
                        //print(restaurantJSON.1["location"]["lng"])
                        
                        if(restaurantJSON.1["hasMenu"].stringValue == "true"){
                            self.listOfNearbyRestaurants.append(NearbyRestaurant(venueID:restaurantJSON.1["id"].stringValue,name:restaurantJSON.1["name"].stringValue,hasMenu: true, distanceFromCurrentLocation:restaurantJSON.1["location"]["distance"].stringValue,lat:restaurantJSON.1["location"]["lat"].stringValue,lon:restaurantJSON.1["location"]["lng"].stringValue,address:restaurantJSON.1["location"]["address"].string))
                        }
                        else{
                            self.listOfNearbyRestaurants.append(NearbyRestaurant(venueID:restaurantJSON.1["id"].stringValue,name:restaurantJSON.1["name"].stringValue,hasMenu: false, distanceFromCurrentLocation:restaurantJSON.1["location"]["distance"].stringValue,lat:restaurantJSON.1["location"]["lat"].stringValue,lon:restaurantJSON.1["location"]["lng"].stringValue, address:restaurantJSON.1["location"]["address"].string))
                        }
                    }
                    
                    // Sort the array of nearby restaurants by the ditance from the current location. The restaurants being the closest sorted to start at the beginning of the array.
                    self.listOfNearbyRestaurants = self.listOfNearbyRestaurants.sorted(by: { $0.distanceFromCurrentLocationMiles < $1.distanceFromCurrentLocationMiles})
                    
                    /*
                    // IT WORKS
                    // Test the array
                    for item in self.listOfNearbyRestaurants {
                        print(item.name)
                        print(item.venueID)
                        print(item.hasMenu)
                        print(item.distanceFromCurrentLocationMiles)
                    }
                    */
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }else{
                    // Throw error or print error message as there was something wrong with our API call
                    print("ERROR")
                }
                
                // TEST
                //print(nearbyRestaurantsSwiftyJSON)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return listOfNearbyRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoCell", for: indexPath) as? RestaurantInfoTVCell
        let restaurant = listOfNearbyRestaurants[indexPath.row]
        
        cell?.restaurantNameLabel.text = restaurant.name
        cell?.distanceLabel.text = String(restaurant.distanceFromCurrentLocationMiles)
        // Determine if we need to display the "View/Rate Menu" for the table cell
        if !restaurant.hasMenu {
            cell?.canViewMenuLabel.isHidden = true
        }
        
        return cell!
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Prepare for segue to MapVC
        if(segue.identifier == "showMap"){
            let mapVC = segue.destination as! MapVC
            
        }
    }

}
