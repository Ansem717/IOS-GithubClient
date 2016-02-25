//
//  GithubOAuth.swift
//  GithubClient
//
//  Created by Andy Malik on 2/22/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

let kAccessTokenKey = "kAccessTokenKey"
let kOAuthBaseURLString = "https://github.com/login/oauth"
let kAccessTokenRegexPattern = "access_token=([^&]+)"
let kEmptyString = ""

typealias GithubOAuthCompletion = (success: Bool) -> ()

enum SaveOption {
    case Keychain
    case UserDefaults
}

enum GithubOauthError: ErrorType {
    case MissingAccessToken(String)
    case ResponseFromGithub(String)
}

class GithubOAuth {
    
    private var githubClientID = "64d45fce7a1a1635b6b8"
    private var githubClientSecret = "87363d9f6fcd04bf9c10c3458067647c31f0067a"
    
    static let shared = GithubOAuth()
    private init() {}
    
    func OAuthRequestWithScope(scope: String) {
        do {
            try GithubOAuth.shared.accessToken()
            print("You are already logged into GitHub!")
        } catch _ {
            guard let requestURL = NSURL(string: "\(kOAuthBaseURLString)/authorize?client_id=\(self.githubClientID)&scope=\(scope)") else {
                fatalError("Line 38 - GithubOAuth.swift - Error creatuing URL within \(__FUNCTION__)")
            }
            UIApplication.sharedApplication().openURL(requestURL)
        }
    }
    
    func tokenRequestWithCallback(url: NSURL, options: SaveOption, completion: GithubOAuthCompletion) {
        guard let codeString = url.query else { return }
        guard let requestURL = NSURL(string: "\(kOAuthBaseURLString)/access_token?client_id=\(self.githubClientID)&client_secret=\(self.githubClientSecret)&\(codeString)") else { return }
        
        let request = self.requestWith(requestURL, method: "POST")
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if let error = error { print("ERROR - GithubOAuth.swift [line:50] - \(error)"); return }
            
            if let data = data {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject], token = self.accessTokenFrom(json) {
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            switch options {
                            case .Keychain: self.saveAccessTokenToKeychain(token)
                            case .UserDefaults: self.saveAccessTokenToUserDefault(token)
                            }
                        })
                    }
                    self.mainQCallback(completion: completion)
                } catch _ { self.mainQCallback(false, completion: completion) }
            } else { self.mainQCallback(false, completion: completion) }
        }.resume()
    }
    
    func mainQCallback(success: Bool = true, completion: GithubOAuthCompletion)
    {
        NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: success) }
    }
    
    
    func accessToken() throws -> String {
        var accessToken: String?
//        if let token = self.accessTokenFromKeychain() { accessToken = token }
        if let token = self.accessTokenFromUserDefaults() { accessToken = token }
        
        guard let token = accessToken else {
            throw GithubOauthError.MissingAccessToken("You don't have an access token saved")
        }
        
        return token
    }
    
    private func requestWith(url: NSURL, method: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    private func accessTokenFrom(json: [String: AnyObject]) -> String? {
        guard let token = json["access_token"] as? String else { return nil }
        return token
    }
    
    private func saveAccessTokenToUserDefault(token: String) -> Bool {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: kAccessTokenKey)
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    private func accessTokenFromUserDefaults() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(kAccessTokenKey)
    }
    
    private func saveAccessTokenToKeychain(token: String) -> Bool {
        var keychainQuery = self.getKeychainQuery(kAccessTokenKey)
        keychainQuery[(kSecValueData as String)] = NSKeyedArchiver.archivedDataWithRootObject(token)
        SecItemDelete(keychainQuery)
        SecItemAdd(keychainQuery, nil)
        return true
    }
    
    private func accessTokenFromKeychain() -> String? {
        var keychainQuery = self.getKeychainQuery(kAccessTokenKey)
        keychainQuery[(kSecReturnData as String)] = kCFBooleanTrue
        keychainQuery[(kSecMatchLimit as String)] = kSecMatchLimitOne
        var dataRef: AnyObject?
        
        if SecItemCopyMatching(keychainQuery, &dataRef) == noErr {
            if let data = dataRef as? NSData {
                if let token = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? String {
                    return token
                }
            }
        }
        return kEmptyString
    }
    
    
    private func getKeychainQuery(query: String) -> [String : AnyObject] {
        return [(kSecClass as String) : kSecClassGenericPassword,
            (kSecAttrService as String) : query,
            (kSecAttrAccount as String) : query,
            (kSecAttrAccessible as String) : kSecAttrAccessibleAfterFirstUnlock]
    }
}































