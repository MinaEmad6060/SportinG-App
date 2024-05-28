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
    var league_name: String?
    var league_key: Int?
    var league_logo: String?
    var event_date: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var home_team_logo: String?
    var away_team_logo: String?
    var team_logo: String?
    var team_key: Int?
    var event_final_result: String?
    var team_name: String?
    var players: [Player]?
    var coaches: [Coach]?
    
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


struct Player: Decodable{
    var player_image: String?
    var player_name: String?
}

struct Coach: Decodable{
    var coach_name: String?
}
