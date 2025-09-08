//
//  DNSSystemStateTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSSystemStateTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSSystemState] = [.none, .black, .green, .grey, .orange, .red, .yellow]
        XCTAssertEqual(DNSSystemState.allCases.count, 7)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSSystemState.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSSystemState.none.rawValue, "none")
        XCTAssertEqual(DNSSystemState.black.rawValue, "black")
        XCTAssertEqual(DNSSystemState.green.rawValue, "green")
        XCTAssertEqual(DNSSystemState.grey.rawValue, "grey")
        XCTAssertEqual(DNSSystemState.orange.rawValue, "orange")
        XCTAssertEqual(DNSSystemState.red.rawValue, "red")
        XCTAssertEqual(DNSSystemState.yellow.rawValue, "yellow")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSSystemState(rawValue: "none")!, .none)
        XCTAssertEqual(DNSSystemState(rawValue: "black")!, .black)
        XCTAssertEqual(DNSSystemState(rawValue: "green")!, .green)
        XCTAssertEqual(DNSSystemState(rawValue: "grey")!, .grey)
        XCTAssertEqual(DNSSystemState(rawValue: "orange")!, .orange)
        XCTAssertEqual(DNSSystemState(rawValue: "red")!, .red)
        XCTAssertEqual(DNSSystemState(rawValue: "yellow")!, .yellow)
        XCTAssertNil(DNSSystemState(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for state in DNSSystemState.allCases {
            let encoded = try encoder.encode(state)
            let decoded = try decoder.decode(DNSSystemState.self, from: encoded)
            XCTAssertEqual(decoded, state)
        }
    }
    
    func testSystemStateLogic() throws {
        // Test system state business logic
        XCTAssertNotEqual(DNSSystemState.green, DNSSystemState.red)
        XCTAssertNotEqual(DNSSystemState.green, DNSSystemState.yellow)
        XCTAssertNotEqual(DNSSystemState.red, DNSSystemState.orange)
    }
    
    func testDefaultState() throws {
        // Verify none is a valid default state
        let defaultState = DNSSystemState.none
        XCTAssertEqual(defaultState.rawValue, "none")
    }
    
    func testOperationalStates() throws {
        // Test positive system states
        let positiveStates: [DNSSystemState] = [.green]
        for state in positiveStates {
            XCTAssertTrue(DNSSystemState.allCases.contains(state))
        }
        
        // Test warning/alert states
        let warningStates: [DNSSystemState] = [.yellow, .orange, .red]
        for state in warningStates {
            XCTAssertTrue(DNSSystemState.allCases.contains(state))
        }
        
        // Test neutral/other states
        let neutralStates: [DNSSystemState] = [.grey, .black]
        for state in neutralStates {
            XCTAssertTrue(DNSSystemState.allCases.contains(state))
        }
    }
}
