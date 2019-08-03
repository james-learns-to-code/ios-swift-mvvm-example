//
//  StarwarsNetworkManager.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

typealias API = StarwarsNetworkManager

final class StarwarsNetworkManager: NetworkManager {
    static let shared = StarwarsNetworkManager()
    
    struct URL {
        static let base = "https://swapi.co/api/"
        static let filmPath = "films/"
        static let film = base + filmPath
    }
}

// MARK: Interface
extension StarwarsNetworkManager {
    typealias FilmListResultHandler = (Result<StarwarsFilmsModel, NetworkError>) -> Void

    func requestFilmList(
        handler: @escaping FilmListResultHandler) {
        request(
            with: StarwarsNetworkManager.URL.film,
            type: .get) { result in
                ResponseType<StarwarsFilmsModel>
                    .decodeResult(result, handler: handler)
        }
    }
}
