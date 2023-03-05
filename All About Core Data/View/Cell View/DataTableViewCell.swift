//
//  DataTableViewCell.swift
//  All About Core Data
//
//  Created by Shishir_Mac on 5/3/23.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
