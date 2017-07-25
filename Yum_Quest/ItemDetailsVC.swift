//
//  ItemDetailsVC.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/24/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {

    var item:MenuItem?
    var restaurantName:String?
    var rating:String?
    var ratingColor:String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var menuItemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = restaurantName
        ratingLabel.text = rating
        ratingLabel.backgroundColor = hexStringToUIColor(hex: ratingColor)
        menuItemNameLabel.text = item?.name
        priceLabel.text = item?.price
        descriptionLabel.text = item?.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
