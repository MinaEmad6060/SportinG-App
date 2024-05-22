//
//  TeamDetailsViewController.swift
//  SportinG
//
//  Created by Mina Emad on 20/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBOutlet weak var teamDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamDetailsTableView.delegate = self
        teamDetailsTableView.dataSource = self
        
        self.teamDetailsTableView!.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Favorite")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "Favorite", for: indexPath) as! CustomCell
    
        cell.labelCustomCell.text = "This is Team Details"
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
