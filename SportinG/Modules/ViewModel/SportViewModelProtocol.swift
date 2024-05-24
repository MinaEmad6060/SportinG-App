//
//  SportViewModelProtocol.swift
//  SportinG
//
//  Created by Rawan Elsayed on 24/05/2024.
//

import Foundation

protocol SportViewModelProtocol{
    var bindResultToViewController: (() -> ())? { get set }
    var sportDetails: SportDetails? { get set }
    func setSportUrl(selectedSport: Int) -> (String, String)
    func getSportLeaguesFromNetworkService(url: String)
    func getDataFromNetworkService()
}
