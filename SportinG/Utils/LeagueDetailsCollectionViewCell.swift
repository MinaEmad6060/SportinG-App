//
//  LeagueDetailsCollectionViewCell.swift
//  SportinG
//
//  Created by Mina Emad on 20/05/2024.
//

import UIKit

class LeagueDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeImage: UIImageView!
    
    @IBOutlet weak var homeTeam: UILabel!
    
    @IBOutlet weak var awayImage: UIImageView!
    
    @IBOutlet weak var awayTeam: UILabel!
    
    @IBOutlet weak var dateOfMatch: UILabel!
    
    @IBOutlet weak var timeOfMatch: UILabel!
    
    @IBOutlet weak var scoreOfLiveMatch: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 30.0
        self.contentView.layer.masksToBounds = false
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor(red: 0.25, green: 0.5, blue: 1.0, alpha: 0.05)
        self.contentView.layer.borderColor = UIColor.blue.cgColor
        self.contentView.layer.borderWidth = 2.0
    }

}
