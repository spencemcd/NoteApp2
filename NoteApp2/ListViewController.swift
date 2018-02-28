//
//  ListViewController.swift
//  NoteApp2
//
//  Created by Spencer Mcdonald on 2/27/18.
//  Copyright © 2018 NoteApp2. All rights reserved.
//

import UIKit
import os.log

class ListViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var listTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var list: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call delegate back so you can track events
        listTextField.delegate = self
        
        //Set up note if non-nil (existing)
        if let list = list {
            listTextField.text = list.list_name
        }
        
        //Enable save button only if text field has valid List name
        updateSaveButtonState()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    //MARK: Navigation
    @IBAction func cancelSelected(_ sender: UIBarButtonItem) {
        let isPresentingInAddListMode = presentingViewController is UINavigationController
        
        if isPresentingInAddListMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The ListViewController is not inside a navigation controller.")
        }
    }
    
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let list_name = listTextField.text ?? ""
        
        //Set note to be passed to NoteTableViewController after the unwind segue
        var notes = [Note]()
        list = List(list_name: list_name, list: notes)
    }
    //MARK: Actions
    
    /*@IBAction func setDefaultLabelText(_ sender: UIButton) {
     nameLabel.text = "Default Text"
     
     }*/
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = listTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}
