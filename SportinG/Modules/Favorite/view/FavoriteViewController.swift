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
    
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
        //cell.labelCustomCell.text = "This is Favorite"
        let league = favoriteLeagues[indexPath.row]
        if let leagueName = league.value(forKey: "leagueName") as? String {
                cell.labelCustomCell.text = leagueName
            }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        startMonitoringReachability()
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


    deinit {
        reachability.stopNotifier()
    }

}
