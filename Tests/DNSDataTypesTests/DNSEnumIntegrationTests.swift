//
//  DNSEnumIntegrationTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSEnumIntegrationTests: XCTestCase {
    
    func testAllEnumsHaveAllCases() throws {
        // Verify all enums implement CaseIterable
        XCTAssertGreaterThan(DNSAppActionType.allCases.count, 0)
        XCTAssertGreaterThan(DNSBeaconDistance.allCases.count, 0)
        XCTAssertGreaterThan(DNSMediaType.allCases.count, 0)
        XCTAssertGreaterThan(DNSNotificationType.allCases.count, 0)
        XCTAssertGreaterThan(DNSOrderState.allCases.count, 0)
        XCTAssertGreaterThan(DNSReactionType.allCases.count, 0)
        XCTAssertGreaterThan(DNSSystemState.allCases.count, 0)
        XCTAssertGreaterThan(DNSUserRole.allCases.count, 0)
        XCTAssertGreaterThan(DNSUserType.allCases.count, 0)
        XCTAssertGreaterThan(DNSVisibility.allCases.count, 0)
    }
    
    func testCodableEnums() throws {
        let encoder = JSONEncoder()
        
        // Test a sample from each Codable enum
        let testCases: [any Codable] = [
            DNSAppActionType.drawer,
            DNSBeaconDistance.nearby,
            DNSNotificationType.alert,
            DNSOrderState.pending,
            DNSSystemState.green,
            DNSUserRole.endUser,
            DNSUserType.adult,
            DNSVisibility.everyone
        ]
        
        for testCase in testCases {
            let encoded = try encoder.encode(testCase)
            XCTAssertGreaterThan(encoded.count, 0)
            // Note: Can't easily decode back without knowing the exact type,
            // but individual enum tests cover full round-trip testing.
            // DNSMediaType and DNSReactionType are not Codable (only CaseIterable)
        }
    }
    
    func testEnumRawValueConsistency() throws {
        // Test that enums with string raw values have consistent casing
        XCTAssertEqual(DNSAppActionType.fullScreen.rawValue, "fullScreen") // camelCase
        XCTAssertEqual(DNSBeaconDistance.immediate.rawValue, "immediate") // lowercase
        XCTAssertEqual(DNSMediaType.document.rawValue, "document") // lowercase
        XCTAssertEqual(DNSOrderState.processing.rawValue, "processing") // lowercase
        XCTAssertEqual(DNSSystemState.red.rawValue, "red") // lowercase
    }
    
    func testEnumDefaultValues() throws {
        // Test that enums have reasonable default/unknown values
        XCTAssertTrue(DNSBeaconDistance.allCases.contains(.unknown))
        XCTAssertTrue(DNSNotificationType.allCases.contains(.unknown))
        XCTAssertTrue(DNSOrderState.allCases.contains(.unknown))
        XCTAssertTrue(DNSSystemState.allCases.contains(.none))
        XCTAssertTrue(DNSUserType.allCases.contains(.unknown))
        XCTAssertTrue(DNSVisibility.allCases.contains(.everyone))
    }
    
    func testHierarchicalEnums() throws {
        // Test enums that have hierarchical/ordered values
        XCTAssertTrue(DNSUserRole.superUser.rawValue > DNSUserRole.endUser.rawValue)
        XCTAssertTrue(DNSUserRole.endUser.rawValue > DNSUserRole.blocked.rawValue)
    }
    
    func testBusinessLogicEnums() throws {
        // Test enums that represent business states
        let orderStates = DNSOrderState.allCases
        XCTAssertTrue(orderStates.contains(.created))
        XCTAssertTrue(orderStates.contains(.pending))
        XCTAssertTrue(orderStates.contains(.processing))
        XCTAssertTrue(orderStates.contains(.completed))
        XCTAssertTrue(orderStates.contains(.cancelled))
        
        let systemStates = DNSSystemState.allCases
        XCTAssertTrue(systemStates.contains(.green))
        XCTAssertTrue(systemStates.contains(.red))
        XCTAssertTrue(systemStates.contains(.yellow))
    }
    
    func testEnumNameConsistency() throws {
        // Test that all enum names follow DNS* naming convention
        // This is compile-time checked, but we can verify they exist
        XCTAssertNotNil(DNSAppActionType.self)
        XCTAssertNotNil(DNSBeaconDistance.self)
        XCTAssertNotNil(DNSMediaType.self)
        XCTAssertNotNil(DNSNotificationType.self)
        XCTAssertNotNil(DNSOrderState.self)
        XCTAssertNotNil(DNSReactionType.self)
        XCTAssertNotNil(DNSSystemState.self)
        XCTAssertNotNil(DNSUserRole.self)
        XCTAssertNotNil(DNSUserType.self)
        XCTAssertNotNil(DNSVisibility.self)
    }
}
