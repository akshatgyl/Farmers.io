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
    
    private lazy var presentationAnimator = GuillotineTransitionAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(session)
        
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
    
    @IBOutlet weak var toMenu: UIButton!
    
    @IBAction func toAction(sender: UIButton) {
        let menuVC = storyboard!.instantiateViewControllerWithIdentifier("MenuViewController")
        menuVC.modalPresentationStyle = .Custom
        menuVC.transitioningDelegate = self
        if menuVC is GuillotineAnimationDelegate {
            presentationAnimator.animationDelegate = menuVC as? GuillotineAnimationDelegate
        }
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        self.presentViewController(menuVC, animated: true, completion: nil)
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


extension UserInfoViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Presentation
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Dismissal
        return presentationAnimator
    }
}