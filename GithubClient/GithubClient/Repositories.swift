//
//  Repositories.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

class Repositories {
    let name: String
    let owner: Owner
    let desc: String
    let url: String
    
    init(name: String, owner: Owner, desc: String, url: String) {
        self.name = name 
        self.owner = owner
        self.desc = desc
        self.url = url
    }
}