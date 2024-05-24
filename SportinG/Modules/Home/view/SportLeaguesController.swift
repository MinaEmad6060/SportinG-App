//
//  SportLeaguesController.swift
//  SportinG
//
//  Created by Rawan Elsayed on 22/05/2024.
//

import UIKit
import Kingfisher

class SportLeaguesController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sportLeaguesTable: UITableView!
    

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    

    var url = ""
    var sport = ""

//    var sportLeagues: [Result] = []
    
    var leagueName: [String] = [String]()
    var leagueImage: [String]?
    var numberOfLeagues = 0
    var sportViewModel: SportViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueImage = [String]()
        sportViewModel = SportViewModel()
        print("Leagues Screen Loaded")

        sportLeaguesTable.delegate = self
        sportLeaguesTable.dataSource = self
        
        self.sportLeaguesTable!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
        
        sportViewModel?.getSportLeaguesFromNetworkService(url: url)
        sportViewModel?.bindResultToViewController = {
            self.numberOfLeagues = self.sportViewModel?.sportDetails?.result.count ?? 10
            
            for i in 0..<self.numberOfLeagues {
                self.leagueName.append(self.sportViewModel?.sportDetails?.result[i].league_name ?? "")
                self.leagueImage?.append(self.sportViewModel?.sportDetails?.result[i].league_logo ?? "")
            }
            
            
            DispatchQueue.main.async {
                self.sportLeaguesTable.reloadData()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfLeagues
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sportLeaguesTable.dequeueReusableCell(withIdentifier: "SportCustomCell", for: indexPath) as! SportCustomCell
            
        cell.labelCustomCell.text = leagueName[indexPath.row]
        
//        if let logoURL = URL(string: leagueImage[indexPath.row]) {
//            cell.imgCustomCell.kf.setImage(with: logoURL, placeholder: UIImage(named: "placeholderlogo.jpeg"))
//        }
        
        if let logoURLString = leagueImage?[indexPath.row], let logoURL = URL(string: logoURLString) {
            cell.imgCustomCell.kf.setImage(with: logoURL, placeholder: UIImage(named: "placeholderlogo.jpeg"))
        } else {
            cell.imgCustomCell.image = UIImage(named: "placeholderlogo.jpeg")
        }
               
        // Make the image circular
        cell.imgCustomCell.layer.cornerRadius = 55
        cell.imgCustomCell.clipsToBounds = true
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Details", bundle: nil)
//        if let leagueDetailsViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController{
//            leagueDetailsViewController.eventsUrl =
//            fetchDataFromApi?.formatURL(sport: sport,
//                                        met: "Fixtures",
//                                        leagueId: "\(sportLeagues[indexPath.row].league_key ?? 4)") ?? ""
//            print("League key = \(sportLeagues[indexPath.row].league_key ?? 4)")
//            leagueDetailsViewController.teamsUrl =
//            fetchDataFromApi?.formatURL(sport: sport,
//                                        met: "Teams",
//                                        leagueId: "\(sportLeagues[indexPath.row].league_key ?? 4)") ?? ""
//            leagueDetailsViewController.sport = sport
//            present(leagueDetailsViewController, animated: true, completion: nil)
//        }
//    }


}
