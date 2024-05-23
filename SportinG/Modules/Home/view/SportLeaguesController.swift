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
    
    var url: String = ""
    var sportLeagues: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Leagues Screen Loaded")

        sportLeaguesTable.delegate = self
        sportLeaguesTable.dataSource = self
        
        self.sportLeaguesTable!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
        
        fetchSportLeaguesData()
    }
    
    func fetchSportLeaguesData() {
        FetchDataFromApi().getFootBallData(url: url) { sportDetails in
            self.sportLeagues = sportDetails.result
            DispatchQueue.main.async {
                self.sportLeaguesTable.reloadData()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportLeagues.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sportLeaguesTable.dequeueReusableCell(withIdentifier: "SportCustomCell", for: indexPath) as! SportCustomCell
            
        let league = sportLeagues[indexPath.row]
        cell.labelCustomCell.text = league.league_name
        
        if let logoURLString = league.league_logo, let logoURL = URL(string: logoURLString) {
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


}
