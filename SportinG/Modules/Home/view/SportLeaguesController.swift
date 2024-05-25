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
    var leaguesNames: [String] = [String]()
    var leaguesKies: [Int] = [Int]()
    var leaguesImages: [String]?
    var numberOfLeagues = 0
    var sportViewModel: SportViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesImages = [String]()
        sportViewModel = SportViewModel()
        print("Leagues Screen Loaded")

        sportLeaguesTable.delegate = self
        sportLeaguesTable.dataSource = self
        
        self.sportLeaguesTable!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
        
        sportViewModel?.getSportLeaguesFromNetworkService(url: url)
        sportViewModel?.bindUpcomingToViewController = {
            self.numberOfLeagues = self.sportViewModel?.leaguesUpcomingDetails?.result.count ?? 10
            
            for i in 0..<self.numberOfLeagues {
                self.leaguesNames.append(self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_name ?? "")
                self.leaguesKies.append(self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_key ?? 585)
                self.leaguesImages?.append(self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_logo ?? "")
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
            
        cell.labelCustomCell.text = leaguesNames[indexPath.row]
        
        if let logoURLString = leaguesImages?[indexPath.row], let logoURL = URL(string: logoURLString) {
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        if let leagueDetailsViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController{
            leagueDetailsViewController.eventsUrl =
            sportViewModel?.getLeaguesFormatedUrl(sport: sport, met: "Fixtures", leaguesKies: leaguesKies, index: indexPath.row) ?? ""
            
            leagueDetailsViewController.teamsUrl = sportViewModel?.getLeaguesFormatedUrl(sport: sport, met: "Teams", leaguesKies: leaguesKies, index: indexPath.row) ?? ""

            leagueDetailsViewController.sport = sport
            present(leagueDetailsViewController, animated: true, completion: nil)
        }
    }


}
