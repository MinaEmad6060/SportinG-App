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
    var apiKey = "22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
    
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
