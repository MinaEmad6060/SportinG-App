//
//  FavoriteViewController.swift
//  SportinG
//
//  Created by Rawan Elsayed on 20/05/2024.
//

import UIKit
import CoreData
import Reachability

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteLeagues: [NSManagedObject] = []
    let dataManager = CoreDataManager()
    var fetchDataFromAPi : FetchDataFromApi?
    
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDataFromAPi = FetchDataFromApi()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        self.favoriteTableView!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
        
        retrieveDataFromCoreData()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveDataFromCoreData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLeagues.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "SportCustomCell", for: indexPath) as! SportCustomCell
    
        let league = favoriteLeagues[indexPath.row]
        if let leagueName = league.value(forKey: "leagueName") as? String {
                cell.labelCustomCell.text = leagueName
            }
        if let logoURLString = league.value(forKey: "leagueLogo"), let logoURL = URL(string: logoURLString as! String) {
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
        if reachability.connection != .unavailable {
            // Reachability is available
            let selectedLeague = favoriteLeagues[indexPath.row]
            let leagueName = selectedLeague.value(forKey: "leagueName") as! String
            let leagueKey = selectedLeague.value(forKey: "leagueKey") as! String
            print("Selected League: \(leagueName), League Key: \(leagueKey)")

            // Proceed with navigation
            let storyboard = UIStoryboard(name: "Details", bundle: nil)
            if let leagueDetailsViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController {
                let sportName = selectedLeague.value(forKey: "sportName") as! String
                leagueDetailsViewController.eventsUrl = fetchDataFromAPi?.formatURL(sport: sportName, met: "Fixtures", leagueId: leagueKey) ?? ""
                leagueDetailsViewController.teamsUrl = fetchDataFromAPi?.formatURL(sport: sportName, met: "Teams", leagueId: leagueKey) ?? ""
                leagueDetailsViewController.sport = sportName
                self.present(leagueDetailsViewController, animated: true, completion: nil)
            }
        } else {
            // No internet connection
            showNoInternetAlert()
        }
    }
    
    func retrieveDataFromCoreData() {
        if let leagues = dataManager.retrieveFromCoreData(application: UIApplication.shared) {
            favoriteLeagues = leagues
            favoriteTableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let league = favoriteLeagues[indexPath.row]
            let leagueKey = league.value(forKey: "leagueKey") as? String ?? ""
            dataManager.deleteFromCoreData(application: UIApplication.shared, leagueKey: leagueKey)
            favoriteLeagues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    deinit {
        reachability.stopNotifier()
    }

}
