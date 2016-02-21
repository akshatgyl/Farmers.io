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
import BMCustomTableView
import RandomColorSwift
import WatchConnectivity

class FieldsTableViewController: UIViewController, WCSessionDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    let locationManager = CLLocationManager()
    var session: Session?
    var image: UIImage?
    var fields: NSArray?

    
    //@IBOutlet weak var customTableView: BMCustomTableView!
    
    @IBOutlet weak var customTableView: BMCustomTableView!
    
    var colors: [UIColor]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            WCSession.defaultSession().delegate = self
            WCSession.defaultSession().activateSession()
        }
        
        // Do any aditional setup after loading the view.
        
        customTableView.dataSource = self
        customTableView.delegate = self
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        colors = randomColorsCount(20, hue: .Random, luminosity: .Light)
        
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
            let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print("jason: \(jsonObject)")
            self.fields = (jsonObject["fields"]) as? NSArray
                // Do something with fields
                print(self.fields)
                print("SHANA4: \(self.fields?.count)")
            dispatch_async(dispatch_get_main_queue(),{
                self.customTableView.reloadData()
            })
            
            
        }
        
        task.resume()
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    //    func fetchThumbnailForField(fieldId: Int, accessToken: String, userId: Int) {
    //        // Build url
    //        let components = NSURLComponents(string: "https://api.climate.com/api/thumbnail/v1/fields/\(fieldId)")
    //        components!.queryItems = []
    //        components!.queryItems?.append(NSURLQueryItem(name: "format", value: "png"))
    //        components!.queryItems?.append(NSURLQueryItem(name: "user-id", value: String(userId)))
    //        // Build request + execute
    //        let request = NSMutableURLRequest(URL: components!.URL!)
    //        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    //        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
    //            (data, response, error) -> Void in
    //            // check for 200 response
    //            let thumbnailImage = UIImage(data: data!)
    //            // do something to the data -> set in UIImageView?
    //
    //             dispatch_async(dispatch_get_main_queue(),{
    //                    self.thumbnailView.image = thumbnailImage
    //            })
    //
    //        }
    //        task.resume()
    //    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("fieldCell", forIndexPath: indexPath) as! FieldsCell
        
                let field0 = self.fields![indexPath.row]
        print("SHANA field: \(field0)")
                let fieldName = field0["name"] as! String
                cell.fieldNameLabel.text = fieldName
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
                        cell.thumbNailView.image = thumbnailImage
                        
                        let image = thumbnailImage
                        
                        let data = UIImageJPEGRepresentation(image, 1.0)
                        
                        WCSession.defaultSession().sendMessageData(data!, replyHandler: { (data) -> Void in
                            // handle the response from the device
                            
                            }) { (error) -> Void in
                                print("error: \(error.localizedDescription)")
                                
                        }

                    })
                    
                }
                task.resume()
        
        print(self.fields)
        cell.roundedView.backgroundColor = colors[indexPath.row]
        return cell
        
    }
    
    
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let fields = fields {
//            print("SHANA2")
//            return fields.count
//        
//        } else {
//            print("SHANA3")
//            return 0
//        }
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let fields = fields {
                print("SHANA2")
                return fields.count
    
            } else {
                print("SHANA3")
                return 0
            }
        
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        customTableView.customizeCell(cell)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "displayDetails") {
            if let cell = sender as? UITableViewCell {
                let row = customTableView.indexPathForCell(cell)!.row
                let vc = segue.destinationViewController as! DetailViewController
                vc.field = self.fields![row] as? NSDictionary
                vc.session = self.session
            }
        } else if segue.identifier == "displayGeo" {
            
        } else if segue.identifier == "displayUser" {
        
            let vc = segue.destinationViewController as! UserInfoViewController
            vc.session = self.session
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        self.performSegueWithIdentifier("displayDetails", sender: currentCell)
    }
    
    @IBAction func onUser(sender: AnyObject) {
        performSegueWithIdentifier("displayUser", sender: self)
        
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
