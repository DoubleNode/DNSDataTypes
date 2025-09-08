//
//  DNSAnalyticsNumbersTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSAnalyticsNumbersTests: XCTestCase {
    
    func testDefaultInitialization() throws {
        let analytics = DNSAnalyticsNumbers()
        
        XCTAssertEqual(analytics.android, 0.0, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 0.0, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 0.0, accuracy: 0.001)
    }
    
    func testParameterizedInitialization() throws {
        let analytics = DNSAnalyticsNumbers(android: 1000.5, iOS: 2500.75, total: 3501.25)
        
        XCTAssertEqual(analytics.android, 1000.5, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 2500.75, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 3501.25, accuracy: 0.001)
    }
    
    func testCopyInitialization() throws {
        let original = DNSAnalyticsNumbers(android: 750.0, iOS: 1250.0, total: 2000.0)
        let copy = DNSAnalyticsNumbers(from: original)
        
        XCTAssertEqual(copy.android, original.android, accuracy: 0.001)
        XCTAssertEqual(copy.iOS, original.iOS, accuracy: 0.001)
        XCTAssertEqual(copy.total, original.total, accuracy: 0.001)
        
        // Ensure they are different instances
        XCTAssertTrue(copy !== original)
    }
    
    func testUpdateMethod() throws {
        let analytics1 = DNSAnalyticsNumbers(android: 100.0, iOS: 200.0, total: 300.0)
        let analytics2 = DNSAnalyticsNumbers()
        
        analytics2.update(from: analytics1)
        
        XCTAssertEqual(analytics2.android, 100.0, accuracy: 0.001)
        XCTAssertEqual(analytics2.iOS, 200.0, accuracy: 0.001)
        XCTAssertEqual(analytics2.total, 300.0, accuracy: 0.001)
    }
    
    func testDAOInitFromDictionary() throws {
        let data: DNSDataDictionary = [
            "android": 500.5,
            "iOS": 1000.25,
            "total": 1500.75
        ]
        
        let analytics = DNSAnalyticsNumbers(from: data)
        
        XCTAssertEqual(analytics.android, 500.5, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 1000.25, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 1500.75, accuracy: 0.001)
    }
    
    func testDAOFromMethod() throws {
        let analytics = DNSAnalyticsNumbers()
        let data: DNSDataDictionary = [
            "android": 300.0,
            "iOS": 700.0,
            "total": 1000.0
        ]
        
        let result = analytics.dao(from: data)
        
        // Should return self and modify the instance
        XCTAssertTrue(result === analytics)
        XCTAssertEqual(analytics.android, 300.0, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 700.0, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 1000.0, accuracy: 0.001)
    }
    
    func testAsDictionary() throws {
        let analytics = DNSAnalyticsNumbers(android: 750.25, iOS: 1250.75, total: 2001.0)
        
        let dictionary = analytics.asDictionary
        
        XCTAssertEqual(dictionary["android"] as? Double ?? Double(0), 750.25, accuracy: 0.001)
        XCTAssertEqual(dictionary["iOS"] as? Double ?? Double(0), 1250.75, accuracy: 0.001)
        XCTAssertEqual(dictionary["total"] as? Double ?? Double(0), 2001.0, accuracy: 0.001)
    }
    
    func testCodableConformance() throws {
        let analytics = DNSAnalyticsNumbers(android: 1500.25, iOS: 2750.5, total: 4250.75)
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(analytics)
        let decoded = try decoder.decode(DNSAnalyticsNumbers.self, from: encoded)
        
        XCTAssertEqual(decoded.android, analytics.android, accuracy: 0.001)
        XCTAssertEqual(decoded.iOS, analytics.iOS, accuracy: 0.001)
        XCTAssertEqual(decoded.total, analytics.total, accuracy: 0.001)
    }
    
    func testJSONDecodingWithMissingFields() throws {
        let json = """
        {
            "android": 500.0
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let analytics = try decoder.decode(DNSAnalyticsNumbers.self, from: json)
        
        XCTAssertEqual(analytics.android, 500.0, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 0.0, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 0.0, accuracy: 0.001)
    }
    
    func testNSCopyingConformance() throws {
        let analytics = DNSAnalyticsNumbers(android: 1000.0, iOS: 2000.0, total: 3000.0)
        
        let copy = analytics.copy() as! DNSAnalyticsNumbers
        
        XCTAssertEqual(copy.android, analytics.android, accuracy: 0.001)
        XCTAssertEqual(copy.iOS, analytics.iOS, accuracy: 0.001)
        XCTAssertEqual(copy.total, analytics.total, accuracy: 0.001)
        
        // Ensure they are different instances
        XCTAssertTrue(copy !== analytics)
    }
    
    func testEquatableProtocol() throws {
        let analytics1 = DNSAnalyticsNumbers(android: 100.0, iOS: 200.0, total: 300.0)
        let analytics2 = DNSAnalyticsNumbers(android: 100.0, iOS: 200.0, total: 300.0)
        let analytics3 = DNSAnalyticsNumbers(android: 101.0, iOS: 200.0, total: 300.0)
        
        XCTAssertTrue(analytics1 == analytics2)
        XCTAssertFalse(analytics1 == analytics3)
        XCTAssertFalse(analytics1 != analytics2)
        XCTAssertTrue(analytics1 != analytics3)
    }
    
    func testIsDiffFromMethod() throws {
        let analytics1 = DNSAnalyticsNumbers(android: 100.0, iOS: 200.0, total: 300.0)
        let analytics2 = DNSAnalyticsNumbers(android: 100.0, iOS: 200.0, total: 300.0)
        let analytics3 = DNSAnalyticsNumbers(android: 101.0, iOS: 200.0, total: 300.0)
        
        XCTAssertFalse(analytics1.isDiffFrom(analytics2))
        XCTAssertTrue(analytics1.isDiffFrom(analytics3))
        XCTAssertTrue(analytics1.isDiffFrom("not an analytics object"))
        XCTAssertTrue(analytics1.isDiffFrom(nil))
    }
    
    func testDAOFromWithInvalidTypes() throws {
        let analytics = DNSAnalyticsNumbers()
        let data: DNSDataDictionary = [
            "android": "not a number",
            "iOS": 500.0,
            "total": false
        ]
        
        _ = analytics.dao(from: data)
        
        // Should default to 0.0 for invalid types (DNSDataTranslation handles this)
        XCTAssertEqual(analytics.android, 0.0, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 500.0, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 0.0, accuracy: 0.001)
    }
    
    func testDAOFromWithMissingKeys() throws {
        let analytics = DNSAnalyticsNumbers(android: 100.0, iOS: 200.0, total: 300.0)
        let data: DNSDataDictionary = [
            "android": 50.0
        ]
        
        _ = analytics.dao(from: data)
        
        // Should only update android, keep original values for missing keys
        XCTAssertEqual(analytics.android, 50.0, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 200.0, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 300.0, accuracy: 0.001)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test analytics for a typical mobile app
        let mobileApp = DNSAnalyticsNumbers(android: 15000.0, iOS: 25000.0, total: 40000.0)
        
        // Verify platform distribution
        XCTAssertTrue(mobileApp.iOS > mobileApp.android)
        
        // Test web-only analytics (no mobile platforms)
        let webOnly = DNSAnalyticsNumbers(android: 0.0, iOS: 0.0, total: 10000.0)
        XCTAssertEqual(webOnly.android + webOnly.iOS, 0.0, accuracy: 0.001)
        
        // Test copy and modify
        let copy = DNSAnalyticsNumbers(from: mobileApp)
        copy.android = 20000.0
        
        XCTAssertNotEqual(copy.android, mobileApp.android, accuracy: 0.001)
        XCTAssertTrue(copy != mobileApp)
    }
    
    func testPerformanceWithLargeNumbers() throws {
        // Test with large numbers (millions)
        let highTraffic = DNSAnalyticsNumbers(android: 5_000_000.0, iOS: 8_000_000.0, total: 13_000_000.0)
        
        XCTAssertEqual(highTraffic.android, 5_000_000.0, accuracy: 0.001)
        XCTAssertEqual(highTraffic.iOS, 8_000_000.0, accuracy: 0.001)
        XCTAssertEqual(highTraffic.total, 13_000_000.0, accuracy: 0.001)
        
        // Test dictionary conversion with large numbers
        let dictionary = highTraffic.asDictionary
        XCTAssertEqual(dictionary["total"] as? Double ?? Double(0), 13_000_000.0, accuracy: 0.001)
    }
    
    func testFieldMapping() throws {
        let analytics = DNSAnalyticsNumbers()
        
        // Test that field mapping is working correctly by using raw CodingKeys
        let data: DNSDataDictionary = [
            DNSAnalyticsNumbers.CodingKeys.android.rawValue: 123.0,
            DNSAnalyticsNumbers.CodingKeys.iOS.rawValue: 456.0,
            DNSAnalyticsNumbers.CodingKeys.total.rawValue: 789.0
        ]
        
        _ = analytics.dao(from: data)
        
        XCTAssertEqual(analytics.android, 123.0, accuracy: 0.001)
        XCTAssertEqual(analytics.iOS, 456.0, accuracy: 0.001)
        XCTAssertEqual(analytics.total, 789.0, accuracy: 0.001)
    }
}
