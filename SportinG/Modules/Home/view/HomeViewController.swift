//
//  HomeViewController.swift
//  SportinG
//
//  Created by Rawan Elsayed on 20/05/2024.
//

import UIKit
import Reachability

class HomeViewController: UIViewController {
    
    var sportViewModel: SportViewModelProtocol?
    let sportsImgs = ["footballlogo", "basketballlogo", "cricketlogo", "tennislogo"]
    let sportsNames = ["Football", "BasketBall", "Circket", "Tennis"]
    
    let reachability = try! Reachability()
    
    var sportsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportViewModel = SportViewModel()
        let layout = UICollectionViewFlowLayout()
        sportsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(sportsCollectionView)
        
        sportsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        sportsCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        sportsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sportsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sportsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        sportsCollectionView.backgroundColor = UIColor.clear
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        
        sportsCollectionView.register(CustomSportCell.self, forCellWithReuseIdentifier: "sportCell")

    }
    
    func startMonitoringReachability() {
        reachability.whenUnreachable = { [weak self] _ in
            DispatchQueue.main.async {
                self?.showNoInternetAlert()
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    func showNoInternetAlert() {
        let alertController = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! CustomSportCell
        
        cell.sportImgView.image = UIImage(named: sportsImgs[indexPath.row])
        cell.nameLabel.text = sportsNames[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 20 , height: 230)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if reachability.connection == .unavailable {
               showNoInternetAlert()
        }else{
            
            print("sport \(indexPath.row + 1) is tapped")
           
            guard let sportLeaguesController = storyboard?.instantiateViewController(withIdentifier: "SportLeagues") as? SportLeaguesController else {
                return
            }
            
            sportLeaguesController.url = sportViewModel?.setSportUrl(selectedSport: indexPath.row).0 ?? ""
            sportLeaguesController.sport = sportViewModel?.setSportUrl(selectedSport: indexPath.row).1 ?? ""
            sportLeaguesController.modalPresentationStyle = .fullScreen
            present(sportLeaguesController, animated: true )

        }
            
    }
    
    
    
}

class CustomSportCell: UICollectionViewCell{
    
    let sportImgView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sportImgView)
        addSubview(nameLabel)
        
        sportImgView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sportImgView.topAnchor.constraint(equalTo: topAnchor),
            sportImgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sportImgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sportImgView.heightAnchor.constraint(equalToConstant: 160),
            sportImgView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 30),
                   
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
                              
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        //backgroundColor = UIColor.lightGray
        
        //contentView.backgroundColor = UIColor.clear
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.red.cgColor 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
    
}

