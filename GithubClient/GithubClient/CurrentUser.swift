//
//  CurrentUser.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

class CurrentUser {
    var name: String //NAME not LOGIN
    var linkToRepos: String
    var profileLink: String
    var avatarURL: String
    var email: String
    
    init(name: String, linkToRepos: String, profileLink: String, avatarURL: String, email: String) {
        self.name = name
        self.linkToRepos = linkToRepos
        self.profileLink = profileLink
        self.avatarURL = avatarURL
        self.email = email
    }
}