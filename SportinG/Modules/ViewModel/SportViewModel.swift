//
//  SportViewModel.swift
//  SportinG
//
//  Created by Rawan Elsayed on 24/05/2024.
//

import Foundation


class SportViewModel: SportViewModelProtocol{
    
    
    
    var bindUpcomingToViewController : (()->())? = {}
    var bindLatestToViewController : (()->())? = {}
    var bindLogosToViewController : (()->())? = {}
    var fetchDataFromApi = FetchDataFromApi()
    var leaguesUpcomingDetails: SportDetails? {
        didSet{
                (bindUpcomingToViewController ?? {})()
        }
    }
    
    var leagueLatestDetails: SportDetails? {
        didSet{
                (bindLatestToViewController ?? {})()
        }
    }
    
    var leagueTeamsLogos: SportDetails? {
        didSet{
                (bindLogosToViewController ?? {})()
        }
    }
  
    
    func setSportUrl(selectedSport: Int) -> (String, String){
        var url = ""
        var sport = ""
        switch selectedSport {
            case 0:
            url = fetchDataFromApi.formatURL(sport: "football", met: "Leagues")
                sport = "football"
            case 1:
            url = fetchDataFromApi.formatURL(sport: "basketball", met: "Leagues")
                sport = "basketball"
            case 2:
            url = fetchDataFromApi.formatURL(sport: "cricket", met: "Leagues")
                sport = "cricket"
            case 3:
            url = fetchDataFromApi.formatURL(sport: "tennis", met: "Leagues")
                sport = "tennis"
            default:
                url = ""
                sport = ""
                break
        }
        return (url,sport)
    }
    
    func getSportLeaguesFromNetworkService(url: String) {
        fetchDataFromApi.getSportData(url: url) { sportDetails in
            self.leaguesUpcomingDetails = sportDetails
        }
    }
    
    func getLeaguesFormatedUrl(sport: String, met:String, leaguesKies: [Int], index: Int) -> String{
        return fetchDataFromApi.formatURL(sport: sport, met: met,leagueId:"\(leaguesKies[index])")
    }
    
    
    func getTeamsDetailsFormatedUrl(sport: String, met: String, teamId: String) -> String{
        return fetchDataFromApi.formatURL(sport: sport, met: met,teamId: teamId)
    }
    

    
    
    func getLeagueDetailsFromNetworkService(url: String) {
        fetchDataFromApi.getSportData (url: url){ sportDetails in
            self.leaguesUpcomingDetails = sportDetails
        }
    }
    
    func getLatestDetailsFromNetworkService(url: String) {
        fetchDataFromApi.getSportData (url: url){ sportDetails in
            self.leagueLatestDetails = sportDetails
        }
    }
    
    func getTeamsDetailsFromNetworkService(url: String) {
        fetchDataFromApi.getSportData (url: url){ sportDetails in
            self.leagueTeamsLogos = sportDetails
        }
    }
    
    
    
    
}
