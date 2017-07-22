//
//  Menu.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/21/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

/*
 https://api.foursquare.com/v2/venues/VENUEID/menu?client_id=RT1SBOGHXRKX5KCQIAKDKDIOMHIYEDSPHXPHJTYYRPDUHVCX&client_secret=QNAZYTA3UEMCGMZQBZTB5FUHSQHYXH0N4KAQ4J5TOF354DKL&v=20170721
 */

import Foundation
import Alamofire
import SwiftyJSON

class Menu {
    var menuCategories = [MenuCategory]()
    
    // TEST - VENUE_ID = 5972b355db04f528d7abf99d
    
    init(venueID: String) {
        let menuURL:URLConvertible =
         "https://api.foursquare.com/v2/venues/\(venueID)/menu?client_id=RT1SBOGHXRKX5KCQIAKDKDIOMHIYEDSPHXPHJTYYRPDUHVCX&client_secret=QNAZYTA3UEMCGMZQBZTB5FUHSQHYXH0N4KAQ4J5TOF354DKL&v=20170721"
        
        Alamofire.request(menuURL).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let menuJSON = JSON(responseData.result.value!)
                
                // Check the HTTP status
                if(menuJSON["meta"]["code"].stringValue == "200"){
                    // TEST - Print Menu Sections
                     //print(menuJSON["response"]["menu"]["menus"]["items"][0])
                    
                    /*
                    // ["items"] -> array
                    //print(menuJSON["response"]["menu"]["menus"]["items"])
                    // MenuSection -> ["items"][0]["entries"]["items"][0]["name"]
                    // Individual menu items from the MenuSection -> ["items"][0]["entries"]["items"][0]["entries"]["items"][0]["entryID"]
                    print("===================================")
                    print("===================================")
                    print("===================================")
                    print("===================================")
                    print("===================================")
                    */
                    
                    /* NOTE
                    // Some responses have "count" : 0, even though their hasMenu variable is set to true.
                    if (menuJSON["response"]["menu"]["menus"]["count"].stringValue == "0"){
                        print(menuJSON["response"]["menu"]["menus"])
                    }
                    */
                    
                    for jsonObject in menuJSON["response"]["menu"]["menus"]["items"] {
                        self.menuCategories.append(MenuCategory(menuObject:jsonObject.1))
                    }
                    
                }else{
                    // Throw an error or give error message
                }

            }
        }
    }
}
