//
//  User.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

class Owner {
    var name: String
    var linkToRepos: String
    var profileLink: String
    var avatarURL: String?
    
    init(name: String, linkToRepos: String, profileLink: String, avatarURL: String? = kEmptyString) {
        self.name = name
        self.linkToRepos = linkToRepos
        self.profileLink = profileLink
        self.avatarURL = avatarURL
    }
}