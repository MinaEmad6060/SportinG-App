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
    
    @IBOutlet weak var imageNoData: UIImageView!
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sportViewModel = SportViewModel()
        teamDetailsTableView.delegate = self
        teamDetailsTableView.dataSource = self
        
        imageNoData.isHidden = true
        
        self.teamDetailsTableView!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        sportViewModel?.getTeamsDetailsFromNetworkService(url: teamDetailsUrl)
        sportViewModel?.bindDetailsToViewController = {
            
            self.teamName.text = self.sportViewModel?.leagueTeamsDetails?.result[0].team_name

            if let teamImageUrl = self.sportViewModel?.leagueTeamsDetails?.result[0].team_logo,
               let teamUrl = URL(string: teamImageUrl){
                self.teamImageView.kf.setImage(with: teamUrl)
            }else{
                if self.sport == "football"{
                    self.teamImageView.image  = UIImage(named: "footballlogo")
                }else if self.sport == "basketball"{
                    self.teamImageView.image  = UIImage(named: "basketballlogo")
                }else if self.sport == "cricket"{
                    self.teamImageView.image  = UIImage(named: "cricketlogo")
                }else if self.sport == "tennis"{
                    self.teamImageView.image  = UIImage(named: "tennislogo")
                }
            }
               
            self.numberOfPlayers = self.sportViewModel?.leagueTeamsDetails?.result[0].players?.count ?? 0
            
            var teamDetails = TeamDetails()
            for i in 0..<self.numberOfPlayers{
                teamDetails.coach_name = self.sportViewModel?.leagueTeamsDetails?.result[0].coaches?[0].coach_name
                teamDetails.player_image = self.sportViewModel?.leagueTeamsDetails?.result[0].players?[i].player_image
                teamDetails.player_name = self.sportViewModel?.leagueTeamsDetails?.result[0].players?[i].player_name
                self.teamDetailsResults.append(teamDetails)
            }
            
            
            DispatchQueue.main.async {
                self.teamDetailsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teamDetailsResults.count > 0 {
            imageNoData.isHidden = true
            teamDetailsTableView.isHidden = false
            return teamDetailsResults.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "SportCustomCell", for: indexPath) as! SportCustomCell
        if(teamDetailsResults.count > 0){
            

            if let playerImageUrl = teamDetailsResults[indexPath.row].player_image,
               let playerUrl = URL(string: playerImageUrl){
                cell.imgCustomCell.kf.setImage(with: playerUrl)
            }
            self.coachName.text = teamDetailsResults[0].coach_name
            
            cell.labelCustomCell.text = teamDetailsResults[indexPath.row].player_name
        }else{
            imageNoData.isHidden = false
            teamDetailsTableView.isHidden = true
        }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


