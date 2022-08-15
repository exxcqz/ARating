//
//  ARatingTests.swift
//  ARatingTests
//
//  Created by Никита Гавриков on 15.08.2022.
//

import XCTest
@testable import ARating

class ARatingTests: XCTestCase {

    var databaseService: DatabaseService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        databaseService = DatabaseServiceImp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        databaseService = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let countObjects = databaseService.getAllObjects().count
        XCTAssert(countObjects > 0, "Objects more than 10")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure(
            metrics: [XCTClockMetric(),
                      XCTCPUMetric(),
                      XCTStorageMetric(),
                      XCTMemoryMetric()]
        ) {
            databaseService.getAllObjects()
        }
    }
}
