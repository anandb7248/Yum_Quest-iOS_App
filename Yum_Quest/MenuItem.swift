//
//  MenuItem.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

class MenuItem{
    let entryID:String
    let name:String
    let description:String
    var price:String
    //let rating:Float
    var databaseRef:DatabaseReference?

    init(itemJSON: JSON, databaseRef: DatabaseReference?) {
        entryID = itemJSON["entryId"].stringValue
        //
        databaseRef?.child("itemEntryIDs").child(itemJSON["entryId"].stringValue).observeSingleEvent(of: .value, with: { (snapshot) in
            // If a value exists that corresponds to the entryID key...
            if (snapshot.value as? Double?) != nil{
                // Do nothing
            }else{
                // If a value does not exist that corresponds to the entryID key
                //databaseRef?.child("itemEntryIDs").setValue([name: 0.0])
                let newStandRef = databaseRef?.child("itemEntryIDs").child(itemJSON["entryId"].stringValue)
                newStandRef?.setValue(0.0)
            }
        })
        //
        
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
        
        /*
        // TEST
        print(entryID)
        print(name)
        print(description)
        print(price)
        // TEST
        */
    }
}
