//
//  FieldsCell.swift
//  ClimateControl
//
//  Created by Akshat Goyal on 2/20/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import UIKit

class FieldsCell: UITableViewCell {

    @IBOutlet weak var fieldNameLabel: UILabel!
    @IBOutlet weak var thumbNailView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.roundedView.layer.cornerRadius = 10
        self.roundedView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
