//
//  MenuDetailsVC.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/23/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit

class MenuDetailsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var chosenRestaurant:NearbyRestaurant?
    
    var ratingBackgroundColor:UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = chosenRestaurant?.name
        ratingLabel.text = chosenRestaurant?.rating
        ratingLabel.backgroundColor = ratingBackgroundColor
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
        
        if segue.identifier == "showSections" {
            let restaurant = segue.destination as! MenuSectionsTableVC
            restaurant.menuCategories = chosenRestaurant?.menuItems?.menuCategories
        }
    }

}
