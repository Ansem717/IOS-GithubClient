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
//                print("============================================================================================================")
                for repo in repos {
//                    print(repo.name)
                }
            }
        }
    }
}
