//
//  RestaurantCell.swift
//  Syoda
//
//  Created by Harpreet Singh on 3/30/16.
//  Copyright © 2016 Syoda. All rights reserved.
//

import UIKit

class RestaurantCell: UICollectionViewCell
{
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var websiteLinkLabel: UILabel!
    
    var restaurant: Restaurant!
    {
        didSet
        {
            if let imageURL = restaurant.imageURL
            {
                restaurantImageView.setImageWithURL(imageURL)
            }
            ratingImageView.setImageWithURL(restaurant.ratingImageURL!)
            restaurantNameLabel.text = restaurant.name
            distanceLabel.text = restaurant.distance
            reviewCountLabel.text = "\(restaurant.reviewCount!) Reviews"
            categoriesLabel.text = restaurant.categories
            addressLabel.text = restaurant.address
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        restaurantImageView.layer.cornerRadius = 5
        restaurantImageView.clipsToBounds = true
    }
    @IBAction func onLinkClicked(sender: AnyObject)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: restaurant.websiteUrl!)!)
    }
}
