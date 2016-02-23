//
//  HomeViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Identity {
    
    class func id() -> String {
        return String(HomeViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func printReposButton(sender: UIButton) {
        Repositories.update { (success, repos) -> () in
            if success {
                for repo in repos {
                    let descript = repo.desc == kEmptyString ? "No description provided" : repo.desc
                    print("\(repo.name) by \(repo.owner.name) -> View profile at \(repo.owner.profileLink) \n DESCRIPTION: \(descript) \n \n ")
                }
            }
        }
    }
    
    @IBAction func printCurrentUser(sender: UIButton) {
        CurrentUser.update { (success, user) -> () in
            if success {
                for user in user {
                    print("");print("");
                    print(user.avatarURL)
                    print(user.email)
                    print(user.linkToRepos)
                    print(user.name)
                    print(user.profileLink)
                    print("");print("");
                }
            }
        }
    } 
}
