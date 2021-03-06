//
//  Note.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/26/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit
import os.log

class Note: NSObject, NSCoding {
    
    //MARK: Properties
    var note_name: String
    var note_cost: String
    //var note_cost: Double
    
    //MARK: Archiving Paths
    //static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes")
    
    //MARK: Types
    struct PropertyKey {
        static let note_name = "note_name"
        static let note_cost = "note_cost"
    }
    
    //MARK: Initialization
    init?(note_name: String, note_cost: String){
        
        guard !note_name.isEmpty else {
            return nil
        }
        
        self.note_name = note_name
        self.note_cost = note_cost
    }
    
    //MARK: NSCoding
   func encode(with aCoder: NSCoder) {
        aCoder.encode(note_name, forKey: PropertyKey.note_name)
        aCoder.encode(note_cost, forKey: PropertyKey.note_cost)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let note_name = aDecoder.decodeObject(forKey: PropertyKey.note_name) as? String else {
            os_log("Unable to decode the name for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let note_cost = aDecoder.decodeObject(forKey: PropertyKey.note_cost) as? String else {
            os_log("Unable to decode the name for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        //Call designated initializer
        self.init(note_name: note_name, note_cost: note_cost)
        
    }
    
}
