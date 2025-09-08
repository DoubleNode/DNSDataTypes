//
//  DNSScopeTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSScopeTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSScope] = [.place, .district, .region, .all]
        XCTAssertEqual(DNSScope.allCases.count, 4)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSScope.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSScope.place.rawValue, 1000)
        XCTAssertEqual(DNSScope.district.rawValue, 3000)
        XCTAssertEqual(DNSScope.region.rawValue, 5000)
        XCTAssertEqual(DNSScope.all.rawValue, 10000)
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSScope(rawValue: 1000), .place)
        XCTAssertEqual(DNSScope(rawValue: 3000), .district)
        XCTAssertEqual(DNSScope(rawValue: 5000), .region)
        XCTAssertEqual(DNSScope(rawValue: 10000), .all)
        XCTAssertNil(DNSScope(rawValue: 999))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for scope in DNSScope.allCases {
            let encoded = try encoder.encode(scope)
            let decoded = try decoder.decode(DNSScope.self, from: encoded)
            XCTAssertEqual(decoded, scope)
        }
    }
    
    func testScopeHierarchy() throws {
        // Test that scope values increase with broader access
        XCTAssertLessThan(DNSScope.place.rawValue, DNSScope.district.rawValue)
        XCTAssertLessThan(DNSScope.district.rawValue, DNSScope.region.rawValue)
        XCTAssertLessThan(DNSScope.region.rawValue, DNSScope.all.rawValue)
    }
    
    func testAccessControlLevels() throws {
        // Test granular access levels
        let granularScopes: [DNSScope] = [.place]
        for scope in granularScopes {
            XCTAssertTrue(DNSScope.allCases.contains(scope))
        }
        
        // Test intermediate access levels
        let intermediateScopes: [DNSScope] = [.district, .region]
        for scope in intermediateScopes {
            XCTAssertTrue(DNSScope.allCases.contains(scope))
        }
        
        // Test global access levels
        let globalScopes: [DNSScope] = [.all]
        for scope in globalScopes {
            XCTAssertTrue(DNSScope.allCases.contains(scope))
        }
    }
    
    func testScopeComparison() throws {
        // Test scope comparison logic
        XCTAssertTrue(DNSScope.place.rawValue < DNSScope.district.rawValue)
        XCTAssertTrue(DNSScope.district.rawValue < DNSScope.region.rawValue)
        XCTAssertTrue(DNSScope.region.rawValue < DNSScope.all.rawValue)
        
        // Test that all scopes are distinct
        XCTAssertNotEqual(DNSScope.place, DNSScope.district)
        XCTAssertNotEqual(DNSScope.district, DNSScope.region)
        XCTAssertNotEqual(DNSScope.region, DNSScope.all)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test organizational hierarchy scenarios
        XCTAssertTrue(DNSScope.allCases.contains(.place)) // Local/facility level
        XCTAssertTrue(DNSScope.allCases.contains(.district)) // District/area level
        XCTAssertTrue(DNSScope.allCases.contains(.region)) // Regional level
        XCTAssertTrue(DNSScope.allCases.contains(.all)) // Organization-wide level
        
        // Test permission escalation scenarios
        let escalationOrder = [DNSScope.place, .district, .region, .all]
        for (index, scope) in escalationOrder.enumerated() {
            if index > 0 {
                let previousScope = escalationOrder[index - 1]
                XCTAssertGreaterThan(scope.rawValue, previousScope.rawValue)
            }
        }
    }
    
    func testRoleBasedAccessControl() throws {
        // Test RBAC scenarios with different scope levels
        let localAccess = DNSScope.place
        let districtAccess = DNSScope.district
        let regionalAccess = DNSScope.region
        let globalAccess = DNSScope.all
        
        // Verify scope hierarchy for RBAC
        XCTAssertTrue(localAccess.rawValue < districtAccess.rawValue)
        XCTAssertTrue(districtAccess.rawValue < regionalAccess.rawValue)
        XCTAssertTrue(regionalAccess.rawValue < globalAccess.rawValue)
    }
    
    func testScopeValueSpacing() throws {
        // Test that scope values have appropriate spacing for future expansion
        let placeToDistrict = DNSScope.district.rawValue - DNSScope.place.rawValue
        let districtToRegion = DNSScope.region.rawValue - DNSScope.district.rawValue
        let regionToAll = DNSScope.all.rawValue - DNSScope.region.rawValue
        
        // Verify there's room for expansion between levels
        XCTAssertGreaterThan(placeToDistrict, 1000)
        XCTAssertGreaterThan(districtToRegion, 1000)
        XCTAssertGreaterThan(regionToAll, 1000)
    }
}