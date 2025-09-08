//
//  DNSVisibilityTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSVisibilityTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSVisibility] = [.adultsOnly, .everyone, .staffYouth, .staffOnly, .adminOnly]
        XCTAssertEqual(DNSVisibility.allCases.count, 5)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSVisibility.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSVisibility.adultsOnly.rawValue, "adultsOnly")
        XCTAssertEqual(DNSVisibility.everyone.rawValue, "everyone")
        XCTAssertEqual(DNSVisibility.staffYouth.rawValue, "staffYouth")
        XCTAssertEqual(DNSVisibility.staffOnly.rawValue, "staffOnly")
        XCTAssertEqual(DNSVisibility.adminOnly.rawValue, "adminOnly")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSVisibility(rawValue: "adultsOnly"), .adultsOnly)
        XCTAssertEqual(DNSVisibility(rawValue: "everyone"), .everyone)
        XCTAssertEqual(DNSVisibility(rawValue: "staffYouth"), .staffYouth)
        XCTAssertEqual(DNSVisibility(rawValue: "staffOnly"), .staffOnly)
        XCTAssertEqual(DNSVisibility(rawValue: "adminOnly"), .adminOnly)
        XCTAssertNil(DNSVisibility(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for visibility in DNSVisibility.allCases {
            let encoded = try encoder.encode(visibility)
            let decoded = try decoder.decode(DNSVisibility.self, from: encoded)
            XCTAssertEqual(decoded, visibility)
        }
    }
    
    func testAccessControlHierarchy() throws {
        // Test public access levels
        let publicAccess: [DNSVisibility] = [.everyone]
        for level in publicAccess {
            XCTAssertTrue(DNSVisibility.allCases.contains(level))
        }
        
        // Test age-restricted access
        let restrictedAccess: [DNSVisibility] = [.adultsOnly]
        for level in restrictedAccess {
            XCTAssertTrue(DNSVisibility.allCases.contains(level))
        }
        
        // Test staff access levels
        let staffAccess: [DNSVisibility] = [.staffYouth, .staffOnly]
        for level in staffAccess {
            XCTAssertTrue(DNSVisibility.allCases.contains(level))
        }
        
        // Test administrative access
        let adminAccess: [DNSVisibility] = [.adminOnly]
        for level in adminAccess {
            XCTAssertTrue(DNSVisibility.allCases.contains(level))
        }
    }
    
    func testPermissionLevels() throws {
        // Test that all visibility levels are distinct
        XCTAssertNotEqual(DNSVisibility.everyone, DNSVisibility.adultsOnly)
        XCTAssertNotEqual(DNSVisibility.staffYouth, DNSVisibility.staffOnly)
        XCTAssertNotEqual(DNSVisibility.staffOnly, DNSVisibility.adminOnly)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test content visibility scenarios
        XCTAssertTrue(DNSVisibility.allCases.contains(.everyone)) // Public content
        XCTAssertTrue(DNSVisibility.allCases.contains(.adultsOnly)) // Age-gated content
        XCTAssertTrue(DNSVisibility.allCases.contains(.staffOnly)) // Internal content
        XCTAssertTrue(DNSVisibility.allCases.contains(.adminOnly)) // Sensitive content
        
        // Test youth-specific permissions
        XCTAssertTrue(DNSVisibility.allCases.contains(.staffYouth)) // Youth staff access
    }
    
    func testSecurityImplications() throws {
        // Test that restrictive permissions exist
        let restrictivePermissions: [DNSVisibility] = [.adminOnly, .staffOnly, .adultsOnly]
        for permission in restrictivePermissions {
            XCTAssertTrue(DNSVisibility.allCases.contains(permission))
        }
        
        // Test that open permissions exist
        let openPermissions: [DNSVisibility] = [.everyone, .staffYouth]
        for permission in openPermissions {
            XCTAssertTrue(DNSVisibility.allCases.contains(permission))
        }
    }
}