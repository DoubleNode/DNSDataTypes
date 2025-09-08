//
//  DNSAppActionTypeTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSAppActionTypeTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSAppActionType] = [.drawer, .fullScreen, .popup, .stage]
        XCTAssertEqual(DNSAppActionType.allCases.count, 4)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSAppActionType.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSAppActionType.drawer.rawValue, "drawer")
        XCTAssertEqual(DNSAppActionType.fullScreen.rawValue, "fullScreen")
        XCTAssertEqual(DNSAppActionType.popup.rawValue, "popup")
        XCTAssertEqual(DNSAppActionType.stage.rawValue, "stage")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSAppActionType(rawValue: "drawer"), .drawer)
        XCTAssertEqual(DNSAppActionType(rawValue: "fullScreen"), .fullScreen)
        XCTAssertEqual(DNSAppActionType(rawValue: "popup"), .popup)
        XCTAssertEqual(DNSAppActionType(rawValue: "stage"), .stage)
        XCTAssertNil(DNSAppActionType(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for actionType in DNSAppActionType.allCases {
            let encoded = try encoder.encode(actionType)
            let decoded = try decoder.decode(DNSAppActionType.self, from: encoded)
            XCTAssertEqual(decoded, actionType)
        }
    }
    
    func testStringInterpolation() throws {
        XCTAssertEqual("\(DNSAppActionType.drawer)", "drawer")
        XCTAssertEqual("\(DNSAppActionType.fullScreen)", "fullScreen")
    }
}