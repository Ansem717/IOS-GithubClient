//
//  UserProfileViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/25/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var numOfRepos: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
    @IBOutlet weak var viewUserRepo: UIButton!
    
    var owner: Owner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUser()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUser() {
        if let o = self.owner {
            self.viewUserRepo.setTitle("", forState: .Normal) //View \(o.name)'s repos! I was coding slower than usual. Viewing this user's repositories were not listed in the homework. The functionality for clicking on repos only applies to the authenticated user's repos on the Home page.
            self.username.text = o.name
            self.numOfRepos.text = kEmptyString
            self.numOfFollowers.text = kEmptyString //I know they exist, but I didn't find them in the Search's json results.
            if let oaURL = o.avatarURL {
                API.getImage(oaURL, completion: { (image) -> () in
                    self.avatar.image = image
                })
            }
        }
    }
    
    //MARK: Button Functions
    
    @IBAction func viewUserRepoSelected(sender: UIButton) {
        
    }
    
    @IBAction func cancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
