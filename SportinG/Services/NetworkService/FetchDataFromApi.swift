//
//  FetchDataFromApi.swift
//  SportinG
//
//  Created by Mina Emad on 20/05/2024.
//

import Foundation
import Alamofire


class FetchDataFromApi{
    
    var baseUrl = "https://apiv2.allsportsapi.com/"
    var apiKey = "b4435c0f017e71bd88b547e061b461b91190479b464b4de3792ad0ac4cf547ad"
    
    func formatURL(sport: String, met: String, teamId: String="", leagueId: String="") -> String{
        return baseUrl+sport+"/?met="+met+"&APIkey="+apiKey+"&leagueId="+leagueId+"&teamId="+teamId
    }
    
    
    func getSportData(url: String, handler: @escaping (SportDetails)->Void){
        let urlFB = URL(string: url)
        guard let urlFB = urlFB else{return}
        
     
        AF.request(urlFB).responseDecodable(of: SportDetails.self) { response in
            switch response.result {
            case .success(let upcomingMatches):
                handler(upcomingMatches)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
