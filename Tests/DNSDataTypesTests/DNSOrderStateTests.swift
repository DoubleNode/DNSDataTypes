//
//  DNSOrderStateTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSOrderStateTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSOrderState] = [
            .cancelled, .completed, .created, .fraudulent, 
            .pending, .processing, .refunded, .unknown
        ]
        XCTAssertEqual(DNSOrderState.allCases.count, 8)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSOrderState.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSOrderState.cancelled.rawValue, "cancelled")
        XCTAssertEqual(DNSOrderState.completed.rawValue, "completed")
        XCTAssertEqual(DNSOrderState.created.rawValue, "created")
        XCTAssertEqual(DNSOrderState.fraudulent.rawValue, "fraudulent")
        XCTAssertEqual(DNSOrderState.pending.rawValue, "pending")
        XCTAssertEqual(DNSOrderState.processing.rawValue, "processing")
        XCTAssertEqual(DNSOrderState.refunded.rawValue, "refunded")
        XCTAssertEqual(DNSOrderState.unknown.rawValue, "unknown")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSOrderState(rawValue: "cancelled"), .cancelled)
        XCTAssertEqual(DNSOrderState(rawValue: "completed"), .completed)
        XCTAssertEqual(DNSOrderState(rawValue: "created"), .created)
        XCTAssertEqual(DNSOrderState(rawValue: "fraudulent"), .fraudulent)
        XCTAssertEqual(DNSOrderState(rawValue: "pending"), .pending)
        XCTAssertEqual(DNSOrderState(rawValue: "processing"), .processing)
        XCTAssertEqual(DNSOrderState(rawValue: "refunded"), .refunded)
        XCTAssertEqual(DNSOrderState(rawValue: "unknown"), .unknown)
        XCTAssertNil(DNSOrderState(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for state in DNSOrderState.allCases {
            let encoded = try encoder.encode(state)
            let decoded = try decoder.decode(DNSOrderState.self, from: encoded)
            XCTAssertEqual(decoded, state)
        }
    }
    
    func testBusinessLogic() throws {
        // Test order state business logic
        XCTAssertNotEqual(DNSOrderState.created, DNSOrderState.pending)
        XCTAssertNotEqual(DNSOrderState.pending, DNSOrderState.processing)
        XCTAssertNotEqual(DNSOrderState.processing, DNSOrderState.completed)
        
        // Test negative states
        XCTAssertNotEqual(DNSOrderState.cancelled, DNSOrderState.completed)
        XCTAssertNotEqual(DNSOrderState.fraudulent, DNSOrderState.completed)
        XCTAssertNotEqual(DNSOrderState.refunded, DNSOrderState.completed)
    }
    
    func testDefaultState() throws {
        // Verify unknown is a valid default state
        let defaultState = DNSOrderState.unknown
        XCTAssertEqual(defaultState.rawValue, "unknown")
    }
}