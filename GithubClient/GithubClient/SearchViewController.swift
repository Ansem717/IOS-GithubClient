//
//  SearchViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

//MARK: REMOVE
//enum SCVError: ErrorType {
//    case SearchBarFailedString
//}

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarOUTLET: UISearchBar!
    
    var bookmarks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchAPI() {
        Repositories.searchRepo(self.searchBarOUTLET.text!) { (success, repos) -> () in
            if success {
                for repo in repos {
                    print("");print("");
                    print(repo.name)
                    print(repo.desc)
                    print(repo.owner.name)
                    print(repo.owner.linkToRepos)
                    print(repo.owner.profileLink)
                    print("");print("");
                }
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText) //I didn't end up doing anything here as I feared the constant searching to the API wouldn't be optimal for user experience. Instead of improving this project in my free time, I decided to work on my Personal Project.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.searchAPI()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBarOUTLET.text = kEmptyString
    }
    
    func setupSearchBar() {
        searchBarOUTLET.placeholder = "Search"
        searchBarOUTLET.showsBookmarkButton = true
        searchBarOUTLET.showsCancelButton = true
    }
    

    
    //MARK: REMOVE
//    class func userSearchInput() throws -> String {
//        var userSearchInput: String?
//        if let returnText = SearchViewController().searchBarOUTLET.text { userSearchInput = returnText }
//        
//        guard let returnText = userSearchInput else {
//            throw SCVError.SearchBarFailedString
//        }
//        
//        return returnText
//    }
    
    
    //MARK: MasterBookmarkingFunction
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        
        //I decided to omit decent style to improve functionality, so I'm just gonna stick with UIAlertController.
        //If I cared for style, I'd have one or more of these popups / menus be in the form of an animated menu or seperate view controller.
        
        let questionAction = UIAlertController(title: "Which action?", message: nil, preferredStyle: .Alert)
        questionAction.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action) -> Void in
            self.saveBookmark()
        }))
        questionAction.addAction(UIAlertAction(title: "Load", style: .Default, handler: { (action) -> Void in
            self.loadBookmarks()
        }))
        questionAction.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
            self.deleteBookmark()
        }))
        questionAction.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(questionAction, animated: true, completion: nil)
        
    }

    
    //MARK: Bookmarking Functions
    func saveBookmark() {
        
        let saveAlert = UIAlertController(title: "Save", message: "Do you wish to save \(searchBarOUTLET.text!) ?", preferredStyle: .Alert)
        saveAlert.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action) -> Void in
            self.bookmarks.append(self.searchBarOUTLET.text!)
        }))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        self.presentViewController(saveAlert, animated: true, completion: nil)
    }
    
    func loadBookmarks() {
        let title = bookmarks.isEmpty ? "You have no bookmarks!" : "Bookmarks"
        let message = bookmarks.isEmpty ? "Please manually search for a field, and then add it as a bookmark" : "Here are the searches you've saved"
        let prefStyle = bookmarks.isEmpty ? UIAlertControllerStyle.Alert : UIAlertControllerStyle.ActionSheet
        
        let bookmarkAS = UIAlertController(title: title, message: message, preferredStyle: prefStyle)
        
        if bookmarks.isEmpty {
            bookmarkAS.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        } else {
            
            for bookmark in bookmarks {
                bookmarkAS.addAction(UIAlertAction(title: bookmark, style: .Default, handler: { (action) -> Void in
                    self.searchBarOUTLET.text = bookmark
                    //API Search with that bookmark.
                }))
            }
            bookmarkAS.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        }
        
        self.presentViewController(bookmarkAS, animated: true, completion: nil)
    }
    
    func deleteBookmark() {
        let title = bookmarks.isEmpty ? "You have no bookmarks to delete!" : "Delete Bookmarks"
        let message = bookmarks.isEmpty ? "You can't delete something that doesn't exist" : "Which would you like to delete?"
        let prefStyle = bookmarks.isEmpty ? UIAlertControllerStyle.Alert : UIAlertControllerStyle.ActionSheet
        
        let deleteAS = UIAlertController(title: title, message: message, preferredStyle: prefStyle)
        
        if bookmarks.isEmpty {
            deleteAS.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        } else {
            for bookmark in bookmarks {
                deleteAS.addAction(UIAlertAction(title: bookmark, style: .Default, handler: { (action) -> Void in
                    
                    //Confirm Action
                    let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you wish to delete \(self.searchBarOUTLET.text!) ?", preferredStyle: .Alert)
                    deleteAlert.addAction(UIAlertAction(title: "Don't delete", style: .Cancel, handler: nil))
                    deleteAlert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
                        
                        //Delete Action
                        self.bookmarks = self.bookmarks.filter({ $0 != bookmark })
                    }))
                    self.presentViewController(deleteAlert, animated: true, completion: nil)
                    
                }))
            }
            deleteAS.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        }
        
        self.presentViewController(deleteAS, animated: true, completion: nil)
    }
    
}












