//
//  RateViewController.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/25/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit
import Firebase

class RateViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var ratingPicker: UIPickerView!
    
    var item:MenuItem?
    let ratingOptions = [1,2,3,4,5,6,7,8,9,10]
    
    var ref:DatabaseReference?
    var rating:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        menuItemLabel.text = item?.name
        //ratingLabel.text = String(describing: rating)
        priceLabel.text = item?.price
        descriptionLabel.text = item?.description
        
        ref?.child("itemEntryIDs").child((item?.entryID)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // If a value exists that corresponds to the entryID key...
            if let value = snapshot.value as? Double?{
                if value == 0.0 {
                    self.ratingLabel.text = "NA"
                }else if value == 10.0{
                    self.ratingLabel.text = "10"
                }else{
                    self.ratingLabel.text = String(format:"%.1f", value!)
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToItemDetailsVC", sender: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let usersRating = Double(ratingPicker.selectedRow(inComponent: 0)) + 1.0
        
        ref?.child("itemEntryIDs").child((item?.entryID)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // If a value exists that corresponds to the entryID key...
            if let previousRating = snapshot.value as? Double?{
                
                if previousRating == 0.0 {
                    self.rating = usersRating
                    let editRef = self.ref?.child("itemEntryIDs")
                    editRef?.updateChildValues([(self.item?.entryID)!: self.rating!])
                    self.performSegue(withIdentifier: "unwindToItemDetailsVC", sender: self.rating!)
                }else{
                    self.rating = (previousRating! + usersRating)/2
                    let editRef = self.ref?.child("itemEntryIDs")
                    editRef?.updateChildValues([(self.item?.entryID)!: self.rating!])
                    self.performSegue(withIdentifier: "unwindToItemDetailsVC", sender: self.rating!)
                }
            }
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return ratingOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(ratingOptions[row])
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if sender != nil {
            let dest = segue.destination as! ItemDetailsVC
            dest.updateRatingLabel(rating: sender as! Double)
        }
    }

}
