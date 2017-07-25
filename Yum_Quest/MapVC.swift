//
//  MapVC.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var restaurantsLocale = [RestaurantLocale]()
    
    // This function is called everytime the user's location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get the most recent position of the user
        let location = locations[0]
        
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        // Show the default blue dot that represents the users location
        self.map.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        map.isUserInteractionEnabled = true
        map.addAnnotations(restaurantsLocale)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRestaurantLocales(listOfRestaurants: [NearbyRestaurant]) {
        for restaurant in listOfRestaurants {
            if let category = restaurant.category, let price = restaurant.priceTier {
                let locale = RestaurantLocale(coord: restaurant.coordinate, named: restaurant.name, detail: category + " " + price)
                
                    restaurantsLocale.append(locale)
            }
        }
    }
    
    // The following method below will be called each time an annotation is about to show in the map.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinView = MKPinAnnotationView()
        pinView.pinTintColor = .red
        pinView.canShowCallout = true
            return pinView
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
