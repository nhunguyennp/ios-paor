//
//  MenuViewController.swift
//  PAOR
//
//  Created by Nhu Nguyen on 9/16/18.
//  Copyright © 2018 Nhu Nguyen. All rights reserved.
//

import UIKit
import os.log

class MenuViewController: UIViewController {
    
    //MARK: Properties
    var PAONumbers = [PAONumber]()
    
    @IBOutlet weak var practiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedPAOs = loadPAONumbers()
        {
            PAONumbers += savedPAOs
        }
        practiceButton.isEnabled = checkPAONumbersFilled()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        practiceButton.isEnabled = checkPAONumbersFilled()
        dump(PAONumbers)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
    @IBAction func unwindToMenu(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? PAONumberTableViewController
        {
            let PAONumbers = sourceViewController.PAONumbers
            if !PAONumbers.isEmpty
            {
                os_log("PAO List unwinded successfully to Menu", log: OSLog.default, type: .debug)
            }
            else
            {
                os_log("PAO List unwinded to Menu failed", log: OSLog.default, type: .debug)
            }
        }
        else if let sourceViewController = sender.source as? PracticeViewController
        {
            PAONumbers = sourceViewController.PAONumbers
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let selectedButton = sender as? UIButton, selectedButton == practiceButton else
        {
            os_log("Practice button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        guard let practiceViewController = segue.destination as? PracticeViewController else
        {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        practiceViewController.PAONumbers = PAONumbers
        os_log("From Menu: PAOList received from Menu to Practice", log: OSLog.default, type: .debug)
    }
    //MARK: Private Methods
    private func checkPAONumbersFilled() -> Bool
    {
        var tempPAONumbers = [PAONumber] ()
        for PAONumber in PAONumbers
        {
            if let person = PAONumber.person, let action = PAONumber.action, let object = PAONumber.object, !person.isEmpty && !action.isEmpty && !object.isEmpty
            {
                tempPAONumbers.append(PAONumber)
            }
        }
        if tempPAONumbers.count == PAONumbers.count
        {
            return true
        }
        return false
    }
    private func updatePracticeButtonState()
    {
        if checkPAONumbersFilled()
        {
            os_log("PAO List filled", log: OSLog.default, type: .debug)
            practiceButton.isEnabled = true
            dump(PAONumbers)
        }
        else
        {
            os_log("PAO List not filled", log: OSLog.default, type: .debug)
            practiceButton.isEnabled = false
        }
    }
    private func loadPAONumbers() -> [PAONumber]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: PAONumber.ArchiveURL.path) as? [PAONumber]
    }
}
