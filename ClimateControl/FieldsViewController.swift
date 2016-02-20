//
//  FieldsViewController.swift
//  ClimateControl
//
//  Created by Akshat Goyal on 2/20/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import UIKit
import LoginWithClimate

class FieldsViewController: UIViewController {

    var session: Session?
    var image: UIImage?
    
    @IBOutlet weak var thumbnailView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://hackillinois.climate.com/api/fields")!)
        request.setValue("Bearer \((session?.accessToken)!)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if let data = data {
            let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(jsonObject)
            let fields = (jsonObject["fields"]) as! [NSDictionary]
                let field0 = fields[0] 
                let fieldID = field0["id"] as! String
                self.fetchThumbnailForField(Int(fieldID)!, accessToken: (self.session?.accessToken!)!,userId: (self.session?.userInfo.id)!)
                
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
            dispatch_async(dispatch_get_main_queue(),{
                
                self.thumbnailView.image = thumbnailImage
                
            })
            
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
