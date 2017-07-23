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
        for section in menuObject["entries"]["items"] {
            menuSections.append(MenuSection(sectionJSON: section.1))
        }
    }
}
