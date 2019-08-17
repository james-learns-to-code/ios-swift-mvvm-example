//
//  NetworkResponseTests.swift
//  BaseProjectTests
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import BaseProject

// MARK: Manual test
class NetworkResponseTests: QuickSpec {
 
    override func spec() {
        
        // Setup
        let timeout = TimeInterval(5)

        // Network response have to be called-back in time
        describe("Network request") {
            context("Starwars api list") {
                it("Have to be called-back in time") {
                    waitUntil(timeout: timeout) { done in
                        StarwarsNetworkManager.shared.requestFilmList { result in
                            guard case .success = result else { fail(); return }
                            done()
                        }
                    }
                }
            }
        }
    }
}
