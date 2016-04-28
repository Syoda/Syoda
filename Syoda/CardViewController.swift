//
//  CardViewController.swift
//  Syoda
//
//  Created by Philippe Kimura-Thollander on 4/26/16.
//  Copyright © 2016 Syoda. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var restaurantName: String?
    var restaurantImageURL: String?
    var restaurantDistance: String?
    var restaurantReviews: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantLabel.text = restaurantName
        distanceLabel.text = restaurantDistance
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
