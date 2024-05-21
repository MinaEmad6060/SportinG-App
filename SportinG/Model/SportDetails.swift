//
//  SportDetails.swift
//  SportinG
//
//  Created by Mina Emad on 20/05/2024.
//

import Foundation


struct SportDetails: Decodable{
    var result: [Result] = [Result]()
}


struct Result: Decodable{
    var event_date: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var home_team_logo: String?
    var away_team_logo: String?
    var team_logo: String?
    var event_final_result: String?
}
