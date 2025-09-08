//
//  DNSStatusTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSStatusTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSStatus] = [
            .badWeather, .closed, .comingSoon, .grandOpening, .hidden,
            .holiday, .maintenance, .open, .privateEvent, .tempClosed, .training
        ]
        XCTAssertEqual(DNSStatus.allCases.count, 11)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSStatus.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSStatus.badWeather.rawValue, "badWeather")
        XCTAssertEqual(DNSStatus.closed.rawValue, "closed")
        XCTAssertEqual(DNSStatus.comingSoon.rawValue, "comingSoon")
        XCTAssertEqual(DNSStatus.grandOpening.rawValue, "grandOpening")
        XCTAssertEqual(DNSStatus.hidden.rawValue, "hidden")
        XCTAssertEqual(DNSStatus.holiday.rawValue, "holiday")
        XCTAssertEqual(DNSStatus.maintenance.rawValue, "maintenance")
        XCTAssertEqual(DNSStatus.open.rawValue, "open")
        XCTAssertEqual(DNSStatus.privateEvent.rawValue, "privateEvent")
        XCTAssertEqual(DNSStatus.tempClosed.rawValue, "tempClosed")
        XCTAssertEqual(DNSStatus.training.rawValue, "training")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSStatus(rawValue: "badWeather"), .badWeather)
        XCTAssertEqual(DNSStatus(rawValue: "closed"), .closed)
        XCTAssertEqual(DNSStatus(rawValue: "comingSoon"), .comingSoon)
        XCTAssertEqual(DNSStatus(rawValue: "grandOpening"), .grandOpening)
        XCTAssertEqual(DNSStatus(rawValue: "hidden"), .hidden)
        XCTAssertEqual(DNSStatus(rawValue: "holiday"), .holiday)
        XCTAssertEqual(DNSStatus(rawValue: "maintenance"), .maintenance)
        XCTAssertEqual(DNSStatus(rawValue: "open"), .open)
        XCTAssertEqual(DNSStatus(rawValue: "privateEvent"), .privateEvent)
        XCTAssertEqual(DNSStatus(rawValue: "tempClosed"), .tempClosed)
        XCTAssertEqual(DNSStatus(rawValue: "training"), .training)
        XCTAssertNil(DNSStatus(rawValue: "invalid"))
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        for status in DNSStatus.allCases {
            let encoded = try encoder.encode(status)
            let decoded = try decoder.decode(DNSStatus.self, from: encoded)
            XCTAssertEqual(decoded, status)
        }
    }
    
    func testOperationalStates() throws {
        // Test open operational states
        let openStates: [DNSStatus] = [.open, .grandOpening]
        for state in openStates {
            XCTAssertTrue(DNSStatus.allCases.contains(state))
        }
        
        // Test closed operational states
        let closedStates: [DNSStatus] = [.closed, .tempClosed]
        for state in closedStates {
            XCTAssertTrue(DNSStatus.allCases.contains(state))
        }
        
        // Test special event states
        let eventStates: [DNSStatus] = [.privateEvent, .holiday, .training]
        for state in eventStates {
            XCTAssertTrue(DNSStatus.allCases.contains(state))
        }
    }
    
    func testMaintenanceStates() throws {
        // Test maintenance-related states
        let maintenanceStates: [DNSStatus] = [.maintenance, .badWeather]
        for state in maintenanceStates {
            XCTAssertTrue(DNSStatus.allCases.contains(state))
        }
        
        // Test visibility states
        let visibilityStates: [DNSStatus] = [.hidden, .comingSoon]
        for state in visibilityStates {
            XCTAssertTrue(DNSStatus.allCases.contains(state))
        }
    }
    
    func testBusinessLogicScenarios() throws {
        // Test customer-facing scenarios
        XCTAssertTrue(DNSStatus.allCases.contains(.open)) // Ready for business
        XCTAssertTrue(DNSStatus.allCases.contains(.closed)) // Not available
        XCTAssertTrue(DNSStatus.allCases.contains(.comingSoon)) // Pre-launch
        XCTAssertTrue(DNSStatus.allCases.contains(.grandOpening)) // Special opening
        
        // Test operational scenarios
        XCTAssertTrue(DNSStatus.allCases.contains(.maintenance)) // System maintenance
        XCTAssertTrue(DNSStatus.allCases.contains(.training)) // Staff training
        XCTAssertTrue(DNSStatus.allCases.contains(.privateEvent)) // Exclusive access
        
        // Test external factor scenarios
        XCTAssertTrue(DNSStatus.allCases.contains(.badWeather)) // Weather closure
        XCTAssertTrue(DNSStatus.allCases.contains(.holiday)) // Holiday closure
        XCTAssertTrue(DNSStatus.allCases.contains(.tempClosed)) // Temporary closure
        
        // Test administrative scenarios
        XCTAssertTrue(DNSStatus.allCases.contains(.hidden)) // Not visible to public
    }
    
    func testStatusDistinction() throws {
        // Test that all status types are distinct
        XCTAssertNotEqual(DNSStatus.open, DNSStatus.closed)
        XCTAssertNotEqual(DNSStatus.maintenance, DNSStatus.training)
        XCTAssertNotEqual(DNSStatus.privateEvent, DNSStatus.holiday)
        XCTAssertNotEqual(DNSStatus.comingSoon, DNSStatus.grandOpening)
    }
    
    func testStatusCategories() throws {
        // Test availability categories
        let availableStatuses: [DNSStatus] = [.open, .grandOpening]
        let unavailableStatuses: [DNSStatus] = [.closed, .tempClosed, .maintenance, .badWeather]
        let specialStatuses: [DNSStatus] = [.privateEvent, .training, .holiday]
        let preliminaryStatuses: [DNSStatus] = [.comingSoon, .hidden]
        
        // Verify all categories have valid statuses
        for status in availableStatuses {
            XCTAssertTrue(DNSStatus.allCases.contains(status))
        }
        for status in unavailableStatuses {
            XCTAssertTrue(DNSStatus.allCases.contains(status))
        }
        for status in specialStatuses {
            XCTAssertTrue(DNSStatus.allCases.contains(status))
        }
        for status in preliminaryStatuses {
            XCTAssertTrue(DNSStatus.allCases.contains(status))
        }
    }
}