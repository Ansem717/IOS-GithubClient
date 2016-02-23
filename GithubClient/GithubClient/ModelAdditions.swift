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
                let desc = eachRepo["description"] as? String ?? kEmptyString
                
                let ownerName = eachRepo["owner"]?["login"] as? String ?? kEmptyString
                let ownerProfileLink = eachRepo["owner"]?["html_url"] as? String ?? kEmptyString
                let ownerRepoLink = eachRepo["owner"]?["repos_url"] as? String ?? kEmptyString
                let owner = Owner(name: ownerName, linkToRepos: ownerRepoLink, profileLink: ownerProfileLink)
                repos.append(Repositories(name: name, owner: owner, desc: desc))
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, repos: repos) }
        }
    }
}

extension CurrentUser {
    class func update(completion: (success: Bool, user: [CurrentUser]) -> ()) {
        API.shared.enqueue(GETCurrentUserRequest()) { (success, json) -> () in
            var currUser = [CurrentUser]()
            
            for user in json {
                let realName = user["name"] as? String ?? user["login"] as? String // If name is not provided, default to the login name.
                let userProfileLink = user["html_url"] as? String ?? kEmptyString
                let linkToRepos = user["repos_url"] as? String ?? kEmptyString
                let avatarURL = user["avatar_url"] as? String ?? kEmptyString
                let email = user["email"] as? String ?? kEmptyString
                currUser.append(CurrentUser(name: realName!, linkToRepos: linkToRepos, profileLink: userProfileLink, avatarURL: avatarURL, email: email))
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, user: currUser) }
            
        }
    }
}