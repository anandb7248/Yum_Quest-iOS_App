//
//  ItemDetailsVC.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/24/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit
import Firebase

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
    @IBOutlet weak var itemRatingLabel: UILabel!
    
    var ref:DatabaseReference?
    var itemRating:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       ref = Database.database().reference()
        
        nameLabel.text = restaurantName
        ratingLabel.text = rating
        ratingLabel.backgroundColor = hexStringToUIColor(hex: ratingColor)
        menuItemNameLabel.text = item?.name
        priceLabel.text = item?.price
        descriptionLabel.text = item?.description
        ref?.child("itemEntryIDs").child((item?.entryID)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // If a value exists that corresponds to the entryID key...
            if let value = snapshot.value as? Double?{
                if value! == 0.0 {
                    self.itemRatingLabel.text = "NA"
                }else if value == 10.0{
                    self.itemRatingLabel.text = "10"
                }else{
                    self.itemRatingLabel.text = String(format:"%.1f", value!)
                }
            }
        })
    }
    
    func updateRatingLabel(rating:Double) {
        if rating == 0.0 {
            self.itemRatingLabel.text = "NA"
        }else if rating == 10.0{
            self.itemRatingLabel.text = "10"
        }else{
            self.itemRatingLabel.text = String(format:"%.1f", rating)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ratingButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showRateView", sender: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMenuTableVC", sender: nil)
    }
    
    @IBAction func unwindToItemDetailsVC(segue: UIStoryboardSegue){}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRateView"{
            let rateView = segue.destination as! RateViewController
            rateView.item = item
        } else if segue.identifier == "unwindToMenuTableVC" {
            let table = segue.destination as!   MenuTableVC
            table.tableView.reloadData()
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
