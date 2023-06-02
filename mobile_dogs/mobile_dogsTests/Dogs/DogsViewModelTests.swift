//
//  DogsViewModelTests.swift
//  mobile_dogsTests
//
//  Created by Sebastian Bonilla on 1/06/23.
//

@testable import mobile_dogs
import XCTest

final class DogsViewModelTests: XCTestCase {
    
    var testViewModel: DogsViewModel!

    override func setUpWithError() throws {
        testViewModel = DogsViewModel()
    }

    override func tearDownWithError() throws {
        testViewModel = nil
    }

    func testInit() throws {
        XCTAssertEqual(testViewModel.title, "Dog breeds")
    }
}
