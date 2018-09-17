//
//  PAONumberTableViewController.swift
//  PAOR
//
//  Created by Nhu Nguyen on 9/15/18.
//  Copyright © 2018 Nhu Nguyen. All rights reserved.
//

import UIKit
import os.log

class PAONumberTableViewController: UITableViewController {
    //MARK: Properties
    var PAONumbers = [PAONumber] ()
    @IBOutlet weak var backToMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let savedPAOs = loadPAONumbers()
        {
            PAONumbers += savedPAOs
        }
        else
        {
        loadInitialPAONumbers()
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
        return PAONumbers.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PAONumberTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PAONumberTableViewCell else
        {
            fatalError("The dequeued cell is not an instance of PAONumberTableViewCell")
        }
        
        let PAONumber = PAONumbers[indexPath.row]
        let cellPerson = (PAONumber.person ?? "").isEmpty ? "Person": PAONumber.person!
        let cellAction = (PAONumber.action ?? "").isEmpty ? "Action": PAONumber.action!
        let cellObject = (PAONumber.object ?? "").isEmpty ? "Object": PAONumber.object!
        cell.photoImageView.image = PAONumber.photo
        cell.PAOlabel.text = cellPerson + " - " + cellAction + " - " + cellObject

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "")
        {
        case "ShowDetails":
            guard let PAONumberDetailViewController = segue.destination as? PAONumberViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedPAOCell = sender as? PAONumberTableViewCell else
            {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedPAOCell) else
            {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedPAO = PAONumbers[indexPath.row]
            PAONumberDetailViewController.PAO = selectedPAO
            
        case "BackToMenu":
            guard let menuViewController = segue.destination as? MenuViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let button = sender as? UIBarButtonItem, button == backToMenuButton else
            {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            menuViewController.PAONumbers = PAONumbers
            
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
       
        

    }

    //MARK: Action
    @IBAction func unwindToMealList(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? PAONumberViewController, let PAO = sourceViewController.PAO
        {
            // update existing PAO
            if let selectedPathIndex = tableView.indexPathForSelectedRow
            {
                PAONumbers[selectedPathIndex.row].person = PAO.person ?? nil
                PAONumbers[selectedPathIndex.row].action = PAO.action ?? nil
                PAONumbers[selectedPathIndex.row].object = PAO.object ?? nil
                tableView.reloadRows(at: [selectedPathIndex], with: .automatic)
            }
            savePAONumbers()
        }
    }
    //MARK: Private Methods
    private func loadInitialPAONumbers()
    {
        let photo0 = UIImage(named: "Number0")
        let photo1 = UIImage(named: "Number1")
        let photo2 = UIImage(named: "Number2")
        let photo3 = UIImage(named: "Number3")
        let photo4 = UIImage(named: "Number4")
        let photo5 = UIImage(named: "Number5")
        let photo6 = UIImage(named: "Number6")
        let photo7 = UIImage(named: "Number7")
        let photo8 = UIImage(named: "Number8")
        let photo9 = UIImage(named: "Number9")
        
        guard let PAO0 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo0) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO1 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo1) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO2 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo2) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO3 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo3) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO4 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo4) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO5 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo5) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO6 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo6) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO7 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo7) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO8 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo8) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        guard let PAO9 = PAONumber.init(person: nil, action: nil, object: nil, photo: photo9) else
        {
            fatalError("Unable to instantiate a PAONumber")
        }
        
        PAONumbers += [PAO0, PAO1, PAO2, PAO3, PAO4, PAO5, PAO6, PAO7, PAO8, PAO9]
    }
    
    private func savePAONumbers()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(PAONumbers, toFile: PAONumber.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("PAONumbers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save PAONumbers...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadPAONumbers() -> [PAONumber]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: PAONumber.ArchiveURL.path) as? [PAONumber]
    }
}
