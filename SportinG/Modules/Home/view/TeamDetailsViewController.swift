//
//  TeamDetailsViewController.swift
//  SportinG
//
//  Created by Mina Emad on 20/05/2024.
//

import UIKit


struct TeamDetails{
    var team_logo: String?
    var team_name: String?
    var coach_name: String?

    var player_image: String?
    var player_name: String?
}

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var sportViewModel: SportViewModelProtocol?
    var teamId = ""
    var teamDetailsUrl = ""
    var sport = ""
    var teamDetailsResults: [TeamDetails] = []
    var numberOfPlayers = 0
    
    
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var teamImageView: UIImageView!
    
    
    @IBOutlet weak var teamDetailsTableView: UITableView!
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sportViewModel = SportViewModel()
        teamDetailsTableView.delegate = self
        teamDetailsTableView.dataSource = self
        
        self.teamDetailsTableView!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Upcoming URL : \(teamDetailsUrl)")
        
        sportViewModel?.getTeamsDetailsFromNetworkService(url: teamDetailsUrl)
        sportViewModel?.bindDetailsToViewController = {
            
            self.numberOfPlayers = self.sportViewModel?.leagueTeamsDetails?.result[0].players?.count ?? 0
            
            var teamDetails = TeamDetails()
            for i in 0..<self.numberOfPlayers{
                teamDetails.coach_name = self.sportViewModel?.leagueTeamsDetails?.result[0].coaches?[0].coach_name
                teamDetails.player_image = self.sportViewModel?.leagueTeamsDetails?.result[0].players?[i].player_image
                teamDetails.player_name = self.sportViewModel?.leagueTeamsDetails?.result[0].players?[i].player_name
                
                teamDetails.team_logo = self.sportViewModel?.leagueTeamsDetails?.result[0].team_logo
                teamDetails.team_name = self.sportViewModel?.leagueTeamsDetails?.result[0].team_name
                
                self.teamDetailsResults.append(teamDetails)
            }
            
            
            print("Players :: \(self.numberOfPlayers)")
            print("teamDetailsResults.count :: \(self.teamDetailsResults.count)")
            DispatchQueue.main.async {
                self.teamDetailsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teamDetailsResults.count != 0 {
            return teamDetailsResults.count
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "SportCustomCell", for: indexPath) as! SportCustomCell
        if(teamDetailsResults.count != 0){
            if let teamImageUrl = teamDetailsResults[0].team_logo,
               let teamUrl = URL(string: teamImageUrl),
               let playerImageUrl = teamDetailsResults[indexPath.row].player_image,
               let playerUrl = URL(string: playerImageUrl){
                self.teamImageView.kf.setImage(with: teamUrl)
                cell.imgCustomCell.kf.setImage(with: playerUrl)
            }
            self.teamName.text = teamDetailsResults[indexPath.row].team_name
            self.coachName.text = teamDetailsResults[indexPath.row].coach_name
            
            cell.labelCustomCell.text = teamDetailsResults[indexPath.row].player_name
        }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


