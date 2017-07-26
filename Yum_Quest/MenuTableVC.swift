//
//  MenuSections.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/23/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit

class MenuTableVC: UITableViewController {

    // var menu will be initialized by MenuDetailsVC's segue
    var restaurantName:String?
    var restaurantRating:String?
    var restaurantRatingColor:String?
    var menu:Menu?
    var menuSections = [String]()
    var menuItems = [[MenuItem]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        setUpMenuSectionsAndRows(restaurantMenu: menu!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpMenuSectionsAndRows(restaurantMenu:Menu) {
        for menu in restaurantMenu.menuCategories {
            for section in menu.menuSections{
                // Would be sections for our table
                //print(section.sectionName)
                var itemsForSection = [MenuItem]()
                menuSections.append(section.sectionName)
                
                for item in section.sectionItems{
                    // Individual menu items
                   // print("-----" + item.name)
                    itemsForSection.append(item)
                }
                menuItems.append(itemsForSection)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return menuSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MenuItemsTableViewCell
        
        cell?.nameLabel.text = menuItems[indexPath.section][indexPath.row].name
        cell?.priceLabel.text = menuItems[indexPath.section][indexPath.row].price
        //cell?.descriptionLabel.text = menuItems[indexPath.section][indexPath.row].description
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuSections[section]
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRateItem"{
            let item = segue.destination as! ItemDetailsVC
            
            item.restaurantName = restaurantName
            item.rating = restaurantRating
            item.ratingColor = restaurantRatingColor
            
            let selectedIndexPath = tableView.indexPathForSelectedRow
            
            item.item = menuItems[(selectedIndexPath?.section)!][(selectedIndexPath?.row)!]
            
        //menuItems[indexPath.section][indexPath.row].name
        }
    }

}
