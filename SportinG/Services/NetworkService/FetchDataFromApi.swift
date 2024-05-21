//
//  FetchDataFromApi.swift
//  SportinG
//
//  Created by Mina Emad on 20/05/2024.
//

import Foundation
import Alamofire


class FetchDataFromApi{
    func getFootBallData(url: String, handler: @escaping (SportDetails)->Void){
        let urlFB = URL(string: url)
        print("Loading")
        guard let urlFB = urlFB else{return}
        
        print("getFB")
     
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
