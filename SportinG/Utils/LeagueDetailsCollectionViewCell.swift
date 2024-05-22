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
    
    
    
    
    
    
    
    
//    @IBOutlet weak var homeImage: UIImageView!
//    
//    @IBOutlet weak var homeTeam: UILabel!
//    
//    @IBOutlet weak var awayImage: UIImageView!
//    
//    @IBOutlet weak var awayTeam: UILabel!
//    
//    
//    @IBOutlet weak var dateOfMatch: UILabel!
//    
//    
//    @IBOutlet weak var timeOfMatch: UILabel!
//    
//    
//    @IBOutlet weak var scoreOfLiveMatch: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
