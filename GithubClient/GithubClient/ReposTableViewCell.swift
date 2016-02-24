//
//  ReposTableViewCell.swift
//  GithubClient
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class ReposTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desciptLabel: UILabel!
    
    var repo: Repositories! {
        didSet {
            titleLabel.text = self.repo.name
            desciptLabel.text = self.repo.desc
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
