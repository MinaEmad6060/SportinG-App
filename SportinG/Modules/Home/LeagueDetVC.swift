//
//  LeagueDetVC.swift
//  SportinG
//
//  Created by Mina Emad on 22/05/2024.
//

import UIKit
import Kingfisher

class LeagueDetVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBOutlet weak var leagueDetailsCollectionView: UICollectionView!
    
    var fetchDataFromAPi : FetchDataFromApi?
    var upcomingResults: [Result] = []
    var liveScoreResults: [Result] = []
    var teamsResults: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueDetailsCollectionView.delegate = self
        leagueDetailsCollectionView.dataSource = self
        
        fetchDataFromAPi = FetchDataFromApi()
        let nibCustomCell = UINib(nibName: "LeagueDetailsCollectionViewCell", bundle: nil)
        self.leagueDetailsCollectionView.register(nibCustomCell, forCellWithReuseIdentifier: "upcomingCell")
        self.leagueDetailsCollectionView.register(nibCustomCell, forCellWithReuseIdentifier: "latestCell")
//        self.leagueDetailsCollectionView.register(LogoCollectionViewCell.self, forCellWithReuseIdentifier: "latestCell")

        
        
        
        
        // 1
        let layout = UICollectionViewCompositionalLayout{sectionindex,enviroment in
            if sectionindex==0 {
                return self.drawTheTopSection()
            }else if sectionindex==1 {
                return self.drawTheTopSection2()
            }else{
                return self.drawTheTopSection3()
            }
            
            
        }
        leagueDetailsCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        fetchDataFromAPi?.getFootBallData (url: Utils.Urls.FootBall_Upcoming_Events.rawValue,handler: {[weak self] upcomingMatches in
            DispatchQueue.main.async {
                self?.upcomingResults = upcomingMatches.result
                print("ColView: \(upcomingMatches.result.count)")
                print("Home Team: \(upcomingMatches.result[0].event_home_team ?? "none")")
                self?.leagueDetailsCollectionView.reloadData()
            }
        })
        fetchDataFromAPi?.getFootBallData (url: Utils.Urls.FootBall_LiveScore_Events.rawValue,handler: {[weak self] liveScoreMatches in
            DispatchQueue.main.async {
                self?.liveScoreResults = liveScoreMatches.result
                print("ColView: \(liveScoreMatches.result.count)")
                print("Home Team: \(liveScoreMatches.result[0].event_home_team ?? "none")")
                self?.leagueDetailsCollectionView.reloadData()
            }
        })
        fetchDataFromAPi?.getFootBallData (url: Utils.Urls.FootBall_League_Teams.rawValue,handler: {[weak self] teamsMatches in
            DispatchQueue.main.async {
                self?.teamsResults = teamsMatches.result
                print("ColView: \(teamsMatches.result.count)")
                print("Home Team: \(teamsMatches.result[0].event_home_team ?? "none")")
                self?.leagueDetailsCollectionView.reloadData()
            }
        })
    }
    
    
    func drawTheTopSection ()-> NSCollectionLayoutSection{
        //6 item size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        //5 create item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 4 group size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(230))
        //3 create group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16 )
        //2 create section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.6
                let maxScale: CGFloat = 1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return section
    }
    
    
    func drawTheTopSection2 ()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                               , heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15
                                                        , bottom: 10, trailing: 15)
        
        return section
    }
    
    
    func drawTheTopSection3 ()-> NSCollectionLayoutSection{
        //6 item size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        //5 create item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 4 group size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(100))
        //3 create group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 8 )
        //2 create section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.2
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return section
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section==0 {
            return upcomingResults.count
        }else if section==1{
            if liveScoreResults.count != 0{
                return liveScoreResults.count
            }else{
                return 5
            }
            
        }else{
            return teamsResults.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section==0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as? LeagueDetailsCollectionViewCell else { fatalError("Failed to dequeue NewsCell") }
            
            
            if(upcomingResults.count != 0){
                if let homeImageUrl = upcomingResults[indexPath.row].home_team_logo,
                   let homeUrl = URL(string: homeImageUrl),
                   let awayImageUrl = upcomingResults[indexPath.row].away_team_logo,
                   let awayUrl = URL(string: awayImageUrl) {
                    cell.homeImage.kf.setImage(with: homeUrl)
                    cell.awayImage.kf.setImage(with: awayUrl)
                } else {
                    cell.homeImage.image = UIImage(named: "man.png")
                    cell.awayImage.image = UIImage(named: "man.png")
                }
                cell.homeTeam.text = upcomingResults[indexPath.row].event_home_team
                cell.awayTeam.text = upcomingResults[indexPath.row].event_away_team
                cell.dateOfMatch.text = upcomingResults[indexPath.row].event_date
                cell.timeOfMatch.text = upcomingResults[indexPath.row].event_time
            }
            
            return cell
        }else if indexPath.section==1 {
           
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath) as? LeagueDetailsCollectionViewCell else { fatalError("Failed to dequeue Cell") }
            
            if(liveScoreResults.count != 0){
                if let homeImageUrl = liveScoreResults[indexPath.row].home_team_logo,
                   let homeUrl = URL(string: homeImageUrl),
                   let awayImageUrl = liveScoreResults[indexPath.row].away_team_logo,
                   let awayUrl = URL(string: awayImageUrl) {
                    cell.homeImage.kf.setImage(with: homeUrl)
                    cell.awayImage.kf.setImage(with: awayUrl)
                } else {
                    cell.homeImage.image = UIImage(named: "man.png")
                    cell.awayImage.image = UIImage(named: "man.png")
                }
                cell.homeTeam.text = liveScoreResults[indexPath.row].event_home_team
                cell.awayTeam.text = liveScoreResults[indexPath.row].event_away_team
                cell.dateOfMatch.text = liveScoreResults[indexPath.row].event_date
                cell.timeOfMatch.text = liveScoreResults[indexPath.row].event_time
                cell.scoreOfLiveMatch.text = liveScoreResults[indexPath.row].event_final_result
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath)
            }
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? LogoCollectionViewCell else { fatalError("Failed to dequeue LatestCell") }
            
            if(teamsResults.count != 0){
                if let teamLogoUrl = teamsResults[indexPath.row].team_logo,
                   let teamUrl = URL(string: teamLogoUrl){
                    cell.logoOfTeam?.kf.setImage(with: teamUrl)
                } else {
                    cell.logoOfTeam.image = UIImage(named: "man.png")
                }
            }
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let storyboard = UIStoryboard(name: "Details", bundle: nil)
            if let teamDetailsController = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController{
                teamDetailsController.modalPresentationStyle = .fullScreen
                //                teamDetailsController.new = newsList[indexPath.row]
                present(teamDetailsController, animated: true, completion: nil)
            }
            print("Siiiiiiiiiiiiiii")
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
