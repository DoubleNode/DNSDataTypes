//
//  DNSBeaconDistanceTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSBeaconDistanceTests: XCTestCase {
    
    func testAllCases() throws {
        // Verify all beacon distance cases are present
        let expectedCases: [DNSBeaconDistance] = [.unknown, .distant, .far, .nearby, .close, .immediate]
        XCTAssertEqual(DNSBeaconDistance.allCases.count, 6)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSBeaconDistance.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSBeaconDistance.unknown.rawValue, "unknown")
        XCTAssertEqual(DNSBeaconDistance.distant.rawValue, "distant")
        XCTAssertEqual(DNSBeaconDistance.far.rawValue, "far")
        XCTAssertEqual(DNSBeaconDistance.nearby.rawValue, "nearby")
        XCTAssertEqual(DNSBeaconDistance.close.rawValue, "close")
        XCTAssertEqual(DNSBeaconDistance.immediate.rawValue, "immediate")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSBeaconDistance(rawValue: "unknown"), .unknown)
        XCTAssertEqual(DNSBeaconDistance(rawValue: "distant"), .distant)
        XCTAssertEqual(DNSBeaconDistance(rawValue: "far"), .far)
        XCTAssertEqual(DNSBeaconDistance(rawValue: "nearby"), .nearby)
        XCTAssertEqual(DNSBeaconDistance(rawValue: "close"), .close)
        XCTAssertEqual(DNSBeaconDistance(rawValue: "immediate"), .immediate)
        XCTAssertNil(DNSBeaconDistance(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for distance in DNSBeaconDistance.allCases {
            let encoded = try encoder.encode(distance)
            let decoded = try decoder.decode(DNSBeaconDistance.self, from: encoded)
            XCTAssertEqual(decoded, distance)
        }
    }
    
    func testDistanceOrdering() throws {
        // Test logical ordering of beacon distances
        XCTAssertNotEqual(DNSBeaconDistance.immediate, DNSBeaconDistance.nearby)
        XCTAssertNotEqual(DNSBeaconDistance.nearby, DNSBeaconDistance.far)
        XCTAssertNotEqual(DNSBeaconDistance.far, DNSBeaconDistance.unknown)
    }
}
