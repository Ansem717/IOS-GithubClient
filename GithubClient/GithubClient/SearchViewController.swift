//
//  SearchViewController.swift
//  GithubClient
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarOUTLET: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var bookmarks = [String]()
    
    var repodata = [Repositories]() {
        didSet {
            self.searchTableView.reloadData()
        }
    }
    
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
        if searchBarOUTLET.text == kEmptyString { return }
        Repositories.searchRepo(self.searchBarOUTLET.text!) { (success, repos) -> () in
            if success {
                self.repodata = repos
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        searchAPI()
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
                    self.searchAPI()
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

extension SearchViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repodata.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseRepoCell = self.searchTableView.dequeueReusableCellWithIdentifier("searchTableViewCell", forIndexPath: indexPath)
        reuseRepoCell.textLabel?.text = self.repodata[indexPath.row].name
        reuseRepoCell.detailTextLabel?.text = self.repodata[indexPath.row].desc
        
        return reuseRepoCell
    }
    
}






