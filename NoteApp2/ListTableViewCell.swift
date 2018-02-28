//
//  ListTableViewCell.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/27/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
