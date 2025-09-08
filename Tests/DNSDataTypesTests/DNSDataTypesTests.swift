//
//  DNSDataTypesTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSDataTypesTests: XCTestCase {
    func testUserRoleHierarchy() throws {
        // Test that user roles maintain proper hierarchy
        XCTAssertTrue(DNSUserRole.superUser.rawValue > DNSUserRole.endUser.rawValue)
        XCTAssertTrue(DNSUserRole.blocked.rawValue < DNSUserRole.endUser.rawValue)
    }
    
    func testOrderStateValues() throws {
        // Test that all order states can be instantiated
        let states: [DNSOrderState] = [.pending, .cancelled, .completed, .created, .fraudulent, .processing, .refunded, .unknown]
        XCTAssertEqual(states.count, 8)
    }
    
    func testMediaTypeValues() throws {
        // Test that media types cover expected cases
        let types: [DNSMediaType] = [.image, .video, .audio, .document, .other]
        XCTAssertEqual(types.count, 5)
    }
}