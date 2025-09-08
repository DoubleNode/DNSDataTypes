//
//  DNSDayOfWeekFlagsTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSDayOfWeekFlagsTests: XCTestCase {
    
    func testDefaultInitialization() throws {
        let flags = DNSDayOfWeekFlags()
        
        // Default is all days true
        XCTAssertTrue(flags.sunday)
        XCTAssertTrue(flags.monday)
        XCTAssertTrue(flags.tuesday)
        XCTAssertTrue(flags.wednesday)
        XCTAssertTrue(flags.thursday)
        XCTAssertTrue(flags.friday)
        XCTAssertTrue(flags.saturday)
        XCTAssertTrue(flags.isAllDays)
    }
    
    func testParameterizedInitialization() throws {
        let weekdaysOnly = DNSDayOfWeekFlags(
            sunday: false,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: false
        )
        
        XCTAssertFalse(weekdaysOnly.sunday)
        XCTAssertTrue(weekdaysOnly.monday)
        XCTAssertTrue(weekdaysOnly.tuesday)
        XCTAssertTrue(weekdaysOnly.wednesday)
        XCTAssertTrue(weekdaysOnly.thursday)
        XCTAssertTrue(weekdaysOnly.friday)
        XCTAssertFalse(weekdaysOnly.saturday)
        XCTAssertTrue(weekdaysOnly.isWeekdays)
        XCTAssertFalse(weekdaysOnly.isWeekend)
        XCTAssertFalse(weekdaysOnly.isAllDays)
    }
    
    func testCopyInitialization() throws {
        let original = DNSDayOfWeekFlags(
            sunday: true,
            monday: false,
            tuesday: true,
            wednesday: false,
            thursday: true,
            friday: false,
            saturday: true
        )
        
        let copy = DNSDayOfWeekFlags(from: original)
        
        XCTAssertEqual(copy.sunday, original.sunday)
        XCTAssertEqual(copy.monday, original.monday)
        XCTAssertEqual(copy.tuesday, original.tuesday)
        XCTAssertEqual(copy.wednesday, original.wednesday)
        XCTAssertEqual(copy.thursday, original.thursday)
        XCTAssertEqual(copy.friday, original.friday)
        XCTAssertEqual(copy.saturday, original.saturday)
        XCTAssertTrue(copy !== original) // Different instances
    }
    
    func testUpdateMethod() throws {
        let flags1 = DNSDayOfWeekFlags(
            sunday: false,
            monday: true,
            tuesday: false,
            wednesday: true,
            thursday: false,
            friday: true,
            saturday: false
        )
        let flags2 = DNSDayOfWeekFlags()
        
        flags2.update(from: flags1)
        
        XCTAssertEqual(flags2.sunday, flags1.sunday)
        XCTAssertEqual(flags2.monday, flags1.monday)
        XCTAssertEqual(flags2.tuesday, flags1.tuesday)
        XCTAssertEqual(flags2.wednesday, flags1.wednesday)
        XCTAssertEqual(flags2.thursday, flags1.thursday)
        XCTAssertEqual(flags2.friday, flags1.friday)
        XCTAssertEqual(flags2.saturday, flags1.saturday)
    }
    
    func testDAOInitFromDictionary() throws {
        let data: DNSDataDictionary = [
            "sunday": false,
            "monday": true,
            "tuesday": true,
            "wednesday": true,
            "thursday": true,
            "friday": true,
            "saturday": false
        ]
        
        let flags = DNSDayOfWeekFlags(from: data)
        
        XCTAssertFalse(flags.sunday)
        XCTAssertTrue(flags.monday)
        XCTAssertTrue(flags.tuesday)
        XCTAssertTrue(flags.wednesday)
        XCTAssertTrue(flags.thursday)
        XCTAssertTrue(flags.friday)
        XCTAssertFalse(flags.saturday)
        XCTAssertTrue(flags.isWeekdays)
    }
    
    func testDAOFromMethod() throws {
        let flags = DNSDayOfWeekFlags()
        let data: DNSDataDictionary = [
            "sunday": true,
            "monday": false,
            "tuesday": false,
            "wednesday": false,
            "thursday": false,
            "friday": false,
            "saturday": true
        ]
        
        let result = flags.dao(from: data)
        
        XCTAssertTrue(result === flags) // Should return self
        XCTAssertTrue(flags.sunday)
        XCTAssertFalse(flags.monday)
        XCTAssertFalse(flags.tuesday)
        XCTAssertFalse(flags.wednesday)
        XCTAssertFalse(flags.thursday)
        XCTAssertFalse(flags.friday)
        XCTAssertTrue(flags.saturday)
        XCTAssertTrue(flags.isWeekend)
    }
    
    func testAsDictionary() throws {
        let flags = DNSDayOfWeekFlags(
            sunday: true,
            monday: false,
            tuesday: true,
            wednesday: false,
            thursday: true,
            friday: false,
            saturday: true
        )
        
        let dictionary = flags.asDictionary
        
        XCTAssertEqual(dictionary["sunday"] as? Bool, true)
        XCTAssertEqual(dictionary["monday"] as? Bool, false)
        XCTAssertEqual(dictionary["tuesday"] as? Bool, true)
        XCTAssertEqual(dictionary["wednesday"] as? Bool, false)
        XCTAssertEqual(dictionary["thursday"] as? Bool, true)
        XCTAssertEqual(dictionary["friday"] as? Bool, false)
        XCTAssertEqual(dictionary["saturday"] as? Bool, true)
    }
    
    func testCodableConformance() throws {
        let flags = DNSDayOfWeekFlags(
            sunday: false,
            monday: true,
            tuesday: false,
            wednesday: true,
            thursday: false,
            friday: true,
            saturday: false
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(flags)
        let decoded = try decoder.decode(DNSDayOfWeekFlags.self, from: encoded)
        
        XCTAssertEqual(decoded.sunday, flags.sunday)
        XCTAssertEqual(decoded.monday, flags.monday)
        XCTAssertEqual(decoded.tuesday, flags.tuesday)
        XCTAssertEqual(decoded.wednesday, flags.wednesday)
        XCTAssertEqual(decoded.thursday, flags.thursday)
        XCTAssertEqual(decoded.friday, flags.friday)
        XCTAssertEqual(decoded.saturday, flags.saturday)
    }
    
    func testJSONDecodingWithMissingFields() throws {
        let json = """
        {
            "monday": true,
            "tuesday": true,
            "friday": true
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let flags = try decoder.decode(DNSDayOfWeekFlags.self, from: json)
        
        // Should keep default values for missing fields
        XCTAssertTrue(flags.sunday)  // Default
        XCTAssertTrue(flags.monday)  // Explicitly set
        XCTAssertTrue(flags.tuesday) // Explicitly set
        XCTAssertTrue(flags.wednesday) // Default
        XCTAssertTrue(flags.thursday) // Default
        XCTAssertTrue(flags.friday)  // Explicitly set
        XCTAssertTrue(flags.saturday) // Default
    }
    
    func testNSCopyingConformance() throws {
        let flags = DNSDayOfWeekFlags(
            sunday: false,
            monday: false,
            tuesday: false,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: false
        )
        
        let copy = flags.copy() as! DNSDayOfWeekFlags
        
        XCTAssertEqual(copy.sunday, flags.sunday)
        XCTAssertEqual(copy.monday, flags.monday)
        XCTAssertEqual(copy.tuesday, flags.tuesday)
        XCTAssertEqual(copy.wednesday, flags.wednesday)
        XCTAssertEqual(copy.thursday, flags.thursday)
        XCTAssertEqual(copy.friday, flags.friday)
        XCTAssertEqual(copy.saturday, flags.saturday)
        XCTAssertTrue(copy !== flags) // Different instances
    }
    
    func testEquatableProtocol() throws {
        let flags1 = DNSDayOfWeekFlags(
            sunday: true,
            monday: false,
            tuesday: true,
            wednesday: false,
            thursday: true,
            friday: false,
            saturday: true
        )
        let flags2 = DNSDayOfWeekFlags(
            sunday: true,
            monday: false,
            tuesday: true,
            wednesday: false,
            thursday: true,
            friday: false,
            saturday: true
        )
        let flags3 = DNSDayOfWeekFlags(
            sunday: false, // Different
            monday: false,
            tuesday: true,
            wednesday: false,
            thursday: true,
            friday: false,
            saturday: true
        )
        
        XCTAssertTrue(flags1 == flags2)
        XCTAssertFalse(flags1 == flags3)
        XCTAssertFalse(flags1 != flags2)
        XCTAssertTrue(flags1 != flags3)
    }
    
    func testIsDiffFromMethod() throws {
        let flags1 = DNSDayOfWeekFlags(
            sunday: true,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: false
        )
        let flags2 = DNSDayOfWeekFlags(
            sunday: true,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: false
        )
        let flags3 = DNSDayOfWeekFlags(
            sunday: true,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: true // Different
        )
        
        XCTAssertFalse(flags1.isDiffFrom(flags2))
        XCTAssertTrue(flags1.isDiffFrom(flags3))
        XCTAssertTrue(flags1.isDiffFrom("not flags object"))
        XCTAssertTrue(flags1.isDiffFrom(nil))
    }
    
    func testConvenienceProperties() throws {
        // Test weekdays only
        let weekdaysOnly = DNSDayOfWeekFlags(
            sunday: false,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: false
        )
        XCTAssertTrue(weekdaysOnly.isWeekdays)
        XCTAssertFalse(weekdaysOnly.isWeekend)
        XCTAssertFalse(weekdaysOnly.isAllDays)
        XCTAssertFalse(weekdaysOnly.isNoDays)
        
        // Test weekend only
        let weekendOnly = DNSDayOfWeekFlags(
            sunday: true,
            monday: false,
            tuesday: false,
            wednesday: false,
            thursday: false,
            friday: false,
            saturday: true
        )
        XCTAssertFalse(weekendOnly.isWeekdays)
        XCTAssertTrue(weekendOnly.isWeekend)
        XCTAssertFalse(weekendOnly.isAllDays)
        XCTAssertFalse(weekendOnly.isNoDays)
        
        // Test all days
        let allDays = DNSDayOfWeekFlags() // Default is all true
        XCTAssertFalse(allDays.isWeekdays) // Has weekend too
        XCTAssertFalse(allDays.isWeekend)  // Has weekdays too
        XCTAssertTrue(allDays.isAllDays)
        XCTAssertFalse(allDays.isNoDays)
        
        // Test no days
        let noDays = DNSDayOfWeekFlags(
            sunday: false,
            monday: false,
            tuesday: false,
            wednesday: false,
            thursday: false,
            friday: false,
            saturday: false
        )
        XCTAssertFalse(noDays.isWeekdays)
        XCTAssertFalse(noDays.isWeekend)
        XCTAssertFalse(noDays.isAllDays)
        XCTAssertTrue(noDays.isNoDays)
    }
    
    func testBusinessLogicScenarios() throws {
        // Regular business (weekdays only)
        let regularBusiness = DNSDayOfWeekFlags(
            sunday: false,
            monday: true,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: false
        )
        XCTAssertTrue(regularBusiness.isWeekdays)
        XCTAssertFalse(regularBusiness.isWeekend)
        
        // Restaurant (closed Mondays)
        let restaurant = DNSDayOfWeekFlags(
            sunday: true,
            monday: false,
            tuesday: true,
            wednesday: true,
            thursday: true,
            friday: true,
            saturday: true
        )
        XCTAssertFalse(restaurant.monday)
        XCTAssertTrue(restaurant.sunday)
        XCTAssertFalse(restaurant.isWeekdays) // Missing Monday
        XCTAssertFalse(restaurant.isWeekend)  // Has more than weekend
        
        // 24/7 business
        let alwaysOpen = DNSDayOfWeekFlags()
        XCTAssertTrue(alwaysOpen.isAllDays)
        
        // Temporarily closed business
        let closedForRenovation = DNSDayOfWeekFlags(
            sunday: false,
            monday: false,
            tuesday: false,
            wednesday: false,
            thursday: false,
            friday: false,
            saturday: false
        )
        XCTAssertTrue(closedForRenovation.isNoDays)
    }
    
    func testDAOFromWithInvalidTypes() throws {
        let flags = DNSDayOfWeekFlags()
        let data: DNSDataDictionary = [
            "sunday": "not a boolean",
            "monday": true,
            "tuesday": 123,
            "wednesday": true
        ]
        
        _ = flags.dao(from: data)
        
        // Should handle invalid types gracefully
        XCTAssertTrue(flags.sunday)    // Default (invalid type)
        XCTAssertTrue(flags.monday)    // Valid
        XCTAssertTrue(flags.tuesday)   // Default (invalid type)
        XCTAssertTrue(flags.wednesday) // Valid
    }
    
    func testDAOFromWithMissingKeys() throws {
        let originalFlags = DNSDayOfWeekFlags(
            sunday: false,
            monday: false,
            tuesday: false,
            wednesday: false,
            thursday: false,
            friday: false,
            saturday: false
        )
        
        let data: DNSDataDictionary = [
            "monday": true,
            "friday": true
        ]
        
        _ = originalFlags.dao(from: data)
        
        // Should only update specified days, keep original values for missing
        XCTAssertFalse(originalFlags.sunday)    // Kept original
        XCTAssertTrue(originalFlags.monday)     // Updated
        XCTAssertFalse(originalFlags.tuesday)   // Kept original
        XCTAssertFalse(originalFlags.wednesday) // Kept original
        XCTAssertFalse(originalFlags.thursday)  // Kept original
        XCTAssertTrue(originalFlags.friday)     // Updated
        XCTAssertFalse(originalFlags.saturday)  // Kept original
    }
    
    func testFieldMapping() throws {
        let flags = DNSDayOfWeekFlags()
        
        // Test field mapping using raw CodingKeys
        let data: DNSDataDictionary = [
            DNSDayOfWeekFlags.CodingKeys.monday.rawValue: true,
            DNSDayOfWeekFlags.CodingKeys.wednesday.rawValue: true,
            DNSDayOfWeekFlags.CodingKeys.friday.rawValue: true,
            DNSDayOfWeekFlags.CodingKeys.sunday.rawValue: false,
            DNSDayOfWeekFlags.CodingKeys.tuesday.rawValue: false,
            DNSDayOfWeekFlags.CodingKeys.thursday.rawValue: false,
            DNSDayOfWeekFlags.CodingKeys.saturday.rawValue: false
        ]
        
        _ = flags.dao(from: data)
        
        XCTAssertFalse(flags.sunday)
        XCTAssertTrue(flags.monday)
        XCTAssertFalse(flags.tuesday)
        XCTAssertTrue(flags.wednesday)
        XCTAssertFalse(flags.thursday)
        XCTAssertTrue(flags.friday)
        XCTAssertFalse(flags.saturday)
    }
}
