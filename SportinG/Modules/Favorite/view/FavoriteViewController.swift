//
//  FavoriteViewController.swift
//  SportinG
//
//  Created by Rawan Elsayed on 20/05/2024.
//

import UIKit
import Reachability

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoriteTableView: UITableView!
    var backgroundImageView: UIImageView?
    
    var sportViewModel: SportViewModelProtocol!
    
    var fetchDataFromAPi : FetchDataFromApi?
    
    var leaguesNames: [String] = [String]()
    var leaguesKies: [Int] = [Int]()
    var leaguesImages: [String]?
    var numberOfLeagues = 0
    
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportViewModel = SportViewModel()

        fetchDataFromAPi = FetchDataFromApi()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        self.favoriteTableView!.register(UINib(nibName: "SportCustomCell", bundle: nil), forCellReuseIdentifier: "SportCustomCell")
        
        sportViewModel.retrieveFavoriteLeagues()
        reloadTableView()
        
        backgroundImageView = UIImageView(image: UIImage(named: "placeholderlogo.jpeg"))
        backgroundImageView?.contentMode = .scaleAspectFit
        favoriteTableView.backgroundView = backgroundImageView
        backgroundImageView?.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sportViewModel.retrieveFavoriteLeagues()
        reloadTableView()
        if sportViewModel.getFavoriteLeagues().isEmpty {
            backgroundImageView?.isHidden = false
        } else {
            backgroundImageView?.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportViewModel.getFavoriteLeagues().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "SportCustomCell", for: indexPath) as! SportCustomCell
    
        let league = sportViewModel.getFavoriteLeagues()[indexPath.row]
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
            let selectedLeague = sportViewModel.getFavoriteLeagues()[indexPath.row]
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
                
                leagueDetailsViewController.leagueKey = "\(leagueKey)"
                leagueDetailsViewController.leagueName = leagueName
                leagueDetailsViewController.leagueLogo = selectedLeague.value(forKey: "leagueLogo") as! String
            }
        } else {
            // No internet connection
            showNoInternetAlert()
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
            showDeleteConfirmationAlert(forRowAt: indexPath)
        }
    }
    
    func showDeleteConfirmationAlert(forRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            guard let self = self else { return }
            let league = self.sportViewModel.getFavoriteLeagues()[indexPath.row]
            let leagueKey = league.value(forKey: "leagueKey") as? String ?? ""
            self.sportViewModel.deleteFavoriteLeague(leagueKey: leagueKey)
            self.sportViewModel.retrieveFavoriteLeagues()
            self.favoriteTableView.deleteRows(at: [indexPath], with: .fade)
            self.reloadTableView()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
            if self.sportViewModel.getFavoriteLeagues().isEmpty {
                self.backgroundImageView?.isHidden = false
            } else {
                self.backgroundImageView?.isHidden = true
            }
        }
    }

    deinit {
        reachability.stopNotifier()
    }

}
