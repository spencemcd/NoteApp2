//
//  List.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/27/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit
import os.log

class List: NSObject, NSCoding {
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("lists")
    
    //MARK: Properties
    
    var list_name: String
    var list: [Note]
    
    //MARK: Types
    
    struct PropertyKey {
        static let list_name = "list_name"
        static let list = "list"
    }
    
    //MARK: Initialization
    init?(list_name: String, list: [Note]) {
        
        guard !list_name.isEmpty else {
            return nil
        }
        
        self.list_name = list_name
        self.list = list
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(list_name, forKey: PropertyKey.list_name)
        aCoder.encode(list, forKey: PropertyKey.list)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let list_name = aDecoder.decodeObject(forKey: PropertyKey.list_name) as? String
        let list = aDecoder.decodeObject(forKey: PropertyKey.list) as? [Note]
        
        self.init(list_name: list_name!, list: list!)
        
    }
    
    
}
