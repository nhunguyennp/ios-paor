//
//  PAONumberTableViewCell.swift
//  PAOR
//
//  Created by Nhu Nguyen on 9/15/18.
//  Copyright © 2018 Nhu Nguyen. All rights reserved.
//

import UIKit

class PAONumberTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var PAOlabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
