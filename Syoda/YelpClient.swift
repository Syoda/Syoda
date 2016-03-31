//
//  YelpClient.swift
//  Syoda
//
//  Created by Harpreet Singh on 3/30/16.
//  Copyright © 2016 Syoda. All rights reserved.
//

import UIKit

import AFNetworking
import BDBOAuth1Manager
import CoreLocation

enum YelpSortMode: Int
{
    case BestMatched = 0, Distance = 1, HighestRated = 2
}

class YelpClient: BDBOAuth1RequestOperationManager
{
    var accessToken: String!
    var accessSecret: String!
    
    class var sharedInstance : YelpClient
    {
        var yelpConsumerKey = String()
        var yelpConsumerSecret = String()
        var yelpToken = String()
        var yelpTokenSecret = String()
        
        var keys: NSDictionary?
        
        if let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
        {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let keys = keys
        {
            yelpConsumerKey = keys["Root"]!["yelpConsumerKey"] as! String
            yelpConsumerSecret = keys["Root"]!["yelpConsumerSecret"] as! String
            yelpToken = keys["Root"]!["yelpToken"] as! String
            yelpTokenSecret = keys["Root"]!["yelpTokenSecret"] as! String
        }
        
        struct Static
        {
            static var token : dispatch_once_t = 0
            static var instance : YelpClient? = nil
        }
        
        dispatch_once(&Static.token)
        {
            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return Static.instance!
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!)
    {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = NSURL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    // *******Make sure radius parameter is less than 40,000 meters (25 miles).**********
    func searchWithTerm(term: String, limit: Int, offset: Int, sort: YelpSortMode?, categories: [String]?, radius: Int, deals: Bool?, completion: ([Restaurant]!, NSError!) -> Void) -> AFHTTPRequestOperation
    {
        var parameters: [String : AnyObject]
    
        // Default the location to San Francisco if user didn't allow location services, otherwise use user's location.
        let locationManager = CLLocationManager()
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        print(latitude)
        if CLLocationManager.locationServicesEnabled() && latitude != nil
        {
            parameters = ["term": term, "ll": "\(latitude!), \(longitude!)"]
        }
        else
        {
            parameters = ["term": term, "ll": "37.33,-122.03"]
        }

        if sort != nil
        {
            parameters["sort"] = sort!.rawValue
        }
        
        if categories != nil && categories!.count > 0
        {
            parameters["category_filter"] = (categories!).joinWithSeparator(",")
        }
        
        if deals != nil
        {
            parameters["deals_filter"] = deals!
        }
        
        parameters["offset"] = offset
       
        return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let dictionaries = response["businesses"] as? [NSDictionary]
            if dictionaries != nil
            {
                completion(Restaurant.restaurants(array: dictionaries!), nil)
            }
            },
                        failure:
            { (operation: AFHTTPRequestOperation?, error: NSError!) -> Void in
        })!
    }
}
