//
//  HomeViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: UIViewController, Identity {
    
    @IBOutlet weak var repoTableview: UITableView!
    @IBOutlet weak var backToHomeButton: UIButton!
    
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
        self.backToHomeButton.setTitle("", forState: .Normal)
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
    
    
    @IBAction func backToHomeButtonPressed(sender: UIButton) {
        if backToHomeButton.titleLabel?.text == "" { return }
        guard let webviewthing = self.view.viewWithTag(717) else { return }
        webviewthing.removeFromSuperview()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repodata.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseRepoCell = self.repoTableview.dequeueReusableCellWithIdentifier("yourRepoCell", forIndexPath: indexPath) as! ReposTableViewCell
        reuseRepoCell.repo = self.repodata[indexPath.row]
        
        return reuseRepoCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let curCell = self.repodata[indexPath.row]
        
        guard let url = NSURL(string: curCell.url) else { return }
        let request = NSURLRequest(URL: url)
        let webView = WKWebView(frame: self.view.frame)
        webView.tag = 717
        self.backToHomeButton.setTitle("Back", forState: .Normal)
        
        self.view.addSubview(webView)
        webView.loadRequest(request)
    }
    
}





















