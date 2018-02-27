//
//  NoteTableViewCell.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/26/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    
    //MARK: Properties
    @IBOutlet weak var noteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
