//
//  MenuSection.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation
import SwiftyJSON

class MenuCategory {
    var menuSections = [MenuSection]()
    
    init(menuObject:JSON) {
        //print("==========")
        //print(menuObject["entries"])
        //print("==========")
        
        for section in menuObject["entries"]["items"] {
            menuSections.append(MenuSection(sectionJSON: section.1))
        }
    }
    
    //print(menuJSON["response"]["menu"]["menus"]["items"])
    // MenuSection ->                                ["items"][0]["entries"]["items"][0]["name"]
    // Individual menu items from the MenuSection -> ["items"][0]["entries"]["items"][0]["entries"]["items"][0]["entryID"]
}
