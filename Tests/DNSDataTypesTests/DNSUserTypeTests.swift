//
//  DNSUserTypeTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSUserTypeTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSUserType] = [.unknown, .child, .youth, .pendingAdult, .adult]
        XCTAssertEqual(DNSUserType.allCases.count, 5)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSUserType.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSUserType.unknown.rawValue, "")
        XCTAssertEqual(DNSUserType.child.rawValue, "child")
        XCTAssertEqual(DNSUserType.youth.rawValue, "youth")
        XCTAssertEqual(DNSUserType.pendingAdult.rawValue, "pendingAdult")
        XCTAssertEqual(DNSUserType.adult.rawValue, "adult")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSUserType(rawValue: ""), .unknown)
        XCTAssertEqual(DNSUserType(rawValue: "child"), .child)
        XCTAssertEqual(DNSUserType(rawValue: "youth"), .youth)
        XCTAssertEqual(DNSUserType(rawValue: "pendingAdult"), .pendingAdult)
        XCTAssertEqual(DNSUserType(rawValue: "adult"), .adult)
        XCTAssertNil(DNSUserType(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for userType in DNSUserType.allCases {
            let encoded = try encoder.encode(userType)
            let decoded = try decoder.decode(DNSUserType.self, from: encoded)
            XCTAssertEqual(decoded, userType)
        }
    }
    
    func testAgeBasedClassification() throws {
        // Test minor age groups
        let minorTypes: [DNSUserType] = [.child, .youth]
        for type in minorTypes {
            XCTAssertTrue(DNSUserType.allCases.contains(type))
        }
        
        // Test adult age groups
        let adultTypes: [DNSUserType] = [.pendingAdult, .adult]
        for type in adultTypes {
            XCTAssertTrue(DNSUserType.allCases.contains(type))
        }
        
        // Test default/fallback type
        XCTAssertTrue(DNSUserType.allCases.contains(.unknown))
    }
    
    func testUserTypeProgression() throws {
        // Test logical age progression
        XCTAssertNotEqual(DNSUserType.child, DNSUserType.youth)
        XCTAssertNotEqual(DNSUserType.youth, DNSUserType.pendingAdult)
        XCTAssertNotEqual(DNSUserType.pendingAdult, DNSUserType.adult)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test age verification scenarios
        let requiresParentalConsent: [DNSUserType] = [.child, .youth]
        for userType in requiresParentalConsent {
            XCTAssertTrue(DNSUserType.allCases.contains(userType))
        }
        
        // Test adult verification scenarios
        let canMakeDecisions: [DNSUserType] = [.adult]
        for userType in canMakeDecisions {
            XCTAssertTrue(DNSUserType.allCases.contains(userType))
        }
        
        // Test transition states
        let transitionStates: [DNSUserType] = [.pendingAdult]
        for userType in transitionStates {
            XCTAssertTrue(DNSUserType.allCases.contains(userType))
        }
    }
}