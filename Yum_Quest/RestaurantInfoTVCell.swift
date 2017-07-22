//
//  RestaurantInfoTVCell.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/20/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit

class RestaurantInfoTVCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var canViewMenuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
