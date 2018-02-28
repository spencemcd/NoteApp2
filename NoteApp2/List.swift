//
//  List.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/27/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit

class List {
    
    //MARK: Properties
    
    var list_name: String
    var list: [Note]
    
    //MARK: Initialization
    init?(list_name: String, list: [Note]) {
        
        guard !list_name.isEmpty else {
            return nil
        }
        
        self.list_name = list_name
        self.list = list
    }
    
    
}
