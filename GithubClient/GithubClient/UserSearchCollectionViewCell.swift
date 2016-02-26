//
//  UserSearchCollectionViewCell.swift
//  GithubClient
//
//  Created by Andy Malik on 2/25/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class UserSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var missingImageBlock: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var owner: Owner? {
        didSet {
            self.username.text = owner?.name
            self.missingImageBlock.alpha = 1.0
            self.spinner.startAnimating()
            API.getImage((owner?.avatarURL)!) { (image) -> () in
                self.avatar.image = image
                self.missingImageBlock.alpha = 0.0
                self.spinner.stopAnimating()
            }
        }
    }
    
    
}
