//
//  CardViewController.swift
//  Syoda
//
//  Created by Philippe Kimura-Thollander on 4/26/16.
//  Copyright © 2016 Syoda. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var restaurant: Restaurant?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
        restaurantLabel.text = restaurant!.name
        distanceLabel.text = restaurant!.distance
        reviewsLabel.text =  restaurant!.reviewCount!.stringValue + " reviews"
        descriptionLabel.text = restaurant!.snippet_text
        genreLabel.text = restaurant!.categories
        if let restaurantImageURL = restaurant!.imageURL
        {
            restaurantImageView.setImageWithURL(restaurantImageURL)
        }
        
        if let ratingImageURL = restaurant!.ratingImageURL
        {
            ratingImageView.setImageWithURL(ratingImageURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCall(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(restaurant!.phoneNumber)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func onDirections(sender: AnyObject) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(restaurant!.address!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let clPlacemark = placemarks?.first {
                let addressDict = clPlacemark.addressDictionary as? [String: AnyObject]
                let coordinate = clPlacemark.location!.coordinate
                let mkPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
                let mapItem = MKMapItem(placemark: mkPlacemark)
                let options = ["MKLaunchOptionsDirectionsModeKey":
                    "MKLaunchOptionsDirectionsModeDriving",
                    "MKLaunchOptionsShowsTrafficKey": true]
                mapItem.openInMapsWithLaunchOptions(options)
            }
        })

        
    }
    
    @IBAction func onReadMore(sender: AnyObject) {
        performSegueWithIdentifier("info", sender: sender)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "info" {
            let vc = segue.destinationViewController as! RestaurantDetailViewController
            vc.restaurant = self.restaurant
        }
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
