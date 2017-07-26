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

class MenuCategory {
    var menuSections = [MenuSection]()
    var databaseRef:DatabaseReference?
    
    init(menuObject:JSON, databaseRef: DatabaseReference?) {
        for section in menuObject["entries"]["items"] {
            menuSections.append(MenuSection(sectionJSON: section.1, databaseRef:databaseRef))
        }
    }
}
