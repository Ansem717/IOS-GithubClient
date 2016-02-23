//
//  ViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/22/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController, Identity {
    
    class func id() -> String {
        return String(OAuthViewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func authorizeButton(sender: UIButton) {
        GithubOAuth.shared.OAuthRequestWithScope("email,user,repo")
    }

}

