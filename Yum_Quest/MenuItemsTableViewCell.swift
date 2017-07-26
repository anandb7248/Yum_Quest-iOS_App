//
//  MenuItemsTableViewCell.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/24/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit

class MenuItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
