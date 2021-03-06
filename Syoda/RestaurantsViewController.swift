//
//  RestaurantsViewController.swift
//  Syoda
//
//  Created by Harpreet Singh on 3/30/16.
//  Copyright © 2016 Syoda. All rights reserved.
//

import UIKit
import SVPullToRefresh
import SVProgressHUD
import MapKit
import CoreLocation
import Koloda

class RestaurantsViewController: UIViewController, CLLocationManagerDelegate, KolodaViewDelegate, KolodaViewDataSource
{
    let LIMIT_CONSTANT = 20

    var restaurants: [Restaurant]!
    var locationManager : CLLocationManager!
    var categories: [String]!
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.kolodaView.dataSource = self
        self.kolodaView.delegate = self
        searchRestaurants("Restaurant", offset: 0, sort: YelpSortMode.BestMatched, categories: categories, radius: 20000, deals: false)
        setLocationManager()
       
    }
    
    // Search for Businesses
    func searchRestaurants(term: String?, offset: Int, sort: YelpSortMode, categories: [String]?, radius: Int, deals: Bool?)
    {
        Restaurant.searchWithTerm(term!, limit: LIMIT_CONSTANT, offset: offset, sort: sort, categories: categories, radius: radius, deals: deals, completion: { (restaurants: [Restaurant]!, error: NSError!) -> Void in
            
            self.restaurants = restaurants
            self.kolodaView.reloadData()
        })
    }
    
    // Set location manager
    func setLocationManager()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Add location manager methods
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        if let restaurants = restaurants
        {
            return UInt(restaurants.count)
        }
        else
        {
            return 0
        }
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        addChildViewController(vc)

        let restaurant = restaurants[Int(index)]
        
        vc.restaurant = restaurant
        
        self.didMoveToParentViewController(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        vc.view.layer.shadowOpacity = 0.7
        vc.view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        vc.view.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        vc.view.layer.shadowRadius = 5.0

        return vc.view
    }
    
    @IBAction func onEw(sender: AnyObject) {
        kolodaView.swipe(SwipeResultDirection.Left)
    }
    
    @IBAction func onYum(sender: AnyObject) {
        kolodaView.swipe(SwipeResultDirection.Right)
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
