//
//  FieldsViewController.swift
//  ClimateControl
//
//  Created by Akshat Goyal on 2/20/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import UIKit

class FieldsViewController: UIViewController {

    var myAccessToken: String?
    var userid: String?
    
    @IBOutlet weak var thumbnailView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://hackillinois.climate.com/api/users/details")!)
        request.setValue("Bearer \(myAccessToken!)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
                print("sfsdg")
                print(jsonObject)
            
//                self.userid = jsonObject["id"] as! String
        
        }
        
        
        
        let request1 = NSMutableURLRequest(URL: NSURL(string: "https://hackillinois.climate.com/api/fields")!)
        request.setValue("Bearer \(myAccessToken!)", forHTTPHeaderField: "Authorization")
        
        let task1 = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if let data = data {
            let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(jsonObject)
            let fields = (jsonObject["fields"]) as! [NSDictionary]
                let field0 = fields[0] 
                let fieldID = field0["id"] as! String
                self.fetchThumbnailForField(Int(fieldID)!, accessToken: self.myAccessToken!,userId:  Int(self.userid!)!)
                
                
                
                
            } else {
                print(error)
            }
        }
        
        task.resume()
    }

    func fetchThumbnailForField(fieldId: Int, accessToken: String, userId: Int) {
        // Build url
        let components = NSURLComponents(string: "https://api.climate.com/api/thumbnail/v1/fields/\(fieldId)")
        components!.queryItems = []
        components!.queryItems?.append(NSURLQueryItem(name: "format", value: "png"))
        components!.queryItems?.append(NSURLQueryItem(name: "user-id", value: String(userId)))
        // Build request + execute
        let request = NSMutableURLRequest(URL: components!.URL!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            // check for 200 response
            let thumbnailImage = UIImage(data: data!)
            self.thumbnailView.image = thumbnailImage
            // do something to the data -> set in UIImageView?
        }
        task.resume()
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
