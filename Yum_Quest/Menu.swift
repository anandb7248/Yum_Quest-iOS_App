//
//  Menu.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Firebase

class Menu {
    var menuCategories = [MenuCategory]()
    var databaseRef:DatabaseReference?
    
    init(venueID: String, databaseRef: DatabaseReference?) {
        let menuURL:URLConvertible =
         "https://api.foursquare.com/v2/venues/\(venueID)/menu?client_id=RT1SBOGHXRKX5KCQIAKDKDIOMHIYEDSPHXPHJTYYRPDUHVCX&client_secret=QNAZYTA3UEMCGMZQBZTB5FUHSQHYXH0N4KAQ4J5TOF354DKL&v=20170721"
        
        Alamofire.request(menuURL).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let menuJSON = JSON(responseData.result.value!)
                
                // Check the HTTP status
                if(menuJSON["meta"]["code"].stringValue == "200"){
                    /* NOTE
                    // Some responses have "count" : 0, even though their hasMenu variable is set to true.
                    // Need a way to deal with this. Work in progress.
                    if (menuJSON["response"]["menu"]["menus"]["count"].stringValue == "0"){
                        print(menuJSON["response"]["menu"]["menus"])
                    }
                    */
                    
                    for jsonObject in menuJSON["response"]["menu"]["menus"]["items"] {
                        self.menuCategories.append(MenuCategory(menuObject:jsonObject.1, databaseRef: databaseRef))
                    }
                }else{
                    // Throw an error or give error message. Work in progress.
                }

            }
        }
    }
}
