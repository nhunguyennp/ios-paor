//
//  PracticeViewController.swift
//  PAOR
//
//  Created by Nhu Nguyen on 9/16/18.
//  Copyright © 2018 Nhu Nguyen. All rights reserved.
//

import UIKit
import os.log
class PracticeViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var buttonPAO1Back: UIButton!
    @IBOutlet weak var buttonPAO2Back: UIButton!
    @IBOutlet weak var buttonPAO3Back: UIButton!
    
    var PAONumbers = [PAONumber]()
    
    var firstPAO: PAONumber?
    var secondPAO: PAONumber?
    var thirdPAO: PAONumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dump(PAONumbers)
        os_log("Randomize numbers...", log: OSLog.default, type: .debug)
        firstPAO = randomizePAONumbers()
        secondPAO = randomizePAONumbers()
        thirdPAO = randomizePAONumbers()
        
        buttonPAO1Back.setBackgroundImage(firstPAO?.photo, for: .normal)
        buttonPAO2Back.setBackgroundImage(secondPAO?.photo, for: .normal)
        buttonPAO3Back.setBackgroundImage(thirdPAO?.photo, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func randomizePAONumbers() -> PAONumber
    {
        let randomPAOIndex = Int(arc4random_uniform(10))
        
        return PAONumbers[randomPAOIndex]
    }
    //MARK: Actions
    @IBAction func flipFirstPAO(_ sender: Any) {
        let imagePAOFront = UIImage(named: "PAOFront")
        buttonPAO1Back.setBackgroundImage(imagePAOFront, for: .normal)
        UIView.transition(with: buttonPAO1Back, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        let textPAOFront = firstPAO?.person
        buttonPAO1Back.setTitle(textPAOFront, for: .normal)
    }
    
    @IBAction func flipSecondPAO(_ sender: Any) {
        let imagePAOFront = UIImage(named: "PAOFront")
        buttonPAO2Back.setBackgroundImage(imagePAOFront, for: .normal)
        UIView.transition(with: buttonPAO2Back, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        let textPAOFront = secondPAO?.action
        buttonPAO2Back.setTitle(textPAOFront, for: .normal)
    }
    
    
    @IBAction func flipThirdPAO(_ sender: Any) {
        let imagePAOFront = UIImage(named: "PAOFront")
        buttonPAO3Back.setBackgroundImage(imagePAOFront, for: .normal)
        UIView.transition(with: buttonPAO3Back, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        let textPAOFront = thirdPAO?.object
        buttonPAO3Back.setTitle(textPAOFront, for: .normal)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "ShowPractice":
            guard let sourceViewController = segue.source as? MenuViewController else
            {
                fatalError("Unexpected source: \(segue.source)")
            }
            PAONumbers = sourceViewController.PAONumbers
            os_log("From Practice: PAOList received from Menu to Practice", log: OSLog.default, type: .debug)
        case "PracticeMore":
            guard let destinationViewController = segue.destination as? PracticeViewController else
            {
                fatalError("Unexpected source: \(segue.destination)")
            }
            destinationViewController.PAONumbers = PAONumbers
        case "ReturnToMenu":
            guard let destinationViewController = segue.destination as? MenuViewController else
            {
                fatalError("Unexpected source: \(segue.destination)")
            }
            destinationViewController.PAONumbers = PAONumbers
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }
    
    
}
