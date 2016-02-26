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
                let repourl = eachRepo["html_url"] as? String ?? kEmptyString
                print(repourl)
                
                let ownerName = eachRepo["owner"]?["login"] as? String ?? kEmptyString
                let ownerProfileLink = eachRepo["owner"]?["html_url"] as? String ?? kEmptyString
                let ownerRepoLink = eachRepo["owner"]?["repos_url"] as? String ?? kEmptyString
                
                let owner = Owner(name: ownerName, linkToRepos: ownerRepoLink, profileLink: ownerProfileLink)
                
                repos.append(Repositories(name: name, owner: owner, desc: desc, url: repourl))
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, repos: repos) }
        }
    }
    
    class func searchRepo(searchResult: String, completion: (success: Bool, repos: [Repositories]) -> ()) {
        API.shared.enqueue(GETSearchRequestREPO(searchResult: searchResult)) { (success, json) -> () in
            var repos = [Repositories]()
            
            guard let itemsArray = json[0]["items"] else { return }
            
            for var i = 0; i < itemsArray.count; i++ {
                let name = itemsArray[i]["name"] as? String ?? kEmptyString
                let desc = itemsArray[i]["description"] as? String ?? kEmptyString
                let repourl = itemsArray[i]["html_url"] as? String ?? kEmptyString
                print(repourl)
                
                let ownerName = itemsArray[i]["owner"]??["login"] as? String ?? kEmptyString
                let ownerProfileLink = itemsArray[i]["owner"]??["html_url"] as? String ?? kEmptyString
                let ownerRepoLink = itemsArray[i]["owner"]??["repos_url"] as? String ?? kEmptyString
                
                let owner = Owner(name: ownerName, linkToRepos: ownerRepoLink, profileLink: ownerProfileLink)
                
                repos.append(Repositories(name: name, owner: owner, desc: desc, url: repourl))
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, repos: repos) }
        }
    }
}


extension CurrentUser {
    class func update(completion: (success: Bool, user: CurrentUser?) -> ()) {
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
            if let user = currUser.first {
                NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, user: user) }
            } else {
                NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: false, user: nil)
                }
                
            }
        }
    }
}

extension Owner {
    class func searchOwners(searchResult: String, completion: (success: Bool, user: [Owner]) -> ()) {
        API.shared.enqueue(GETSearchRequestUSER(searchResult: searchResult)) { (success, json) -> () in
            var users = [Owner]()
            
            guard let itemsArray = json[0]["items"] else { return }
            
            for var i = 0; i < itemsArray.count; i++ {
                let name = itemsArray[i]["login"] as? String ?? kEmptyString
                let ltr = itemsArray[i]["repos_url"] as? String ?? kEmptyString
                let pl = itemsArray[i]["html_url"] as? String ?? kEmptyString
                let aURL = itemsArray[i]["avatar_url"] as? String ?? kEmptyString
                
                users.append(Owner(name: name, linkToRepos: ltr, profileLink: pl, avatarURL: aURL))
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, user: users) }
            
        }
    }
}














