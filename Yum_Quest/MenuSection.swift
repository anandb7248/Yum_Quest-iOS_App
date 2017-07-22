//
//  MenuSection.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation
import SwiftyJSON

class MenuSection {
    let sectionName:String
    var sectionItems = [MenuItem]()
    
    init(sectionJSON: JSON) {
        //print("SECTION")
        //print(sectionJSON)
        sectionName = sectionJSON["name"].stringValue
        
        for item in sectionJSON["entries"]["items"] {
            sectionItems.append(MenuItem(itemJSON: item.1))
        }
    }
}
