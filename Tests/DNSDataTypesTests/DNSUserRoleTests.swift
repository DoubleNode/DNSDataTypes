//
//  DNSUserRoleTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSUserRoleTests: XCTestCase {
    
    func testRoleHierarchy() throws {
        // Test that roles maintain proper numeric hierarchy
        XCTAssertTrue(DNSUserRole.superUser.rawValue > DNSUserRole.supportAdmin.rawValue)
        XCTAssertTrue(DNSUserRole.supportAdmin.rawValue > DNSUserRole.regionalAdmin.rawValue)
        XCTAssertTrue(DNSUserRole.regionalAdmin.rawValue > DNSUserRole.districtAdmin.rawValue)
        XCTAssertTrue(DNSUserRole.districtAdmin.rawValue > DNSUserRole.placeAdmin.rawValue)
        XCTAssertTrue(DNSUserRole.placeAdmin.rawValue > DNSUserRole.placeViewer.rawValue)
        XCTAssertTrue(DNSUserRole.placeViewer.rawValue > DNSUserRole.endUser.rawValue)
        XCTAssertTrue(DNSUserRole.endUser.rawValue > DNSUserRole.blocked.rawValue)
    }
    
    func testSpecificRoleValues() throws {
        XCTAssertEqual(DNSUserRole.blocked.rawValue, -1)
        XCTAssertEqual(DNSUserRole.endUser.rawValue, 0)
        XCTAssertEqual(DNSUserRole.placeViewer.rawValue, 6000)
        XCTAssertEqual(DNSUserRole.placeStaff.rawValue, 7000)
        XCTAssertEqual(DNSUserRole.placeOperations.rawValue, 8000)
        XCTAssertEqual(DNSUserRole.placeAdmin.rawValue, 9000)
        XCTAssertEqual(DNSUserRole.supportViewer.rawValue, 500000)
        XCTAssertEqual(DNSUserRole.supportAdmin.rawValue, 800000)
        XCTAssertEqual(DNSUserRole.superUser.rawValue, 900000)
    }
    
    func testAllCases() throws {
        // Verify all 22 role cases are present
        let expectedCount = 19
        XCTAssertEqual(DNSUserRole.allCases.count, expectedCount)
        
        // Test that all roles are distinct
        let roles = DNSUserRole.allCases
        let uniqueRoles = Set(roles.map { $0.rawValue })
        XCTAssertEqual(roles.count, uniqueRoles.count)
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for role in DNSUserRole.allCases {
            let encoded = try encoder.encode(role)
            let decoded = try decoder.decode(DNSUserRole.self, from: encoded)
            XCTAssertEqual(decoded, role)
        }
    }
    
    func testSuperUserFlag() throws {
        // Test isSuperUser property
        XCTAssertTrue(DNSUserRole.superUser.isSuperUser)
        XCTAssertFalse(DNSUserRole.supportAdmin.isSuperUser)
        XCTAssertFalse(DNSUserRole.endUser.isSuperUser)
        XCTAssertFalse(DNSUserRole.blocked.isSuperUser)
    }
    
    func testAdminPermissions() throws {
        // Test admin permissions for different scopes
        XCTAssertTrue(DNSUserRole.superUser.isAdmin(for: .all))
        XCTAssertTrue(DNSUserRole.supportViewer.isAdmin(for: .all))
        XCTAssertFalse(DNSUserRole.regionalAdmin.isAdmin(for: .all))
        
        XCTAssertTrue(DNSUserRole.regionalViewer.isAdmin(for: .region))
        XCTAssertFalse(DNSUserRole.districtAdmin.isAdmin(for: .region))
        
        XCTAssertTrue(DNSUserRole.districtViewer.isAdmin(for: .district))
        XCTAssertFalse(DNSUserRole.placeAdmin.isAdmin(for: .district))
        
        XCTAssertTrue(DNSUserRole.placeViewer.isAdmin(for: .place))
        XCTAssertFalse(DNSUserRole.endUser.isAdmin(for: .place))
    }
    
    func testRoleCodeConversions() throws {
        // Test code property
        XCTAssertEqual(DNSUserRole.superUser.code, "SuperUser")
        XCTAssertEqual(DNSUserRole.supportAdmin.code, "SupportAdmin")
        XCTAssertEqual(DNSUserRole.placeViewer.code, "PlaceViewer")
        XCTAssertEqual(DNSUserRole.endUser.code, "EndUser")
        XCTAssertEqual(DNSUserRole.blocked.code, "Blocked")
        
        // Test userRole(from:) conversion
        XCTAssertEqual(DNSUserRole.userRole(from: "SuperUser"), .superUser)
        XCTAssertEqual(DNSUserRole.userRole(from: "SupportAdmin"), .supportAdmin)
        XCTAssertEqual(DNSUserRole.userRole(from: "PlaceViewer"), .placeViewer)
        XCTAssertEqual(DNSUserRole.userRole(from: "EndUser"), .endUser)
        XCTAssertEqual(DNSUserRole.userRole(from: "Blocked"), .blocked)
        XCTAssertEqual(DNSUserRole.userRole(from: "Invalid"), .blocked) // Default fallback
    }
    
    func testOrganizationalLevels() throws {
        // Test place-level roles
        let placeRoles: [DNSUserRole] = [.placeViewer, .placeStaff, .placeOperations, .placeAdmin]
        for role in placeRoles {
            XCTAssertTrue(DNSUserRole.allCases.contains(role))
            XCTAssertTrue(role.isAdmin(for: .place))
        }
        
        // Test district-level roles
        let districtRoles: [DNSUserRole] = [.districtViewer, .districtStaff, .districtOperations, .districtAdmin]
        for role in districtRoles {
            XCTAssertTrue(DNSUserRole.allCases.contains(role))
            XCTAssertTrue(role.isAdmin(for: .district))
        }
        
        // Test regional-level roles
        let regionalRoles: [DNSUserRole] = [.regionalViewer, .regionalStaff, .regionalOperations, .regionalAdmin]
        for role in regionalRoles {
            XCTAssertTrue(DNSUserRole.allCases.contains(role))
            XCTAssertTrue(role.isAdmin(for: .region))
        }
        
        // Test support-level roles
        let supportRoles: [DNSUserRole] = [.supportViewer, .supportStaff, .supportOperations, .supportAdmin]
        for role in supportRoles {
            XCTAssertTrue(DNSUserRole.allCases.contains(role))
            XCTAssertTrue(role.isAdmin(for: .all))
        }
    }
    
    func testRoleDistinction() throws {
        // Test that roles at same level have different values
        XCTAssertNotEqual(DNSUserRole.placeViewer, DNSUserRole.placeStaff)
        XCTAssertNotEqual(DNSUserRole.placeStaff, DNSUserRole.placeOperations)
        XCTAssertNotEqual(DNSUserRole.placeOperations, DNSUserRole.placeAdmin)
        
        XCTAssertNotEqual(DNSUserRole.districtViewer, DNSUserRole.districtStaff)
        XCTAssertNotEqual(DNSUserRole.regionalViewer, DNSUserRole.regionalStaff)
        XCTAssertNotEqual(DNSUserRole.supportViewer, DNSUserRole.supportStaff)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test common business scenarios
        
        // End user access
        let endUser = DNSUserRole.endUser
        XCTAssertFalse(endUser.isAdmin(for: .place))
        XCTAssertFalse(endUser.isSuperUser)
        
        // Place staff access
        let placeStaff = DNSUserRole.placeStaff
        XCTAssertTrue(placeStaff.isAdmin(for: .place))
        XCTAssertFalse(placeStaff.isAdmin(for: .district))
        
        // Support access
        let supportViewer = DNSUserRole.supportViewer
        XCTAssertTrue(supportViewer.isAdmin(for: .all))
        XCTAssertTrue(supportViewer.isAdmin(for: .region))
        XCTAssertTrue(supportViewer.isAdmin(for: .district))
        XCTAssertTrue(supportViewer.isAdmin(for: .place))
        
        // Super user access
        let superUser = DNSUserRole.superUser
        XCTAssertTrue(superUser.isSuperUser)
        XCTAssertTrue(superUser.isAdmin(for: .all))
        
        // Blocked user
        let blocked = DNSUserRole.blocked
        XCTAssertFalse(blocked.isAdmin(for: .place))
        XCTAssertFalse(blocked.isSuperUser)
    }
}
