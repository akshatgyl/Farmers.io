//
//  ViewController.swift
//  ClimateControl
//
//  Created by Akshat Goyal on 2/20/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import UIKit
import LoginWithClimate

class LoginViewController: UIViewController, LoginWithClimateDelegate {
    
    var accessToken: String?
    var seesion: Session?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginViewController = LoginWithClimateButton(clientId: "dpsmj7fn2i1o3e", clientSecret: "o5chah7tqujcuoeemcs7lfftqd")
        loginViewController.delegate = self
        
        view.addSubview(loginViewController.view)
        
        loginViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[view]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["view":loginViewController.view]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loginViewController.view]))
        
        self.addChildViewController(loginViewController)
    }
    
    func didLoginWithClimate(session: Session) {
        self.seesion = session
        print("access")
        print(session.accessToken)
        print("token")
        self.accessToken = session.accessToken
        listFieldNames(session.accessToken) {
            (fieldNames: [String]) in
            dispatch_async(dispatch_get_main_queue(), {
                //self.label.text = "Welcome \(session.userInfo.firstName)\nYour fields are:\n\(fieldNames.prefix(12))"
                self.performSegueWithIdentifier("displayFields", sender: self)
            })
        }
    }
    
    func listFieldNames(accessToken: String, onComplete completion: ([String] -> Void)) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://9zfysaa1n8.execute-api.us-east-1.amazonaws.com/api/fields?includeBoundary=true")!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
                if let fields = jsonObject["fields"] as? [[String: AnyObject]] {
                    let names = fields.map() {
                        (field: [String: AnyObject]) -> String in
                        return field["name"] as! String
                    }
                    completion(names)
                } else {
                    print("ERROR: \(NSString(data:data!, encoding:NSUTF8StringEncoding))")
                }
                
            } catch let error as NSError {
                print("ERROR: deserializing JSON response: \(error.localizedDescription)")
                print("Body was: \(NSString(data: data!, encoding: NSUTF8StringEncoding))")
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! UINavigationController
        let vcMain = vc.topViewController as! FieldsTableViewController
        vcMain.session = self.seesion
    }


}

