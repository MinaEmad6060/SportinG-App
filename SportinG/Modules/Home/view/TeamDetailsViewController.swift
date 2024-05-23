//
//  TeamDetailsViewController.swift
//  SportinG
//
//  Created by Mina Emad on 20/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var teamId = ""
    var fetchDataFromAPi : FetchDataFromApi?
    var teamDetailsUrl = ""
    var sport = ""
    var teamDetailsResults: [Result] = []
    
    
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var teamImageView: UIImageView!
    
    
    @IBOutlet weak var teamDetailsTableView: UITableView!
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromAPi = FetchDataFromApi()
        teamDetailsTableView.delegate = self
        teamDetailsTableView.dataSource = self
        
        self.teamDetailsTableView!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Upcoming URL : \(teamDetailsUrl)")
        fetchDataFromAPi?.getSportData (url: teamDetailsUrl, handler: {[weak self] teamDetails in
            DispatchQueue.main.async {
                self?.teamDetailsResults = teamDetails.result
                self?.teamName.text = teamDetails.result[0].team_name
                self?.coachName.text = teamDetails.result[0].coaches?[0].coach_name
                print("ColView: \(teamDetails.result.count)")
                print("Home Team: \(teamDetails.result[0].event_home_team ?? "none")")
                self?.teamDetailsTableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teamDetailsResults.count != 0 {
            return teamDetailsResults[0].players?.count ?? 10
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "SportCustomCell", for: indexPath) as! SportCustomCell
        if(teamDetailsResults.count != 0){
            if let teamImageUrl = teamDetailsResults[0].team_logo,
               let teamUrl = URL(string: teamImageUrl),
               let playerImageUrl = teamDetailsResults[0].players?[indexPath.row].player_image,
               let playerUrl = URL(string: playerImageUrl){
                self.teamImageView.kf.setImage(with: teamUrl)
                cell.imgCustomCell.kf.setImage(with: playerUrl)
            }
            
            cell.labelCustomCell.text = teamDetailsResults[0].players?[indexPath.row].player_name
        }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
