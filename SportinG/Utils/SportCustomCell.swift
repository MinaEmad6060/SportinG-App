//
//  CustomCell.swift
//  SportinG
//
//  Created by Rawan Elsayed on 21/05/2024.
//

import UIKit

class SportCustomCell: UITableViewCell {

    @IBOutlet weak var imgCustomCell: UIImageView!
    
    
    @IBOutlet weak var labelCustomCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
