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
    
    private struct URL {
        static let base = "https://swapi.co/api/"
        static let filmPath = "films/"
        static let film = base + filmPath
    }
}

// MARK: API
extension StarwarsNetworkManager {
    func requestFilmList(
        handler: @escaping (Result<StarwarsFilmsModel, NetworkError>) -> Void) {
        request(
            with: StarwarsNetworkManager.URL.film,
            type: .get
        ) { result in
            Decoder<StarwarsFilmsModel>
                .decodeResult(result, handler: handler)
        }
    }
}
