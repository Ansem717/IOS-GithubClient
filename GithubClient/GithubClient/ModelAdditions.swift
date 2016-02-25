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
    
    class func searchRepo(searchResult: String, completion: (success: Bool, repos: [Repositories]) -> ()) {
        API.shared.enqueue(GETSearchRequest(searchResult: searchResult)) { (success, json) -> () in
            var repos = [Repositories]()
            
//            print(json)
            
            for eachRepo in json {
                for var i = 0; i < eachRepo["items"]?.count; i++ {
                    let name = eachRepo["items"]?[i]["name"] as? String ?? kEmptyString
                    
                    //I think this is the ugliest line of code I have ever written. I have no clue how to read this json!
                    //Each time I did a guard let or if let, it said that eachRepo was an [Ambiguous reference to member 'subscript']
                    //Which would result in my if-let or guard-let checking a normal array of a string: ["items"]
                    
                    let desc = eachRepo["items"]?[i]["description"] as? String ?? kEmptyString
                    
                    let ownerName = (eachRepo["items"]?[i]["owner"]!)!["login"] as? String ?? kEmptyString
                    let ownerProfileLink = (eachRepo["items"]?[i]["owner"]!)!["html_url"] as? String ?? kEmptyString
                    let ownerRepoLink = (eachRepo["items"]?[i]["owner"]!)!["repos_url"] as? String ?? kEmptyString
                    
                    // To walk through this, this is a single "eachRepo" item, and in that has a key of "items" which is optional, and in that has an index that's in a for-loop, and in each of those has a key of "owner" which must be unwrapped, and then the whole thing must be unwrapped so now we can find the owner's Login, html url, and repos url. I just kept unwrapping until Xcode stopped yelling at me... Litterally, this was the only thing that I found which worked. I'd like to see the answer you guys used.
                    
                    let owner = Owner(name: ownerName, linkToRepos: ownerRepoLink, profileLink: ownerProfileLink)
                    
                    repos.append(Repositories(name: name, owner: owner, desc: desc))
                }
                

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

