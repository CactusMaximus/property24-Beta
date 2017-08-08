//
//  PropertyResultTableViewCell.swift
//  p24Beta0.1
//
//  Created by Reverside Software Solutions on 2017/07/21.
//  Copyright © 2017 Reverside Software Solutions. All rights reserved.
//

import UIKit

class PropertyResultTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    

    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    @IBOutlet weak var garagesLabel: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
