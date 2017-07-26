//
//  LaunchViewController.swift
//  Yum_Quest
//
//  Created by AnandBatjargal on 7/25/17.
//  Copyright © 2017 anandb7248. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController,UITabBarDelegate {
    
    @IBOutlet weak var launchImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchImage.image = UIImage(named:"YumQuest_LaunchScreen55")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "About", image: UIImage(named: "launchTab"), tag: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
