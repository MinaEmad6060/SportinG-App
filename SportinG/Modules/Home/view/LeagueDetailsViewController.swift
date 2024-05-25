//
//  LeagueDetVC.swift
//  SportinG
//
//  Created by Mina Emad on 22/05/2024.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dataManager = CoreDataManager()
    
    var isFavorited = false
    
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBOutlet weak var leagueDetailsCollectionView: UICollectionView!
    
    var sportViewModel: SportViewModelProtocol?
    var numberOfUpcoming = 0
    var numberOfLatest = 0
    var numberOfTeams = 0
    var eventsUrl = ""
    var teamsUrl = ""
    var sport = ""
    var upcomingEvents: [UpcomingEvents] = []
    var latestEvents: [UpcomingEvents] = []
    var teamsLogos: [String] = []
    var teamsKies: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportViewModel = SportViewModel()
        leagueDetailsCollectionView.delegate = self
        leagueDetailsCollectionView.dataSource = self
        
        let nibCustomCell = UINib(nibName: "LeagueDetailsCollectionViewCell", bundle: nil)
        self.leagueDetailsCollectionView.register(nibCustomCell, forCellWithReuseIdentifier: "upcomingCell")
        self.leagueDetailsCollectionView.register(nibCustomCell, forCellWithReuseIdentifier: "latestCell")
        
        
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
        
        updateFavButtonImage()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        sportViewModel?.getLeagueDetailsFromNetworkService(url: eventsUrl+"&from=2024-05-29&to=2025-05-29")
        sportViewModel?.bindUpcomingToViewController = {
            self.numberOfUpcoming = self.sportViewModel?.leaguesUpcomingDetails?.result.count ?? 10
            for i in 0..<self.numberOfUpcoming {
                var upcomingEvent = UpcomingEvents()
                upcomingEvent.away_team_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].away_team_logo
                upcomingEvent.event_away_team = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_away_team
                upcomingEvent.event_date = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_date
                upcomingEvent.event_home_team = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_home_team
                upcomingEvent.event_time = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_time
                upcomingEvent.home_team_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].home_team_logo
                upcomingEvent.league_key = self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_key
                upcomingEvent.league_name = self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_name
                upcomingEvent.league_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_logo
                self.upcomingEvents.append(upcomingEvent)
            }
            
            
            DispatchQueue.main.async {
                self.leagueDetailsCollectionView.reloadData()
            }
        }
        
        sportViewModel?.getLatestDetailsFromNetworkService(url: eventsUrl+"&from=2023-05-29&to=2024-05-29")
        print("Latest eventsUrl  :: \(eventsUrl+"&from=2023-05-29&to=2024-05-29")")
        sportViewModel?.bindLatestToViewController = {
            self.numberOfLatest = self.sportViewModel?.leagueLatestDetails?.result.count ?? 0
            print("numberOfLatest : \(self.numberOfLatest)")
            for i in 0..<self.numberOfLatest {
                var latestEvent = UpcomingEvents()
                latestEvent.away_team_logo = self.sportViewModel?.leagueLatestDetails?.result[i].away_team_logo
                latestEvent.event_away_team = self.sportViewModel?.leagueLatestDetails?.result[i].event_away_team
                latestEvent.event_date = self.sportViewModel?.leagueLatestDetails?.result[i].event_date
                latestEvent.event_home_team = self.sportViewModel?.leagueLatestDetails?.result[i].event_home_team
                latestEvent.event_time = self.sportViewModel?.leagueLatestDetails?.result[i].event_time
                latestEvent.home_team_logo = self.sportViewModel?.leagueLatestDetails?.result[i].home_team_logo
                latestEvent.league_key = self.sportViewModel?.leagueLatestDetails?.result[i].league_key
                latestEvent.league_name = self.sportViewModel?.leagueLatestDetails?.result[i].league_name
                latestEvent.league_logo = self.sportViewModel?.leagueLatestDetails?.result[i].league_logo
                latestEvent.event_final_result = self.sportViewModel?.leagueLatestDetails?.result[i].event_final_result
                self.latestEvents.append(latestEvent)
                
            }
            print("self.latestEvents : \(self.latestEvents.count)")
            
            DispatchQueue.main.async {
                self.leagueDetailsCollectionView.reloadData()
            }
        }
        
        sportViewModel?.getTeamsDetailsFromNetworkService(url: teamsUrl)
        print("Latest eventsUrl  :: \(teamsUrl)")
        sportViewModel?.bindLogosToViewController = {
            self.numberOfTeams = self.sportViewModel?.leagueTeamsLogos?.result.count ?? 0
            print("numberOfLatest : \(self.numberOfLatest)")
            for i in 0..<self.numberOfTeams {
                var teamLogo = ""
                var teamKey = -1
                teamLogo = self.sportViewModel?.leagueTeamsLogos?.result[i].team_logo ?? ""
                teamKey = self.sportViewModel?.leagueTeamsLogos?.result[i].team_key ?? -1
                self.teamsLogos.append(teamLogo)
                self.teamsKies.append(teamKey)
            }
            
            DispatchQueue.main.async {
                self.leagueDetailsCollectionView.reloadData()
            }
        }
        
        updateFavButtonImage()
    }
    
    
    func drawTheTopSection ()-> NSCollectionLayoutSection{

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(230))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16 )

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
        updateFavButtonImage()
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
        updateFavButtonImage()
        return section
    }
    
    
    func drawTheTopSection3 ()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(100))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 8 )

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
        updateFavButtonImage()
        return section
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section==0 {
            if 0 < upcomingEvents.count && upcomingEvents.count < 50 {
                return upcomingEvents.count
            }else {
                return 10
            }
        }else if section==1{
            if 0 < latestEvents.count && latestEvents.count < 50 {
                return latestEvents.count
            }else {
                return 10
            }
            
        }else{
            if teamsLogos.count != 0{
                return teamsLogos.count
            }else {
                return 10
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section==0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as? LeagueDetailsCollectionViewCell else { fatalError("Failed to dequeue NewsCell") }
            
            if(upcomingEvents.count != 0){
                if let homeImageUrl = upcomingEvents[indexPath.row].home_team_logo,
                   let homeUrl = URL(string: homeImageUrl),
                   let awayImageUrl = upcomingEvents[indexPath.row].away_team_logo,
                   let awayUrl = URL(string: awayImageUrl) {
                    cell.homeImage.kf.setImage(with: homeUrl)
                    cell.awayImage.kf.setImage(with: awayUrl)
                } else {
                    cell.homeImage.image = UIImage(named: "man.png")
                    cell.awayImage.image = UIImage(named: "man.png")
                }
                cell.homeTeam.text = upcomingEvents[indexPath.row].event_home_team
                cell.awayTeam.text = upcomingEvents[indexPath.row].event_away_team
                cell.dateOfMatch.text = upcomingEvents[indexPath.row].event_date
                cell.timeOfMatch.text = upcomingEvents[indexPath.row].event_time
            }
            
            return cell
        }else if indexPath.section==1 {
           
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath) as? LeagueDetailsCollectionViewCell else { fatalError("Failed to dequeue Cell") }
            
            print(" section1 latestEvents.count  ::  \(latestEvents.count)")
            
            if(latestEvents.count != 0){
                if let homeImageUrl = latestEvents[indexPath.row].home_team_logo,
                   let homeUrl = URL(string: homeImageUrl),
                   let awayImageUrl = latestEvents[indexPath.row].away_team_logo,
                   let awayUrl = URL(string: awayImageUrl) {
                    cell.homeImage.kf.setImage(with: homeUrl)
                    cell.awayImage.kf.setImage(with: awayUrl)
                } else {
                    cell.homeImage.image = UIImage(named: "man.png")
                    cell.awayImage.image = UIImage(named: "man.png")
                }
                cell.homeTeam.text = latestEvents[indexPath.row].event_home_team
                print(" latestEvents[\(indexPath.row)].event_home_team  ::  \(latestEvents[indexPath.row].event_home_team ?? "-1")")
                cell.awayTeam.text = latestEvents[indexPath.row].event_away_team
                cell.dateOfMatch.text = latestEvents[indexPath.row].event_date
                cell.timeOfMatch.text = latestEvents[indexPath.row].event_time
                cell.scoreOfLiveMatch.text = latestEvents[indexPath.row].event_final_result
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath)
            }
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? LogoCollectionViewCell else { fatalError("Failed to dequeue LatestCell") }
            
            if(teamsLogos.count != 0){
                if !teamsLogos[indexPath.row].isEmpty {
                   let teamUrl = URL(string: teamsLogos[indexPath.row])
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
                teamDetailsController.teamDetailsUrl = sportViewModel?.getTeamsDetailsFormatedUrl(sport: sport, met: "Teams", teamId: "\(teamsKies[indexPath.row])") ?? ""
                
                teamDetailsController.sport = sport
                present(teamDetailsController, animated: true, completion: nil)
            }
        }
    }
    
  
    
    
    @IBAction func btnFav(_ sender: Any) {
                
        guard let selectedLeague = upcomingEvents.first else {
                return
        }
        
        let leagueKey: String
            if let key = selectedLeague.league_key {
                leagueKey = "\(key)"
            } else {
                leagueKey = ""
            }
        
        let leagueName = selectedLeague.league_name ?? ""
        let leagueLogo = selectedLeague.league_logo ?? ""
        let sportName = sport
                
        if !dataManager.leagueExistsInCoreData(application: UIApplication.shared, leagueKey: leagueKey) {
            dataManager.saveToCoreData(application: UIApplication.shared, leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
            print("League added to favorites!")
            isFavorited = true
            favBtn.image = UIImage(systemName: "heart.fill")
        } else {
            dataManager.deleteFromCoreData(application: UIApplication.shared, leagueKey: leagueKey)
            print("League removed from favorites!")
            isFavorited = false
            favBtn.image = UIImage(systemName: "heart")
        }
    }
    
    func updateFavButtonImage() {
        if let selectedLeague = upcomingEvents.first, let leagueKey = selectedLeague.league_key {
            if dataManager.leagueExistsInCoreData(application: UIApplication.shared, leagueKey: "\(leagueKey)") {
                isFavorited = true
                favBtn.image = UIImage(systemName: "heart.fill")
                print("isssssssss favorite")
            } else {
                isFavorited = false
                favBtn.image = UIImage(systemName: "heart")
                print("issssssss not favorite")
            }
        }
    }
    
}


struct UpcomingEvents{
    var home_team_logo: String?
    var away_team_logo: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_date: String?
    var event_time: String?
    var league_name: String?
    var league_logo: String?
    var event_final_result: String?
    var league_key: Int?
}
