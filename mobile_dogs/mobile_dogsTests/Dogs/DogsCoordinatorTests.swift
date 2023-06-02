//
//  DogsCoordinatorTests.swift
//  mobile_dogsTests
//
//  Created by Sebastian Bonilla on 1/06/23.
//

@testable import mobile_dogs
import XCTest

final class DogsCoordinatorTests: XCTestCase {
    
    var testCoordinator: DogsCoordinator!
    var presenter: UINavigationController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = UINavigationController()
        testCoordinator = DogsCoordinator(presenter: presenter)
    }

    override func tearDownWithError() throws {
        presenter = nil
        testCoordinator = nil
    }

    func testNavigate() throws {
        testCoordinator.navigate()
        
        XCTAssertTrue(presenter.topViewController?.isKind(of: DogsViewController.self) ?? false)
    }
}
