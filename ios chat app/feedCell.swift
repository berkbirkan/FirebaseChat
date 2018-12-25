//
//  feedCell.swift
//  ios chat app
//
//  Created by berk birkan on 5.10.2017.
//  Copyright © 2017 berk birkan. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var groupimage: UIImageView!
    @IBOutlet weak var groupname: UILabel!
    @IBOutlet weak var createdby: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
