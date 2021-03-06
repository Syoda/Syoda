//
//  Restaurant.swift
//  Syoda
//
//  Created by Harpreet Singh on 3/30/16.
//  Copyright © 2016 Syoda. All rights reserved.
//

import UIKit
import CoreLocation

class Restaurant: NSObject
{
    let id: String?
    let name: String?
    let address: String?
    let imageURL: NSURL?
    let categories: String?
    let distance: String?
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    let location: CLLocation?
    let websiteUrl: String?
    let phoneNumber: String?
    let snippet_text: String?
    let menu: String?
    
    init(dictionary: NSDictionary)
    {
        id = dictionary["id"] as? String
        
        name = dictionary["name"] as? String
        //print(dictionary)
        let imageURLString = dictionary["image_url"] as? String
    
        if imageURLString != nil
        {
            imageURL = NSURL(string: (imageURLString?.stringByReplacingOccurrencesOfString("ms.jpg", withString: "l.jpg"))!)!
        }
        else
        {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil
        {
            let addressArray = location!["display_address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0
            {
                address = "\(addressArray![0] as! String) \(addressArray![1] as! String)"
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0
            {
                if !address.isEmpty
                {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil
        {
            var categoryNames = [String]()
            for category in categoriesArray!
            {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joinWithSeparator(", ")
        }
        else
        {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil
        {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        }
        else
        {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil
        {
            ratingImageURL = NSURL(string: ratingImageURLString!)
        }
        else
        {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
        
        if let coordinate = location!["coordinate"] as? NSDictionary
        {
            let latitude = coordinate["latitude"] as? Double
            let longitude = coordinate["longitude"] as? Double
            self.location = CLLocation(latitude: latitude!, longitude: longitude!)
        }
        else
        {
            self.location = CLLocation(latitude: 37.785771, longitude: -122.406165)
        }
        
        if let url = dictionary["url"] as? String
        {
            websiteUrl = url
        }
        else
        {
            websiteUrl = nil
        }
        
        let snippet = dictionary["snippet_text"] as? String
        if snippet != nil
        {
            snippet_text = snippet
        }
        else
        {
            snippet_text = nil
        }
        
        let phone = dictionary["phone"] as? String
        if phone != nil
        {
            phoneNumber = phone
        }
        else
        {
            phoneNumber = nil
        }
        
        let menu_p = dictionary["menu_provider"] as? String
        if menu_p != nil
        {
            menu = menu_p
        }
        else
        {
            menu = nil
        }

    }
    
    class func restaurants(array array: [NSDictionary]) -> [Restaurant]
    {
        var businesses = [Restaurant]()
        for dictionary in array
        {
            let business = Restaurant(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, limit: Int, offset: Int, sort: YelpSortMode?, categories: [String]?, radius: Int, deals: Bool?, completion: ([Restaurant]!, NSError!) -> Void) -> Void
    {
        YelpClient.sharedInstance.searchWithTerm(term, limit: limit, offset: offset, sort: sort, categories: categories, radius: radius, deals: deals, completion: completion)
    }
}
