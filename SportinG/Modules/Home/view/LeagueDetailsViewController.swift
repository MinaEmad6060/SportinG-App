//
//  LeagueDetVC.swift
//  SportinG
//
//  Created by Mina Emad on 22/05/2024.
//

import UIKit
import Kingfisher



class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
    var sportViewModel: SportViewModelProtocol!
    
    var isFavorited = false
    
    var homeImageUrl: String?
    var awayImageUrl: String?
    var homeTeamName: String?
    var awayTeamName: String?
    var dateOfMatch: String?
    var scoreOfLiveMatch: String?
    var imagePlaceHolder: UIImage?
    
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBOutlet weak var leagueDetailsCollectionView: UICollectionView!
    
    var numberOfUpcoming = 0
    var numberOfLatest = 0
    var numberOfTeams = 0
    var eventsUrl = ""
    var teamsUrl = ""
    var sport = ""
    var upcomingEvents: [Events] = []
    var latestEvents: [Events] = []
    var teamsLogos: [String] = []
    var teamsKies: [Int] = []
    
    var leagueName = ""
    var leagueLogo = ""
    var leagueKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportViewModel = SportViewModel()

        leagueDetailsCollectionView.delegate = self
        leagueDetailsCollectionView.dataSource = self
        
        let nibCustomCell = UINib(nibName: "LeagueDetailsCollectionViewCell", bundle: nil)
        self.leagueDetailsCollectionView.register(nibCustomCell, forCellWithReuseIdentifier: "upcomingCell")
        self.leagueDetailsCollectionView.register(nibCustomCell, forCellWithReuseIdentifier: "latestCell")
        let noDataCustomCell = UINib(nibName: "NoDataCollectionViewCell", bundle: nil)
        self.leagueDetailsCollectionView.register(noDataCustomCell, forCellWithReuseIdentifier: "noData")
        
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
        sportViewModel?.getSportLeaguesDetailsFromNetworkService(url: eventsUrl+"&from=2024-05-29&to=2025-05-29")
        sportViewModel?.bindUpcomingToViewController = {
            self.numberOfUpcoming = self.sportViewModel?.leaguesUpcomingDetails?.result.count ?? 10
            for i in 0..<self.numberOfUpcoming {
                var upcomingEvent = Events()
                upcomingEvent.away_team_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].away_team_logo
                upcomingEvent.event_away_team = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_away_team
                upcomingEvent.event_date = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_date
                upcomingEvent.event_home_team = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_home_team
                upcomingEvent.event_time = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_time
                upcomingEvent.home_team_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].home_team_logo
                upcomingEvent.league_key = self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_key
                upcomingEvent.league_name = self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_name
                upcomingEvent.league_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].league_logo
                upcomingEvent.event_first_player_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_first_player_logo
                upcomingEvent.event_second_player_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_second_player_logo
                upcomingEvent.event_first_player = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_first_player
                upcomingEvent.event_second_player = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_second_player
                upcomingEvent.event_home_team_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_home_team_logo
                upcomingEvent.event_away_team_logo = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_away_team_logo
//                upcomingEvent.event_away_final_result = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_away_final_result
                upcomingEvent.event_date_start = self.sportViewModel?.leaguesUpcomingDetails?.result[i].event_date_start
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
                var latestEvent = Events()
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
                latestEvent.event_first_player_logo = self.sportViewModel?.leagueLatestDetails?.result[i].event_first_player_logo
                latestEvent.event_second_player_logo = self.sportViewModel?.leagueLatestDetails?.result[i].event_second_player_logo
                latestEvent.event_first_player = self.sportViewModel?.leagueLatestDetails?.result[i].event_first_player
                latestEvent.event_second_player = self.sportViewModel?.leagueLatestDetails?.result[i].event_second_player
                latestEvent.event_home_team_logo = self.sportViewModel?.leagueLatestDetails?.result[i].event_home_team_logo
                latestEvent.event_away_team_logo = self.sportViewModel?.leagueLatestDetails?.result[i].event_away_team_logo
                latestEvent.event_away_final_result = self.sportViewModel?.leagueLatestDetails?.result[i].event_away_final_result
                latestEvent.event_date_start = self.sportViewModel?.leagueLatestDetails?.result[i].event_date_start
                self.latestEvents.append(latestEvent)
                
            }
            print("self.latestEvents : \(self.latestEvents.count)")
            
            DispatchQueue.main.async {
                self.leagueDetailsCollectionView.reloadData()
            }
        }
        
        sportViewModel?.getTeamsLogosFromNetworkService(url: teamsUrl)
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
        if upcomingEvents.count > 0 {
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.6
                    let maxScale: CGFloat = 1
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }
        else{
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 1.2
                    let maxScale: CGFloat = 1.2
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
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
        if latestEvents.count == 0{
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 1.2
                    let maxScale: CGFloat = 1.2
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 32, trailing: 0)
        if teamsLogos.count > 0{
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.2
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }else{
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 2.5
                    let maxScale: CGFloat = 2.5
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
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
            }else if upcomingEvents.count == 0{
                return 1
            }else {
                return 10
            }
        }else if section==1{
            if 0 < latestEvents.count && latestEvents.count < 50 {
                return latestEvents.count
            }else if latestEvents.count == 0{
                return 2
            }else {
                return 10
            }
            
        }else{
            if teamsLogos.count > 0{
                return teamsLogos.count
            }else {
                return 2
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section==0 {
           
            
            if(upcomingEvents.count > 0){
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as? LeagueDetailsCollectionViewCell else { fatalError("Failed to dequeue NewsCell") }
                if let homeImageUrl = upcomingEvents[indexPath.row].home_team_logo,
                   let homeUrl = URL(string: homeImageUrl),
                   let awayImageUrl = upcomingEvents[indexPath.row].away_team_logo,
                   let awayUrl = URL(string: awayImageUrl) {
                    cell.homeImage.kf.setImage(with: homeUrl)
                    cell.awayImage.kf.setImage(with: awayUrl)
                } else {
                    cell.homeImage.image = imagePlaceHolder
                    cell.awayImage.image = imagePlaceHolder
                }
                cell.homeTeam.text = upcomingEvents[indexPath.row].event_home_team
                cell.awayTeam.text = upcomingEvents[indexPath.row].event_away_team
                cell.dateOfMatch.text = upcomingEvents[indexPath.row].event_date
                cell.timeOfMatch.text = upcomingEvents[indexPath.row].event_time
                return cell

            }else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noData", for: indexPath) as? NoDataCollectionViewCell else { fatalError("Failed to dequeue LatestCell") }
//                if indexPath.row == 0 {
//                    cell.noDataImage.image = UIImage(named: "")
//                }
                return cell
            }
            
        }else if indexPath.section==1 {
           
           
            print(" section1 latestEvents.count  ::  \(latestEvents.count)")
            if(latestEvents.count > 0){
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath) as? LeagueDetailsCollectionViewCell else { fatalError("Failed to dequeue Cell") }
                
                setCellDetails(sport: sport, indexPath: indexPath.row)
                if let homeImageUrl = homeImageUrl,
                   let homeUrl = URL(string: homeImageUrl),
                   let awayImageUrl = awayImageUrl,
                   let awayUrl = URL(string: awayImageUrl) {
                    cell.homeImage.kf.setImage(with: homeUrl)
                    cell.awayImage.kf.setImage(with: awayUrl)
                } else {
                    cell.homeImage.image = imagePlaceHolder
                    cell.awayImage.image = imagePlaceHolder
                }
                cell.homeTeam.text = homeTeamName
                print(" latestEvents[\(indexPath.row)].event_home_team  ::  \(latestEvents[indexPath.row].event_home_team ?? "-1")")
                cell.awayTeam.text = awayTeamName
                cell.dateOfMatch.text = dateOfMatch
                cell.timeOfMatch.text = latestEvents[indexPath.row].event_time
                cell.scoreOfLiveMatch.text = scoreOfLiveMatch
                return cell

            }else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noData", for: indexPath) as? NoDataCollectionViewCell else { fatalError("Failed to dequeue LatestCell") }
                if indexPath.row == 0 {
                    cell.noDataImage.image = UIImage(named: "")
                }
                return cell
            }
        }else{
        
            if(teamsLogos.count > 0){
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? LogoCollectionViewCell else { fatalError("Failed to dequeue LatestCell") }
                if !teamsLogos[indexPath.row].isEmpty {
                   let teamUrl = URL(string: teamsLogos[indexPath.row])
                    cell.logoOfTeam?.kf.setImage(with: teamUrl)
                } else {
                    cell.logoOfTeam.image = imagePlaceHolder
                }
                return cell
            }else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noData", for: indexPath) as? NoDataCollectionViewCell else { fatalError("Failed to dequeue LatestCell") }
                if indexPath.row == 0 {
                    cell.noDataImage.image = UIImage(named: "")
                }
                return cell
            }
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 && teamsLogos.count != 0{
            let storyboard = UIStoryboard(name: "Details", bundle: nil)
            if let teamDetailsController = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController{
                teamDetailsController.teamDetailsUrl = sportViewModel?.getTeamsDetailsFormatedUrl(sport: sport, met: "Teams", teamId: "\(teamsKies[indexPath.row])") ?? ""
                
                teamDetailsController.sport = sport
                present(teamDetailsController, animated: true, completion: nil)
            }
        }
    }
    
    func setCellDetails(sport: String, indexPath: Int){
        switch sport {
            case "football":
            homeImageUrl = latestEvents[indexPath].home_team_logo ?? ""
            awayImageUrl = latestEvents[indexPath].away_team_logo ?? ""
            homeTeamName = latestEvents[indexPath].event_home_team ?? ""
            awayTeamName = latestEvents[indexPath].event_away_team ?? ""
            dateOfMatch = latestEvents[indexPath].event_date ?? ""
            scoreOfLiveMatch = latestEvents[indexPath].event_final_result ?? ""
            imagePlaceHolder = UIImage(named: "footballlogo")
           
            case "basketball":
            homeImageUrl = latestEvents[indexPath].event_home_team_logo ?? ""
            awayImageUrl = latestEvents[indexPath].event_away_team_logo ?? ""
            homeTeamName = latestEvents[indexPath].event_home_team ?? ""
            awayTeamName = latestEvents[indexPath].event_away_team ?? ""
            dateOfMatch = latestEvents[indexPath].event_date ?? ""
            scoreOfLiveMatch = latestEvents[indexPath].event_final_result ?? ""
            imagePlaceHolder = UIImage(named: "basketballlogo")

            
            case "cricket":
            homeImageUrl = latestEvents[indexPath].event_home_team_logo ?? ""
            awayImageUrl = latestEvents[indexPath].event_away_team_logo ?? ""
            homeTeamName = latestEvents[indexPath].event_home_team ?? ""
            awayTeamName = latestEvents[indexPath].event_away_team ?? ""
            dateOfMatch = latestEvents[indexPath].event_date_start ?? ""
            scoreOfLiveMatch = latestEvents[indexPath].event_away_final_result ?? ""
            imagePlaceHolder = UIImage(named: "cricketlogo")

            
            case "tennis":
            homeImageUrl = latestEvents[indexPath].event_first_player_logo ?? ""
            awayImageUrl = latestEvents[indexPath].event_second_player_logo ?? ""
            homeTeamName = latestEvents[indexPath].event_first_player ?? ""
            awayTeamName = latestEvents[indexPath].event_second_player ?? ""
            dateOfMatch = latestEvents[indexPath].event_date ?? ""
            scoreOfLiveMatch = latestEvents[indexPath].event_final_result ?? ""
            imagePlaceHolder = UIImage(named: "tennislogo")

            
            default:
                break
        }
    }
    
  
    
    
    @IBAction func btnFav(_ sender: Any) {
                

        let leagueKey = self.leagueKey
        let leagueName = self.leagueName
        let leagueLogo = self.leagueLogo

        let sportName = sport
                
        if !sportViewModel.isLeagueInFavorites(leagueKey: leagueKey) {
            sportViewModel.insertFavoriteLeague(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
            print("League added to favorites!, leagueKey: \(leagueKey) \n ,leagueName: \(leagueName), leagueLogo: \(leagueLogo)")
            isFavorited = true
            favBtn.image = UIImage(systemName: "heart.fill")
        } else {
            sportViewModel.deleteFavoriteLeague(leagueKey: leagueKey)
            print("League removed from favorites!")
            isFavorited = false
            favBtn.image = UIImage(systemName: "heart")
        }
    }
    
    func updateFavButtonImage() {
        if sportViewModel.isLeagueInFavorites(leagueKey: self.leagueKey) {
            isFavorited = true
            favBtn.image = UIImage(systemName: "heart.fill")
            print("is favorite ,leagueKey: \(self.leagueKey)")
        } else {
            isFavorited = false
            favBtn.image = UIImage(systemName: "heart")
            print("not favorite ,leagueKey: \(self.leagueKey)")

        }
    }
    
}


struct Events{
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
    
    //tennis
    var event_first_player: String?
    var event_second_player: String?
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    
    //basketBall
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    
    //cricket
    var event_date_start: String?
    var event_away_final_result: String?
}


