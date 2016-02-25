//
//  AddRepoViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class AddRepoViewController: UIViewController {

    @IBOutlet weak var repoName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButtonPressed(sender: UIButton) {
        API.shared.enqueue(POSTRepoRequest(repoName: repoName.text!)) { (success, json) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
