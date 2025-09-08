//
//  DNSPriceTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSPriceTests: XCTestCase {
    
    func testInitialization() throws {
        let price = DNSPrice()
        
        XCTAssertEqual(price.price, 0.0)
        XCTAssertEqual(price.priority, DNSPriority.normal) // Default priority
        XCTAssertTrue(price.isActive) // Default should be active
    }
    
    func testCopyInitialization() throws {
        let originalPrice = DNSPrice()
        originalPrice.price = 25.99
        originalPrice.priority = DNSPriority.high
        
        let copiedPrice = DNSPrice(from: originalPrice)
        
        XCTAssertEqual(copiedPrice.price, 25.99)
        XCTAssertEqual(copiedPrice.priority, DNSPriority.high)
    }
    
    func testPriorityBounds() throws {
        let price = DNSPrice()
        
        // Test setting priority within valid range
        price.priority = DNSPriority.high
        XCTAssertEqual(price.priority, DNSPriority.high)
        
        // Test that priority bounds work - should clamp to highest
        price.priority = DNSPriority.highest + 100
        XCTAssertEqual(price.priority, DNSPriority.highest)
        
        // Test that priority bounds work - should clamp to none (lowest)
        price.priority = DNSPriority.none - 100
        XCTAssertEqual(price.priority, DNSPriority.none)
    }
    
    func testActiveStatus_AllTimeActive() throws {
        let price = DNSPrice()
        // When both times are at default, should be active all the time
        XCTAssertTrue(price.isActive)
        XCTAssertTrue(price.isActive(for: Date()))
    }
    
    func testPriceValue() throws {
        let price = DNSPrice()
        
        // Test setting price
        price.price = 29.99
        XCTAssertEqual(price.price, 29.99, accuracy: 0.01)
        
        price.price = 0.01
        XCTAssertEqual(price.price, 0.01, accuracy: 0.001)
        
        price.price = 999.99
        XCTAssertEqual(price.price, 999.99, accuracy: 0.01)
    }
    
    func testCodableConformance() throws {
        let price = DNSPrice()
        price.price = 19.99
        price.priority = DNSPriority.high
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(price)
        let decoded = try decoder.decode(DNSPrice.self, from: encoded)
        
        XCTAssertEqual(decoded.price, price.price, accuracy: 0.01)
        XCTAssertEqual(decoded.priority, price.priority)
    }
    
    func testNSCopyingConformance() throws {
        let price = DNSPrice()
        price.price = 29.99
        price.priority = DNSPriority.low
        
        let copy = price.copy() as! DNSPrice
        
        XCTAssertEqual(copy.price, price.price, accuracy: 0.01)
        XCTAssertEqual(copy.priority, price.priority)
        
        // Ensure it's actually a copy, not the same instance
        XCTAssertTrue(copy !== price)
    }
    
    func testEquality() throws {
        let price1 = DNSPrice()
        price1.price = 15.99
        price1.priority = DNSPriority.normal
        
        let price2 = DNSPrice()
        price2.price = 15.99
        price2.priority = DNSPriority.normal
        
        XCTAssertTrue(price1 == price2)
        
        price2.price = 16.99
        XCTAssertTrue(price1 != price2)
    }
    
    func testDifferenceDetection() throws {
        let price1 = DNSPrice()
        price1.price = 12.99
        
        let price2 = DNSPrice()
        price2.price = 13.99
        
        XCTAssertTrue(price1.isDiffFrom(price2))
        XCTAssertFalse(price1.isDiffFrom(price1)) // Same instance
        
        price2.price = 12.99
        XCTAssertFalse(price1.isDiffFrom(price2)) // Same values
    }
    
    func testAsDictionary() throws {
        let price = DNSPrice()
        price.price = 24.99
        price.priority = DNSPriority.high
        
        let dictionary = price.asDictionary
        
        XCTAssertEqual(dictionary["price"] as? Float ?? Float(0.0), Float(24.99), accuracy: 0.01)
        XCTAssertEqual(dictionary["priority"] as? Int, DNSPriority.high)
        XCTAssertNotNil(dictionary["startTime"] as Any?)
        XCTAssertNotNil(dictionary["endTime"] as Any?)
    }
    
    func testBusinessLogic() throws {
        let price = DNSPrice()
        
        // Test that price can be modified
        price.price = 49.99
        XCTAssertEqual(price.price, 49.99, accuracy: 0.01)
        
        // Test that priority can be modified
        let originalPriority = price.priority
        price.priority = originalPriority + 5
        XCTAssertNotEqual(price.priority, originalPriority)
        
        // Test active status
        XCTAssertTrue(price.isActive) // Should be active by default
    }
}
