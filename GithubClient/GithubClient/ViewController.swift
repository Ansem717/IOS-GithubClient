//
//  ViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/22/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func authorizeButton(sender: UIButton) {
        GithubOAuth.shared.OAuthRequestWithScope("email,user,repo")
    }

    @IBAction func printTokenButton(sender: UIButton) {
        do {
            let token = try GithubOAuth.shared.accessToken()
            print(token)
        } catch _ {}
    }
}

