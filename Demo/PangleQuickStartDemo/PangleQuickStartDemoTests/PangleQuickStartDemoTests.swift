//
//  PangleQuickStartDemoTests.swift
//  PangleQuickStartDemoTests
//
//  Created by Chan Gu on 2020/10/07.
//

import Foundation
import XCTest
@testable import PangleQuickStartDemo

class PangleQuickStartDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testSKAdNetworkItemsHaveIdentifiers() throws {
        let testBundleURL = Bundle(for: PangleQuickStartDemoTests.self).bundleURL
        let appBundleURL = testBundleURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let appBundle = try XCTUnwrap(Bundle(url: appBundleURL))
        let items = try XCTUnwrap(
            appBundle.object(forInfoDictionaryKey: "SKAdNetworkItems") as? [[String: Any]]
        )

        XCTAssertFalse(items.isEmpty)
        for item in items {
            let identifier = try XCTUnwrap(item["SKAdNetworkIdentifier"] as? String)
            XCTAssertFalse(identifier.isEmpty)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
