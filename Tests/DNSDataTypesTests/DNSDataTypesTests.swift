//
//  DNSDataTypesTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

/// Main test suite for DNSDataTypes package
/// Tests core functionality, integration, and package-level features
final class DNSDataTypesTests: XCTestCase {
    
    // MARK: - Core Type Tests
    
    func testUserRoleHierarchy() throws {
        // Test that user roles maintain proper hierarchy
        XCTAssertTrue(DNSUserRole.superUser.rawValue > DNSUserRole.endUser.rawValue)
        XCTAssertTrue(DNSUserRole.blocked.rawValue < DNSUserRole.endUser.rawValue)
        
        // Test admin functionality
        XCTAssertTrue(DNSUserRole.superUser.isAdmin(for: .all))
        XCTAssertFalse(DNSUserRole.endUser.isAdmin(for: .all))
    }
    
    func testOrderStateValues() throws {
        // Test that all order states can be instantiated
        let states: [DNSOrderState] = [.pending, .cancelled, .completed, .created, .fraudulent, .processing, .refunded, .unknown]
        XCTAssertEqual(states.count, 8)
        XCTAssertEqual(DNSOrderState.allCases.count, 8)
    }
    
    func testMediaTypeValues() throws {
        // Test that media types cover expected cases
        let types: [DNSMediaType] = [.unknown, .animatedImage, .pdfDocument, .staticImage, .text, .video]
        XCTAssertEqual(types.count, 6)
        XCTAssertEqual(DNSMediaType.allCases.count, 6)
    }
    
    // MARK: - Complex Object Tests
    
    func testPriceBusinessLogic() throws {
        let price = DNSPrice()
        
        // Test default state
        XCTAssertTrue(price.isActive) // Should be active by default (no time restrictions)
        
        // Test price setting
        price.price = 29.99
        XCTAssertEqual(price.price, 29.99)
        
        // Test priority bounds (values are clamped by implementation)
        price.priority = DNSPriority.highest + 100 // Beyond max
        XCTAssertEqual(price.priority, DNSPriority.highest)
        
        price.priority = DNSPriority.none - 100 // Below min
        XCTAssertEqual(price.priority, DNSPriority.none)
    }
    
    // MARK: - Package Integration Tests
    
    func testAllTypesAreAccessible() throws {
        // Test that all major types are publicly accessible
        XCTAssertNotNil(DNSAppActionType.self)
        XCTAssertNotNil(DNSBeaconDistance.self)
        XCTAssertNotNil(DNSMediaType.self)
        XCTAssertNotNil(DNSNotificationType.self)
        XCTAssertNotNil(DNSOrderState.self)
        XCTAssertNotNil(DNSPrice.self)
        XCTAssertNotNil(DNSPriority.self)
        XCTAssertNotNil(DNSReactionType.self)
        XCTAssertNotNil(DNSSystemState.self)
        XCTAssertNotNil(DNSUserRole.self)
        XCTAssertNotNil(DNSUserType.self)
        XCTAssertNotNil(DNSVisibility.self)
    }
    
    func testCodableSupport() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // Test enum encoding/decoding
        let orderState = DNSOrderState.processing
        let encodedState = try encoder.encode(orderState)
        let decodedState = try decoder.decode(DNSOrderState.self, from: encodedState)
        XCTAssertEqual(decodedState, orderState)
        
        // Test complex object encoding/decoding
        let price = DNSPrice()
        price.price = 19.99
        price.priority = DNSPriority.high
        
        let encodedPrice = try encoder.encode(price)
        let decodedPrice = try decoder.decode(DNSPrice.self, from: encodedPrice)
        XCTAssertEqual(decodedPrice.price, price.price)
        XCTAssertEqual(decodedPrice.priority, price.priority)
    }
    
    func testCopyingSupport() throws {
        let price = DNSPrice()
        price.price = 15.50
        price.priority = DNSPriority.low
        
        let copy = price.copy() as! DNSPrice
        
        XCTAssertEqual(copy.price, price.price)
        XCTAssertEqual(copy.priority, price.priority)
        XCTAssertTrue(copy !== price) // Different instances
    }
    
    // MARK: - Type System Tests
    
    func testEnumConsistency() throws {
        // Test that enums follow consistent patterns
        
        // String-based enums should have lowercase raw values
        XCTAssertEqual(DNSMediaType.staticImage.rawValue, "staticImage")
        XCTAssertEqual(DNSSystemState.green.rawValue, "green")
        
        // Int-based enums should have meaningful numeric values
        XCTAssertEqual(DNSUserRole.blocked.rawValue, -1)
        XCTAssertEqual(DNSUserRole.endUser.rawValue, 0)
    }
    
    func testDefaultValues() throws {
        // Test that types have sensible defaults
        let price = DNSPrice()
        XCTAssertEqual(price.price, 0.0)
        XCTAssertEqual(price.priority, DNSPriority.normal)
        XCTAssertTrue(price.isActive)
    }
    
    // MARK: - Performance Tests
    
    func testEnumPerformance() throws {
        // Test that enum operations are fast
        measure {
            for _ in 0..<10000 {
                let _ = DNSOrderState(rawValue: "pending")
                let _ = DNSUserRole.endUser.isAdmin(for: .place)
                let _ = DNSMediaType.allCases.contains(.staticImage)
            }
        }
    }
    
    func testPricePerformance() throws {
        // Test that price operations are fast
        measure {
            for _ in 0..<1000 {
                let price = DNSPrice()
                price.price = Float.random(in: 0...100)
                price.priority = Int.random(in: DNSPriority.none...DNSPriority.highest)
                let _ = price.isActive(for: Date())
                let _ = price.copy()
            }
        }
    }
}
