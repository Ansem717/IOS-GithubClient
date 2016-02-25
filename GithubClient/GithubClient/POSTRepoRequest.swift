//
//  POSTRepoRequest.swift
//  GithubClient
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

class POSTRepoRequest: APIRequest {
    var httpMethod = HTTPMethod.POST
    
    let repoName: String
    init(repoName: String) {
        self.repoName = repoName
    }
    
    func url() -> String {
        return "https://api.github.com/user/repos"
    }
    
    func queryStringParam() -> [String : String]? {
        do {
            let token = try GithubOAuth.shared.accessToken()
            return ["access_token": token]
        } catch _ {}
        return nil
    }
    
    func httpBody() -> NSData? {
        return try! NSJSONSerialization.dataWithJSONObject(["name" : self.repoName], options: .PrettyPrinted)
    }
}