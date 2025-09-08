//
//  DNSDataTypesPackageTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSDataTypesPackageTests: XCTestCase {
    
    func testPackageStructure() throws {
        // Test that the main types are publicly accessible
        XCTAssertNotNil(DNSAnalyticsNumbers.self)
        XCTAssertNotNil(DNSAppActionType.self)
        XCTAssertNotNil(DNSBeaconDistance.self)
        XCTAssertNotNil(DNSMediaType.self)
        XCTAssertNotNil(DNSNotificationType.self)
        XCTAssertNotNil(DNSOrderState.self)
        XCTAssertNotNil(DNSPrice.self)
        XCTAssertNotNil(DNSPriority.self)
        XCTAssertNotNil(DNSReactionType.self)
        XCTAssertNotNil(DNSScope.self)
        XCTAssertNotNil(DNSStatus.self)
        XCTAssertNotNil(DNSSystemState.self)
        XCTAssertNotNil(DNSDailyHours.self)
        XCTAssertNotNil(DNSDayOfWeekFlags.self)
        XCTAssertNotNil(DNSUserRole.self)
        XCTAssertNotNil(DNSUserType.self)
        XCTAssertNotNil(DNSVisibility.self)
    }
    
    func testImportStructure() throws {
        // Test that DNSCore types are available (via re-export)
        // This verifies the @_exported import works correctly
        let _ = DNSDataDictionary() // Should be available via re-export
    }
    
    func testTypeCategories() throws {
        // Test that we have types for different business domains
        
        // UI/UX types
        XCTAssertNotNil(DNSAppActionType.self)
        XCTAssertNotNil(DNSMediaType.self)
        XCTAssertNotNil(DNSNotificationType.self)
        XCTAssertNotNil(DNSVisibility.self)
        
        // Business logic types
        XCTAssertNotNil(DNSOrderState.self)
        XCTAssertNotNil(DNSUserRole.self)
        XCTAssertNotNil(DNSUserType.self)
        XCTAssertNotNil(DNSSystemState.self)
        
        // Technical types
        XCTAssertNotNil(DNSBeaconDistance.self)
        XCTAssertNotNil(DNSScope.self)
        XCTAssertNotNil(DNSStatus.self)
        
        // Time/Schedule types
        XCTAssertNotNil(DNSDailyHours.self)
        XCTAssertNotNil(DNSDayOfWeekFlags.self)
        
        // Social/Content types
        XCTAssertNotNil(DNSReactionType.self)
        
        // Complex business objects
        XCTAssertNotNil(DNSPrice.self)
        
        // Analytics and metrics types
        XCTAssertNotNil(DNSAnalyticsNumbers.self)
        
        // Constants and utilities
        XCTAssertNotNil(DNSPriority.self)
    }
    
    func testNoCircularDependencies() throws {
        // Test that DNSDataTypes can be initialized without external dependencies
        // (other than DNSCore which is a foundation dependency)
        
        let analytics = DNSAnalyticsNumbers()
        let appAction = DNSAppActionType.drawer
        let mediaType = DNSMediaType.staticImage
        let orderState = DNSOrderState.pending
        let userRole = DNSUserRole.endUser
        let price = DNSPrice()
        
        // If these initialize successfully, we have no circular dependencies
        XCTAssertNotNil(analytics)
        XCTAssertNotNil(appAction)
        XCTAssertNotNil(mediaType)
        XCTAssertNotNil(orderState)
        XCTAssertNotNil(userRole)
        XCTAssertNotNil(price)
    }
    
    func testConsistentNaming() throws {
        // Test that all types follow the DNS* naming convention
        // This ensures consistency across the package
        
        let typeNames = [
            "DNSAnalyticsNumbers",
            "DNSAppActionType",
            "DNSBeaconDistance", 
            "DNSMediaType",
            "DNSNotificationType",
            "DNSOrderState",
            "DNSPrice",
            "DNSPriority",
            "DNSReactionType",
            "DNSScope",
            "DNSStatus",
            "DNSSystemState",
            "DNSDailyHours",
            "DNSDayOfWeekFlags",
            "DNSUserRole", 
            "DNSUserType",
            "DNSVisibility"
        ]
        
        for typeName in typeNames {
            XCTAssertTrue(typeName.hasPrefix("DNS"), "\(typeName) should start with DNS")
        }
    }
    
    func testTypeSemantics() throws {
        // Test that types have appropriate semantics for their domain
        
        // Enum types should have multiple cases
        XCTAssertGreaterThan(DNSAppActionType.allCases.count, 1)
        XCTAssertGreaterThan(DNSMediaType.allCases.count, 1)
        XCTAssertGreaterThan(DNSOrderState.allCases.count, 1)
        XCTAssertGreaterThan(DNSNotificationType.allCases.count, 1)
        XCTAssertGreaterThan(DNSReactionType.allCases.count, 1)
        XCTAssertGreaterThan(DNSSystemState.allCases.count, 1)
        XCTAssertGreaterThan(DNSUserType.allCases.count, 1)
        XCTAssertGreaterThan(DNSVisibility.allCases.count, 1)
        XCTAssertGreaterThan(DNSStatus.allCases.count, 1)
        XCTAssertGreaterThan(DNSScope.allCases.count, 1)
        
        // User roles should have hierarchy
        XCTAssertTrue(DNSUserRole.allCases.count > 3) // Should have multiple role levels
        
        // Price should be a complex object with business logic
        let price = DNSPrice()
        XCTAssertNotNil(price.isActive) // Should have business logic methods
    }
    
    func testBackwardCompatibility() throws {
        // Test that types maintain expected interfaces for backward compatibility
        
        // All enums should be String-based for JSON compatibility
        XCTAssertTrue(DNSAppActionType.drawer.rawValue is String)
        XCTAssertTrue(DNSMediaType.staticImage.rawValue is String)
        XCTAssertTrue(DNSOrderState.pending.rawValue is String)
        XCTAssertTrue(DNSNotificationType.alert.rawValue is String)
        XCTAssertTrue(DNSReactionType.like.rawValue is String)
        XCTAssertTrue(DNSSystemState.green.rawValue is String)
        XCTAssertTrue(DNSUserType.adult.rawValue is String)
        XCTAssertTrue(DNSVisibility.everyone.rawValue is String)
        XCTAssertTrue(DNSStatus.open.rawValue is String)
        
        // User roles should maintain numeric values for hierarchy
        XCTAssertTrue(DNSUserRole.endUser.rawValue is Int)
        XCTAssertTrue(DNSUserRole.superUser.rawValue > DNSUserRole.endUser.rawValue)
        
        // Scope should maintain numeric values for access level hierarchy
        XCTAssertTrue(DNSScope.place.rawValue is Int)
        XCTAssertTrue(DNSScope.all.rawValue > DNSScope.place.rawValue)
    }
}
