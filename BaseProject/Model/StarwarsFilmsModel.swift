//
//  StarwarsFilmsModel.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

struct StarwarsFilmsModel: Codable {
    let results: [StarwarsFilmModel]?
}

struct StarwarsFilmModel: Codable {
    let title: String?
    let episode_id: Int?
    let director: String?
}
