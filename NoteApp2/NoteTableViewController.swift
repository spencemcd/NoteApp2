//
//  NoteTableViewController.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/26/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit
import os.log

protocol NoteTableViewControllerDelegate {
    func setNewNotesValue(new_notes: [Note], index: Int)
}

class NoteTableViewController: UITableViewController {

    
    //MARK: Properties
    var notes = [Note]()
    
    var index: Int?
    var delegate: NoteTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.leftBarButtonItem = editButtonItem
        //load sample data
        //loadSampleNotes()
        /*if let savedNotes = loadNotes() {
            notes += savedNotes
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NoteTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("The dequeued cell is not an instance of NoteTableViewCell")
        }
        
        let note = notes[indexPath.row]
        
        cell.noteLabel.text = note.note_name
        cell.costLabel.text = note.note_cost

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        /*if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            saveNotes()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }   */
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "addItem":
                os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            case "showDetail":
                guard let noteDetailViewController = segue.destination as? NoteViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
                guard let selectedNoteCell = sender as? NoteTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedNoteCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
            
                let selectedNote = notes[indexPath.row]
                noteDetailViewController.note = selectedNote
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            
        }
        
    }
 
    
    //MARK: Actions
    //If saved button is pressed then send notes back to ListTableViewController
    @IBAction func btnSaveAndPassDataPressed(_ sender: Any) {
        delegate?.setNewNotesValue(new_notes: notes, index: index!)
    }
    
    @IBAction func unwindToNoteList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NoteViewController, let note = sourceViewController.note {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                notes[selectedIndexPath.row] = note
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                
                //Add a new note
                let newIndexPath = IndexPath(row: notes.count, section: 0)
            
                notes.append(note)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //saveNotes()
        }
        
    }
    //MARK: Private Methods
    
    /*private func saveNotes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(notes, toFile: Note.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Notes successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save notes...", log: OSLog.default, type: .error)
        }
    }*/
    
    
    /*private func loadSampleNotes(){
        guard let note1 = Note(note_name: "Costco") else {
            fatalError("Unable to instantiate note1")
        }
        
        guard let note2 = Note(note_name: "Ralphs") else {
             fatalError("Unable to instantiate note2")
        }
        notes += [note1, note2]
        
    }*/
    
    /*private func loadNotes() -> [Note]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Note.ArchiveURL.path) as? [Note]
    }*/

}
