//
//  File.swift
//  SportinG
//
//  Created by Mina Emad on 21/05/2024.
//

import Foundation


class Utils{
    enum Urls: String{
        case FootBall_All_Leagues = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case FootBall_Upcoming_Events = "https://apiv2.allsportsapi.com/football?met=Fixtures&from=2024-06-20&to=2024-06-20&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case FootBall_LiveScore_Events = "https://apiv2.allsportsapi.com/football/?met=Livescore&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case FootBall_League_Teams = "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=152"
        
//        case FootBall_All_Leagues = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
//        
//        case FootBall_Upcoming_Events = "https://apiv2.allsportsapi.com/football?met=Fixtures&from=2024-06-20&to=2024-06-20&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
//        
//        case FootBall_LiveScore_Events = "https://apiv2.allsportsapi.com/football/?met=Livescore&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
//        
//        case FootBall_League_Teams = "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=152"
        
        
        
        
        //rawan
        //basketball
        case BasketBall_All_Leagues = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case BasketBall_Upcoming_Events = "https://apiv2.allsportsapi.com/basketball?met=Fixtures&from=2024-06-20&to=2024-06-20&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case BasketBall_LiveScore_Events = "https://apiv2.allsportsapi.com/basketball/?met=Livescore&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case BasketBall_League_Teams = "https://apiv2.allsportsapi.com/basketball/?met=Teams&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=152"
        
        
                
        //crecket
        case Cricket_All_Leagues = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case Cricket_Upcoming_Events = "https://apiv2.allsportsapi.com/cricket?met=Fixtures&from=2024-06-20&to=2024-06-20&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case Cricket_LiveScore_Events = "https://apiv2.allsportsapi.com/cricket/?met=Livescore&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case Cricket_League_Teams = "https://apiv2.allsportsapi.com/cricket/?met=Teams&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=152"
        
        //tennis
        case Tennis_All_Leagues = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case Tennis_Upcoming_Events = "https://apiv2.allsportsapi.com/tennis?met=Fixtures&from=2024-06-20&to=2024-06-20&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case Tennis_LiveScore_Events = "https://apiv2.allsportsapi.com/tennis/?met=Livescore&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        case Tennis_League_Teams = "https://apiv2.allsportsapi.com/tennis/?met=Teams&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=152"
    }
    
    
    
}
