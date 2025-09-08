//
//  DNSDailyHoursTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSDailyHoursTests: XCTestCase {
    
    func testDefaultInitialization() throws {
        let hours = DNSDailyHours()
        
        XCTAssertNil(hours.open)
        XCTAssertNil(hours.close)
        XCTAssertTrue(hours.isClosedToday)
        XCTAssertFalse(hours.isOpenToday)
    }
    
    func testParameterizedInitialization() throws {
        let openTime = DNSTimeOfDay(hour: 9, minute: 0)
        let closeTime = DNSTimeOfDay(hour: 17, minute: 0)
        
        let hours = DNSDailyHours(open: openTime, close: closeTime)
        
        XCTAssertEqual(hours.open, openTime)
        XCTAssertEqual(hours.close, closeTime)
        XCTAssertFalse(hours.isClosedToday)
        XCTAssertTrue(hours.isOpenToday)
    }
    
    func testCopyInitialization() throws {
        let openTime = DNSTimeOfDay(hour: 8, minute: 30)
        let closeTime = DNSTimeOfDay(hour: 18, minute: 0)
        let original = DNSDailyHours(open: openTime, close: closeTime)
        
        let copy = DNSDailyHours(from: original)
        
        XCTAssertEqual(copy.open, original.open)
        XCTAssertEqual(copy.close, original.close)
        XCTAssertTrue(copy !== original) // Different instances
    }
    
    func testUpdateMethod() throws {
        let hours1 = DNSDailyHours(
            open: DNSTimeOfDay(hour: 9, minute: 0),
            close: DNSTimeOfDay(hour: 17, minute: 0)
        )
        let hours2 = DNSDailyHours()
        
        hours2.update(from: hours1)
        
        XCTAssertEqual(hours2.open, hours1.open)
        XCTAssertEqual(hours2.close, hours1.close)
    }
    
    func testDAOInitFromDictionary() throws {
        let openTimeOfDay = DNSTimeOfDay(hour: 10, minute: 30)
        let closeTimeOfDay = DNSTimeOfDay(hour: 22, minute: 0)
        
        let data: DNSDataDictionary = [
            "open": openTimeOfDay,
            "close": closeTimeOfDay
        ]
        
        let hours = DNSDailyHours(from: data)
        
        XCTAssertEqual(hours.open, openTimeOfDay)
        XCTAssertEqual(hours.close, closeTimeOfDay)
        XCTAssertFalse(hours.isClosedToday)
        XCTAssertTrue(hours.isOpenToday)
    }
    
    func testDAOFromMethod() throws {
        let hours = DNSDailyHours()
        let openTimeOfDay = DNSTimeOfDay(hour: 11, minute: 45)
        let closeTimeOfDay = DNSTimeOfDay(hour: 23, minute: 30)
        
        let data: DNSDataDictionary = [
            "open": openTimeOfDay,
            "close": closeTimeOfDay
        ]
        
        let result = hours.dao(from: data)
        
        XCTAssertTrue(result === hours) // Should return self
        XCTAssertEqual(hours.open, openTimeOfDay)
        XCTAssertEqual(hours.close, closeTimeOfDay)
    }
    
    func testAsDictionary() throws {
        let openTimeOfDay = DNSTimeOfDay(hour: 6, minute: 0)
        let closeTimeOfDay = DNSTimeOfDay(hour: 14, minute: 0)
        let hours = DNSDailyHours(open: openTimeOfDay, close: closeTimeOfDay)
        
        let dictionary = hours.asDictionary
        
        XCTAssertEqual(dictionary["open"] as? DNSTimeOfDay, openTimeOfDay)
        XCTAssertEqual(dictionary["close"] as? DNSTimeOfDay, closeTimeOfDay)
    }
    
    func testCodableConformance() throws {
        let openTimeOfDay = DNSTimeOfDay(hour: 12, minute: 0)
        let closeTimeOfDay = DNSTimeOfDay(hour: 20, minute: 30)
        let hours = DNSDailyHours(open: openTimeOfDay, close: closeTimeOfDay)
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(hours)
        let decoded = try decoder.decode(DNSDailyHours.self, from: encoded)
        
        XCTAssertEqual(decoded.open, hours.open)
        XCTAssertEqual(decoded.close, hours.close)
    }
    
    func testJSONDecodingWithMissingFields() throws {
        let json = """
        {
            "open": {"hour": 9, "minute": 0}
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let hours = try decoder.decode(DNSDailyHours.self, from: json)
        
        XCTAssertNotNil(hours.open)
        XCTAssertNil(hours.close)
    }
    
    func testNSCopyingConformance() throws {
        let openTimeOfDay = DNSTimeOfDay(hour: 7, minute: 30)
        let closeTimeOfDay = DNSTimeOfDay(hour: 19, minute: 0)
        let hours = DNSDailyHours(open: openTimeOfDay, close: closeTimeOfDay)
        
        let copy = hours.copy() as! DNSDailyHours
        
        XCTAssertEqual(copy.open, hours.open)
        XCTAssertEqual(copy.close, hours.close)
        XCTAssertTrue(copy !== hours) // Different instances
    }
    
    func testEquatableProtocol() throws {
        let openTime = DNSTimeOfDay(hour: 8, minute: 0)
        let closeTime = DNSTimeOfDay(hour: 16, minute: 0)
        
        let hours1 = DNSDailyHours(open: openTime, close: closeTime)
        let hours2 = DNSDailyHours(open: openTime, close: closeTime)
        let hours3 = DNSDailyHours(open: DNSTimeOfDay(hour: 9, minute: 0), close: closeTime)
        
        XCTAssertTrue(hours1 == hours2)
        XCTAssertFalse(hours1 == hours3)
        XCTAssertFalse(hours1 != hours2)
        XCTAssertTrue(hours1 != hours3)
    }
    
    func testIsDiffFromMethod() throws {
        let openTime = DNSTimeOfDay(hour: 10, minute: 0)
        let closeTime = DNSTimeOfDay(hour: 18, minute: 0)
        
        let hours1 = DNSDailyHours(open: openTime, close: closeTime)
        let hours2 = DNSDailyHours(open: openTime, close: closeTime)
        let hours3 = DNSDailyHours(open: openTime, close: DNSTimeOfDay(hour: 19, minute: 0))
        
        XCTAssertFalse(hours1.isDiffFrom(hours2))
        XCTAssertTrue(hours1.isDiffFrom(hours3))
        XCTAssertTrue(hours1.isDiffFrom("not hours object"))
        XCTAssertTrue(hours1.isDiffFrom(nil))
    }
    
    func testClosedDayScenarios() throws {
        // Test closed day (no open/close times)
        let closedDay = DNSDailyHours()
        
        XCTAssertTrue(closedDay.isClosedToday)
        XCTAssertFalse(closedDay.isOpenToday)
        XCTAssertNil(closedDay.open)
        XCTAssertNil(closedDay.close)
    }
    
    func testOpenDayScenarios() throws {
        // Test open day with regular hours
        let openDay = DNSDailyHours(
            open: DNSTimeOfDay(hour: 9, minute: 0),
            close: DNSTimeOfDay(hour: 17, minute: 0)
        )
        
        XCTAssertFalse(openDay.isClosedToday)
        XCTAssertTrue(openDay.isOpenToday)
        XCTAssertNotNil(openDay.open)
        XCTAssertNotNil(openDay.close)
    }
    
    func testTimeStringFormatting() throws {
        // Test open hours
        let regularHours = DNSDailyHours(
            open: DNSTimeOfDay(hour: 9, minute: 30),
            close: DNSTimeOfDay(hour: 17, minute: 45)
        )
        let timeString = regularHours.timeAsString()
        XCTAssertFalse(timeString.isEmpty)
        
        // Test closed day
        let closedDay = DNSDailyHours()
        let closedString = closedDay.timeAsString()
        XCTAssertEqual(closedString, DNSDailyHours.Localizations.closedEntireDay)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test various business hour scenarios
        
        // Early morning coffee shop
        let coffeeShop = DNSDailyHours(
            open: DNSTimeOfDay(hour: 6, minute: 0),
            close: DNSTimeOfDay(hour: 14, minute: 0)
        )
        XCTAssertTrue(coffeeShop.isOpenToday)
        
        // Late night restaurant
        let restaurant = DNSDailyHours(
            open: DNSTimeOfDay(hour: 17, minute: 0),
            close: DNSTimeOfDay(hour: 2, minute: 0)  // Next day
        )
        XCTAssertTrue(restaurant.isOpenToday)
        
        // Closed on this day
        let closedBusiness = DNSDailyHours()
        XCTAssertTrue(closedBusiness.isClosedToday)
    }
    
    func testDAOFromWithInvalidTypes() throws {
        let hours = DNSDailyHours()
        let data: DNSDataDictionary = [
            "open": "not a time of day",
            "close": 12345
        ]
        
        _ = hours.dao(from: data)
        
        // Should handle invalid types gracefully
        XCTAssertNil(hours.open)
        XCTAssertNil(hours.close)
    }
    
    func testDAOFromWithMissingKeys() throws {
        let originalOpen = DNSTimeOfDay(hour: 8, minute: 0)
        let originalClose = DNSTimeOfDay(hour: 16, minute: 0)
        
        let hours = DNSDailyHours(open: originalOpen, close: originalClose)
        let data: DNSDataDictionary = [
            "open": DNSTimeOfDay(hour: 9, minute: 0)
            // Missing close time
        ]
        
        _ = hours.dao(from: data)
        
        // Should only update open, keep original close
        XCTAssertEqual(hours.open?.hour, 9)
        XCTAssertEqual(hours.close, originalClose)
    }
    
    func testFieldMapping() throws {
        let hours = DNSDailyHours()
        let openTime = DNSTimeOfDay(hour: 10, minute: 0)
        let closeTime = DNSTimeOfDay(hour: 22, minute: 0)
        
        // Test field mapping using raw CodingKeys
        let data: DNSDataDictionary = [
            DNSDailyHours.CodingKeys.open.rawValue: openTime,
            DNSDailyHours.CodingKeys.close.rawValue: closeTime
        ]
        
        _ = hours.dao(from: data)
        
        XCTAssertEqual(hours.open, openTime)
        XCTAssertEqual(hours.close, closeTime)
    }
    
    func testDateCalculations() throws {
        let hours = DNSDailyHours(
            open: DNSTimeOfDay(hour: 9, minute: 0),
            close: DNSTimeOfDay(hour: 17, minute: 0)
        )
        
        let today = Date()
        
        // Test open/close date calculations
        let openDate = hours.open(on: today)
        let closeDate = hours.close(on: today)
        
        XCTAssertNotNil(openDate)
        XCTAssertNotNil(closeDate)
        
        // Test closed day
        let closedDay = DNSDailyHours()
        XCTAssertNil(closedDay.open(on: today))
        XCTAssertNil(closedDay.close(on: today))
    }
}
