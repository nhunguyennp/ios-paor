//
//  PAONumber.swift
//  PAOR
//
//  Created by Nhu Nguyen on 9/14/18.
//  Copyright © 2018 Nhu Nguyen. All rights reserved.
//

import UIKit
import os.log

class PAONumber: NSObject, NSCoding
{
    //MARK: Types
    struct PropertyKey
    {
        static let person = "person"
        static let action = "action"
        static let object = "object"
        static let photo = "photo"
    }
    
    //MARK: Properties
    var person: String?
    var action: String?
    var object: String?
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("PAONumbers")

    
    // MARK: Initilization
    init?(person: String?, action:String?, object: String?, photo: UIImage?)
    {
        // I: Have to figure out how to detect empty image -> fatalError
        self.person = person
        self.action = action
        self.object = object
        self.photo = photo
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(person, forKey: PropertyKey.person)
        aCoder.encode(action, forKey: PropertyKey.action)
        aCoder.encode(object, forKey: PropertyKey.object)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let person = aDecoder.decodeObject(forKey: PropertyKey.person) as? String else
        {
            os_log("Unable to decode person for PAO object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let action = aDecoder.decodeObject(forKey: PropertyKey.action) as? String else
        {
            os_log("Unable to decode action for PAO object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let object = aDecoder.decodeObject(forKey: PropertyKey.object) as? String else
        {
            os_log("Unable to decode object for PAO object", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        self.init(person: person, action: action, object: object, photo: photo)
    }
}
