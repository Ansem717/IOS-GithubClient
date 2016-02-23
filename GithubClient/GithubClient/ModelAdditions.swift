//
//  ModelAdditions.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

extension Repositories {
    class func update(completion: (success: Bool, repos: [Repositories]) -> ()) {
        API.shared.enqueue(GETRepoRequest()) { (success, json) -> () in
            var repos = [Repositories]()
            
            for eachRepo in json {
                let name = eachRepo["name"] as? String ?? kEmptyString
                repos.append(Repositories(name: name))
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, repos: repos) }
        }
    }
}