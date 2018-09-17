//
//  PAONumberViewController.swift
//  PAOR
//
//  Created by Nhu Nguyen on 9/14/18.
//  Copyright © 2018 Nhu Nguyen. All rights reserved.
//

import UIKit
import os.log

class PAONumberViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var personTextField: UITextField!
    @IBOutlet weak var actionTextField: UITextField!
    @IBOutlet weak var objectTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var PAO: PAONumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // handle the text fields' input through delegate callbacks
        personTextField.delegate = self
        actionTextField.delegate = self
        objectTextField.delegate = self
        
        if let PAO = PAO
        {
            personTextField.text = PAO.person
            actionTextField.text = PAO.action
            objectTextField.text = PAO.object
            photoImageView.image = PAO.photo
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented, after a segue is triggered
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else
        {
            os_log("Save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let person = personTextField.text ?? nil
        let action = actionTextField.text ?? nil
        let object = objectTextField.text ?? nil
        PAO = PAONumber(person: person, action: action, object: object, photo: photoImageView.image)
    }
    
    
    /*
    // read information read and do something with it
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    */
    
    
}

