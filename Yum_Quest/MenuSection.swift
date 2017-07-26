//
//  MenuSection.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

class MenuSection {
    let sectionName:String
    var sectionItems = [MenuItem]()
    var databaseRef:DatabaseReference?
    
    init(sectionJSON: JSON, databaseRef: DatabaseReference?) {
        sectionName = sectionJSON["name"].stringValue
        
        for item in sectionJSON["entries"]["items"] {
            sectionItems.append(MenuItem(itemJSON: item.1, databaseRef: databaseRef))
        }
    }
}
