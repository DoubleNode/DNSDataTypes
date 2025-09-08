//
//  DNSNotificationTypeTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSNotificationTypeTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSNotificationType] = [.unknown, .alert, .deepLink, .deepLinkAuto]
        XCTAssertEqual(DNSNotificationType.allCases.count, 4)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSNotificationType.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSNotificationType.unknown.rawValue, "unknown")
        XCTAssertEqual(DNSNotificationType.alert.rawValue, "alert")
        XCTAssertEqual(DNSNotificationType.deepLink.rawValue, "deepLink")
        XCTAssertEqual(DNSNotificationType.deepLinkAuto.rawValue, "deepLinkAuto")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSNotificationType(rawValue: "unknown"), .unknown)
        XCTAssertEqual(DNSNotificationType(rawValue: "alert"), .alert)
        XCTAssertEqual(DNSNotificationType(rawValue: "deepLink"), .deepLink)
        XCTAssertEqual(DNSNotificationType(rawValue: "deepLinkAuto"), .deepLinkAuto)
        XCTAssertNil(DNSNotificationType(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for notificationType in DNSNotificationType.allCases {
            let encoded = try encoder.encode(notificationType)
            let decoded = try decoder.decode(DNSNotificationType.self, from: encoded)
            XCTAssertEqual(decoded, notificationType)
        }
    }
    
    func testNotificationTypeClassification() throws {
        // Test alert notification type
        XCTAssertTrue(DNSNotificationType.allCases.contains(.alert))
        
        // Test deep link types
        let deepLinkTypes: [DNSNotificationType] = [.deepLink, .deepLinkAuto]
        for type in deepLinkTypes {
            XCTAssertTrue(DNSNotificationType.allCases.contains(type))
        }
        
        // Test fallback type
        XCTAssertTrue(DNSNotificationType.allCases.contains(.unknown))
    }
    
    func testDistinctTypes() throws {
        // Test that all notification types are distinct
        XCTAssertNotEqual(DNSNotificationType.unknown, DNSNotificationType.alert)
        XCTAssertNotEqual(DNSNotificationType.alert, DNSNotificationType.deepLink)
        XCTAssertNotEqual(DNSNotificationType.deepLink, DNSNotificationType.deepLinkAuto)
    }
}