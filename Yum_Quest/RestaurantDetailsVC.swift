//
//  RestaurantDetailsVC.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/23/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit

class RestaurantDetailsVC: UIViewController {

    var restaurantDetail:NearbyRestaurant?
    var ratingBackgroundColor:UIColor?
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceTierLabel: UILabel!
    
    @IBOutlet weak var viewMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingBackgroundColor = hexStringToUIColor(hex: restaurantDetail?.ratingColor)
        
        restaurantNameLabel.text = restaurantDetail?.name
        ratingLabel.text = restaurantDetail?.rating
        ratingLabel.backgroundColor = ratingBackgroundColor
        addressLabel.text = restaurantDetail?.address
        categoryLabel.text = restaurantDetail?.category
        priceTierLabel.text = restaurantDetail?.priceTier
        
        // If the restaurant doesn't have a menu, hide the View Menu button
        if !(restaurantDetail?.hasMenu)! {
            viewMenuButton.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showMenu" {
            let menuDetails = segue.destination as! MenuDetailsVC
            menuDetails.chosenRestaurant = restaurantDetail
            menuDetails.ratingBackgroundColor = ratingBackgroundColor
            
            /*
            menuDetails.nameLabel.text = restaurantDetail?.name
            menuDetails.ratingLabel.text = restaurantDetail?.rating
            menuDetails.ratingLabel.backgroundColor = backgroundColor
            */
        }
    }
    
    func hexStringToUIColor (hex:String?) -> UIColor {
        guard let hex = hex else {
            return UIColor.white
        }
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
