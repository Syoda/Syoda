//
//  RestaurantDetailViewController.swift
//  Syoda
//
//  Created by Philippe Kimura-Thollander on 5/5/16.
//  Copyright © 2016 Syoda. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = restaurant!.name
        distanceLabel.text = restaurant!.distance
        reviewsLabel.text =  restaurant!.reviewCount!.stringValue + " reviews"
        addressLabel.text = restaurant?.address
        numberLabel.text = restaurant?.phoneNumber
        snippetLabel.text = restaurant!.snippet_text
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
