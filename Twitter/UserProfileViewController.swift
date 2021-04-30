//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Vivian Ross on 4/30/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadProfile()
        self.view.setNeedsDisplay()

        // Do any additional setup after loading the view.
    }
    
    @objc func loadProfile(){
        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
        let myParams = NSDictionary()
        TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: myParams as! [String : Any], success: { (profile: NSDictionary) in
            let imageUrl = URL(string: (profile["profile_image_url"] as? String)!)
            let data = try? Data(contentsOf: imageUrl!)
            if let imageData = data {
                self.profilePicture.image = UIImage(data: imageData)
            }
            
            self.nameLabel.text = profile["name"] as! String
            self.userNameLabel.text = String(format: "@%@", profile["screen_name"] as! String)
            self.taglineLabel.text = profile["description"] as! String
            self.followersLabel.text = String(format: "Followers: %@", profile["followers_count"] as! CVarArg)
            self.followingLabel.text = String(format: "Following: %@", profile["friends_count"] as! CVarArg)
            self.tweetsLabel.text = String(format: "Tweets: %@", profile["statuses_count"] as! CVarArg)
        }, failure: { (error) in
            print("Unable to load profile \(error)")
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
