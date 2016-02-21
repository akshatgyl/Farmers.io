//
//  FieldsViewController.swift
//  ClimateControl
//
//  Created by Akshat Goyal on 2/20/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import UIKit
import LoginWithClimate
import MapKit

class FieldsViewController: UIViewController, CLLocationManagerDelegate {

    
    let locationManager = CLLocationManager()
    var session: Session?
    var image: UIImage?
    var fields: NSArray?
    
    @IBOutlet weak var thumbnailView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any aditional setup after loading the view.
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://hackillinois.climate.com/api/fields")!)
        request.setValue("Bearer \((session?.accessToken)!)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if let data = data {
            let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(jsonObject)
            self.fields = (jsonObject["fields"]) as? NSArray
                let field0 = self.fields![3]
                let fieldID = field0["id"] as! String
                
                let fieldCenter = field0["centroid"] as! NSDictionary
                let area = field0["area"] as! NSDictionary
                let areaq = area["q"] as! Double
                let coordinates = fieldCenter["coordinates"] as! NSArray
                let longi = coordinates[0] as! Double
                let lati = coordinates[1] as! Double
                print(areaq)
                print(longi)
                print(lati)
                
                self.fetchThumbnailForField(Int(fieldID)!, accessToken: (self.session?.accessToken!)!,userId: (self.session?.userInfo.id)!)
                
            } else {
                print(error)
            }
        }
        
        print(self.fields)
        task.resume()
        
        

    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    func fetchThumbnailForField(fieldId: Int, accessToken: String, userId: Int) {
        // Build url
        let components = NSURLComponents(string: "https://hackillinois.climate.com/api/fields")
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
        
        
        let request1 = NSMutableURLRequest(URL: NSURL(string: "ttps://api.climate.com/api/thumbnail/v1/fields/\(fieldId)")!)
        request.setValue("Bearer \(session?.accessToken)", forHTTPHeaderField: "Authorization")
        
        let task1 = NSURLSession.sharedSession().dataTaskWithRequest(request1) {
            (data, response, error) in
            let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
            let clus = jsonObject["features"] as! [[String: AnyObject]]
            // Do something with clus
            print("clus")
            print(clus)
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
