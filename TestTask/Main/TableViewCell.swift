//
//  TableViewCell.swift
//  TestTask
//
//  Created by Igor Ryazancev on 14.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var stringLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
