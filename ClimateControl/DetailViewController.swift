//
//  DetailViewController.swift
//  ClimateControl
//
//  Created by Aditya Dhingra on 2/21/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import UIKit
import MapKit
import LoginWithClimate

class DetailViewController: UIViewController {
    var field: NSDictionary?
    
    @IBOutlet weak var fieldName: UILabel!
    
    @IBOutlet weak var fieldImageView: UIImageView!
    
    
    @IBOutlet weak var roundedPopUpView: UIView!
    
    var session: Session?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func closebtn(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundedPopUpView.layer.cornerRadius = 10
        self.roundedPopUpView.clipsToBounds = true
        let field0 = field
        print("SHANA field: \(field0)")
        fieldName.text = field0!["name"] as? String
        //cell.fieldNameLabel.text = fieldName
        let fieldID = field0!["id"] as! String
        
        let fieldCenter = field0!["centroid"] as! NSDictionary
        let area = field0!["area"] as! NSDictionary
        let areaq = area["q"] as! Double
        let coordinates = fieldCenter["coordinates"] as! NSArray
        let longi = coordinates[0] as! Double
        let lati = coordinates[1] as! Double
        print(areaq)
        print(longi)
        print(lati)
        
        //                self.fetchThumbnailForField(Int(fieldID)!, accessToken: (self.session?.accessToken!)!,userId: (self.session?.userInfo.id)!)
        
        let components = NSURLComponents(string: "https://api.climate.com/api/thumbnail/v1/fields/\(fieldID)")
        components!.queryItems = []
        components!.queryItems?.append(NSURLQueryItem(name: "format", value: "png"))
        components!.queryItems?.append(NSURLQueryItem(name: "user-id", value: String((self.session?.userInfo.id)!)))
        // Build request + execute
        let request = NSMutableURLRequest(URL: components!.URL!)
        request.setValue("Bearer \((self.session?.accessToken)!)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            // check for 200 response
            let thumbnailImage = UIImage(data: ((data)!))!
            // do something to the data -> set in UIImageView?
            print(data)
            dispatch_async(dispatch_get_main_queue(),{
                self.fieldImageView.image = thumbnailImage
                
//                let image = thumbnailImage
                
//                let data = UIImageJPEGRepresentation(image, 1.0)
//                
//                WCSession.defaultSession().sendMessageData(data!, replyHandler: { (data) -> Void in
//                    // handle the response from the device
//                    
//                    }) { (error) -> Void in
//                        print("error: \(error.localizedDescription)")
//                        
//                }
                
            })
            
        }
        task.resume()
    }
}
