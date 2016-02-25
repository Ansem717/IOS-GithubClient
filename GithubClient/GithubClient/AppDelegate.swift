//
//  AppDelegate.swift
//  GithubClient
//
//  Created by Andy Malik on 2/22/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var oavc: OAuthViewController? //This is my normal naming convention. Abbriviations are much easier for me to handle. Swift is the first time I've seen unecessarily long variable names. Is it ok if I stick with my style?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        checkOAuthStatus()
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        GithubOAuth.shared.tokenRequestWithCallback(url, options: SaveOption.UserDefaults) { (success) -> () in
            if success {
                
                guard let rvc = self.window?.rootViewController as? UITabBarController else { fatalError("Root View Controller should be HomeViewController.") }
                guard let hvc = rvc.viewControllers?.first as? HomeViewController else { fatalError() }
                
                hvc.setupRepos()
                
                guard let oauthVC = self.oavc else { return }
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in

                    oauthVC.view.alpha = 0.0
                    
                    }, completion: { (finished) -> Void in
                        
                        oauthVC.view.removeFromSuperview()
                        oauthVC.removeFromParentViewController()
                })
            }
        }
        return true
    }
    
    func checkOAuthStatus() {
        do {
            try GithubOAuth.shared.accessToken()
        } catch _ { self.presentOAuthViewController() }
    }
    
    func presentOAuthViewController() {
        guard let rvc = self.window?.rootViewController as? UITabBarController else { fatalError("Root View Controller should be HomeViewController.") }
        guard let storyboard = rvc.storyboard else { fatalError("No storyboard? You fucked up.") }
        guard let oauthVC = storyboard.instantiateViewControllerWithIdentifier(OAuthViewController.id()) as? OAuthViewController else { fatalError() }
        
        rvc.addChildViewController(oauthVC)
        rvc.view.addSubview(oauthVC.view)
        oauthVC.didMoveToParentViewController(rvc)
        
        self.oavc = oauthVC
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        //
    }

    func applicationDidEnterBackground(application: UIApplication) {
        //
    }

    func applicationWillEnterForeground(application: UIApplication) {
        //
    }

    func applicationDidBecomeActive(application: UIApplication) {
        //
    }

    func applicationWillTerminate(application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("GithubClient", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

