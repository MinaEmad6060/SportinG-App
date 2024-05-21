//
//  HomeViewController.swift
//  SportinG
//
//  Created by Rawan Elsayed on 20/05/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sportsImgs = ["todoimg.jpeg", "todoimg.jpeg", "todoimg.jpeg", "todoimg.jpeg"]
    let sportsNames = ["Football", "BasketBall", "Circket", "Tennis"]
    
    var sportsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        sportsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(sportsCollectionView)
        
        sportsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        sportsCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        sportsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sportsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sportsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        sportsCollectionView.backgroundColor = UIColor.clear
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        
        sportsCollectionView.register(CustomSportCell.self, forCellWithReuseIdentifier: "sportCell")


        
    }
    

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! CustomSportCell
        
        cell.sportImgView.image = UIImage(named: sportsImgs[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 20 , height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("sport \(indexPath.row + 1) is tapped")
    }
    
}

class CustomSportCell: UICollectionViewCell{
    
    let sportImgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sportImgView)
        
        sportImgView.translatesAutoresizingMaskIntoConstraints = false
        
        sportImgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sportImgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sportImgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sportImgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        sportImgView.layer.cornerRadius = 20
        sportImgView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
    
}

