//
//  MenuItem.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation
import SwiftyJSON

class MenuItem{
    let entryID:String
    let name:String
    let description:String
    var price:String
    //let rating:Float

    init(itemJSON: JSON) {
        entryID = itemJSON["entryId"].stringValue
        name    = itemJSON["name"].stringValue
        
        if itemJSON["description"].string != nil {
            description = itemJSON["description"].stringValue
        }else{
            description = ""
        }
        
        if itemJSON["price"].string != nil {
            price = itemJSON["price"].stringValue
            price.insert("$", at: price.startIndex)
        }else{
            price = ""
        }
        
        /* TEST - It works!
        print(entryID)
        print(name)
        print(description)
        print(price)
        */
    }
}
