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

class RestaurantsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate
{
    let LIMIT_CONSTANT = 20

    var restaurants: [Restaurant]!
    var locationManager : CLLocationManager!
    var categories: [String]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        searchRestaurants("Restaurant", offset: 0, sort: YelpSortMode.BestMatched, categories: categories, radius: 20000, deals: false)
        setLocationManager()
    }
    
    // Search for Businesses
    func searchRestaurants(term: String?, offset: Int, sort: YelpSortMode, categories: [String]?, radius: Int, deals: Bool?)
    {
        Restaurant.searchWithTerm(term!, limit: LIMIT_CONSTANT, offset: offset, sort: sort, categories: categories, radius: radius, deals: deals, completion: { (restaurants: [Restaurant]!, error: NSError!) -> Void in
            
            self.restaurants = restaurants
            self.collectionView.reloadData()
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
    
    // Add lcoation manager methods
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let restaurants = restaurants
        {
            return restaurants.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RestaurantCell", forIndexPath: indexPath) as! RestaurantCell
        cell.restaurant = restaurants[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
