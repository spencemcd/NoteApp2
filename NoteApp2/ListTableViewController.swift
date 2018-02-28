//
//  ListTableViewController.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/27/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit
import os.log

class ListTableViewController: UITableViewController, NoteTableViewControllerDelegate {
    func setNewNotesValue(new_notes: [Note], index: Int) {
        lists[index].list = new_notes
        saveLists()
    }
    
    

    
    //MARK: Properties
    
    var lists = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load sample list
        //loadSampleLists()
        
        if let savedLists = loadLists() {
            lists += savedLists
        }
        
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
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell")
        }

        let list = lists[indexPath.row]
        
        cell.nameLabel.text = list.list_name

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
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    */
        if editingStyle == .delete {
            lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
        
        saveLists()
        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Set delegate to receive notes back
        if let destination = segue.destination as? NoteTableViewController {
            destination.delegate = self
        }
        
        if let NoteTableViewController = segue.destination as? NoteTableViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                NoteTableViewController.notes = self.lists[selectedRow].list
                NoteTableViewController.index = selectedRow
            }
            
        }
    }
 
    
    //MARK: Actions
    
    @IBAction func unwindToListList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ListViewController, let list = sourceViewController.list {
            /*if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                lists[selectedIndexPath.row] = list
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {*/
                
                //Add a new list
                let newIndexPath = IndexPath(row: lists.count, section: 0)
                
                lists.append(list)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            //}
            
            saveLists()
            
        }
        
    }
    //MARK: Private Methods
    
    private func loadSampleLists() {
        var notes = [Note]()
        
        guard let notes1 = Note(note_name: "Banana") else {
                fatalError("Unable to instantiate notes1")
        }
        
        notes += [notes1]
        
        guard let list1 = List(list_name: "Costco", list: notes) else {
            fatalError("Unable to instantiate list1")
        }
        
        var notes_for_list = [Note]()
        
        guard let notes2 = Note(note_name: "Apple") else {
            fatalError("Unable to instantiate notes2")
        }
        
        notes_for_list += [notes2]
        
        guard let list2 = List(list_name: "Ralphs", list: notes_for_list) else {
            fatalError("Unable to instantiate lists")
        }
        
        lists += [list1,list2]
    }
    
    private func saveLists() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lists, toFile: List.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Lists successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save lists...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadLists() -> [List]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: List.ArchiveURL.path) as? [List]
    }
}
