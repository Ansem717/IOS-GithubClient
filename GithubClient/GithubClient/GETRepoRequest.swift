//
//  GETRepoRequest.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

class GETRepoRequest: APIRequest {
    var httpMethod = HTTPMethod.GET
    var headerContentType = MIMEType.ApplicationJSON
    
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
}