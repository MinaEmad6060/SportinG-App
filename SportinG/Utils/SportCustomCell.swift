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
    
    let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 30.0
            view.layer.masksToBounds = true
            view.clipsToBounds = true
            view.backgroundColor = UIColor(red: 0.25, green: 0.5, blue: 1.0, alpha: 0.05)
            view.layer.borderColor = UIColor.blue.cgColor
            view.layer.borderWidth = 2.0
            return view
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupContainerView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupContainerView()
        }
        
        private func setupContainerView() {
            contentView.addSubview(containerView)
            
            // Set constraints for the container view to create padding
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
            ])
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
