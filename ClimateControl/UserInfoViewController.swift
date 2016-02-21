//
//  UserInfoViewController.swift
//  ClimateControl
//
//  Created by Akshat Goyal on 2/21/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import UIKit
import LoginWithClimate

class UserInfoViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var zipcode: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    var session: Session?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("name" + (session?.userInfo.firstName)!)
        
        name.text = (session?.userInfo.firstName)! + " " + (session?.userInfo.lastName)!
        
        
        address.text = session?.userInfo.address1
        zipcode.text = session?.userInfo.zip
        phone.text = session?.userInfo.phone
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
