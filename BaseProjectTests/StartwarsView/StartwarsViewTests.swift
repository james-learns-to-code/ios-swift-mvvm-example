//
//  StartwarsViewTests.swift
//  BaseProjectTests
//
//  Created by leedongseok on 17/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import XCTest 
import Quick
import Nimble
@testable import BaseProject

// MARK: Manual test
class StartwarsViewTests: QuickSpec {
    
    override func spec() {

        // Setup
        let film = StarwarsFilmModel(title: "Title", episode_id: 1, director: "Director")
        let expectedTitle = "1 Title - Director"
        let emptyFilm = StarwarsFilmModel(title: nil, episode_id: nil, director: nil)
        let expectedEmptyTitle = "0  - "

        // Startwars View Cell in tableView Have to be show film info properly
        describe("Startwars View") {
            context("Cell in tableView") {
                it("Have to be show film info properly") {
                    let title = StarwarsFilmCellViewModel.getTitle(from: film)
                    expect(title).to(equal(expectedTitle))
                    let emptyTitle = StarwarsFilmCellViewModel.getTitle(from: emptyFilm)
                    expect(emptyTitle).to(equal(expectedEmptyTitle))
                }
            }
        }
    }
}

