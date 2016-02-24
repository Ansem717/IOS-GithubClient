//
//  HomeViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Identity {
    
    @IBOutlet weak var repoTableview: UITableView!
    
    var repodata = [Repositories]() {
        didSet {
            self.repoTableview.reloadData()
        }
    }
    
    class func id() -> String {
        return String(HomeViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupRepos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupRepos() {
        Repositories.update { (success, repos) -> () in
            if success {
                self.repodata = repos
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

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repodata.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseRepoCell = self.repoTableview.dequeueReusableCellWithIdentifier("yourRepoCell", forIndexPath: indexPath) as! ReposTableViewCell
        reuseRepoCell.repo = self.repodata[indexPath.row]
        
        return reuseRepoCell
    }
    
}





















