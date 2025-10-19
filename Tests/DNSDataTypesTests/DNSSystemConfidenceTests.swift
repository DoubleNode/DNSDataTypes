//
//  DNSSystemConfidenceTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSSystemConfidenceTests: XCTestCase {

    func testAllCases() throws {
        let expectedCases: [DNSSystemConfidence] = [.none, .insufficient, .low, .medium, .high]
        XCTAssertEqual(DNSSystemConfidence.allCases.count, 5)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSSystemConfidence.allCases.contains(expectedCase))
        }
    }

    func testRawValues() throws {
        XCTAssertEqual(DNSSystemConfidence.none.rawValue, "none")
        XCTAssertEqual(DNSSystemConfidence.insufficient.rawValue, "insufficient")
        XCTAssertEqual(DNSSystemConfidence.low.rawValue, "low")
        XCTAssertEqual(DNSSystemConfidence.medium.rawValue, "medium")
        XCTAssertEqual(DNSSystemConfidence.high.rawValue, "high")
    }

    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSSystemConfidence(rawValue: "none")!, .none)
        XCTAssertEqual(DNSSystemConfidence(rawValue: "insufficient")!, .insufficient)
        XCTAssertEqual(DNSSystemConfidence(rawValue: "low")!, .low)
        XCTAssertEqual(DNSSystemConfidence(rawValue: "medium")!, .medium)
        XCTAssertEqual(DNSSystemConfidence(rawValue: "high")!, .high)
        XCTAssertNil(DNSSystemConfidence(rawValue: "invalid"))
    }

    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        for confidence in DNSSystemConfidence.allCases {
            let encoded = try encoder.encode(confidence)
            let decoded = try decoder.decode(DNSSystemConfidence.self, from: encoded)
            XCTAssertEqual(decoded, confidence)
        }
    }

    func testConfidenceLevels() throws {
        // Test that all confidence levels are distinct
        XCTAssertNotEqual(DNSSystemConfidence.none, DNSSystemConfidence.insufficient)
        XCTAssertNotEqual(DNSSystemConfidence.insufficient, DNSSystemConfidence.low)
        XCTAssertNotEqual(DNSSystemConfidence.low, DNSSystemConfidence.medium)
        XCTAssertNotEqual(DNSSystemConfidence.medium, DNSSystemConfidence.high)
    }

    func testDefaultConfidence() throws {
        // Verify none is a valid default confidence level
        let defaultConfidence = DNSSystemConfidence.none
        XCTAssertEqual(defaultConfidence.rawValue, "none")
    }

    func testConfidenceCategories() throws {
        // Test no confidence states
        let noConfidenceStates: [DNSSystemConfidence] = [.none, .insufficient]
        for state in noConfidenceStates {
            XCTAssertTrue(DNSSystemConfidence.allCases.contains(state))
        }

        // Test low to medium confidence states
        let moderateConfidenceStates: [DNSSystemConfidence] = [.low, .medium]
        for state in moderateConfidenceStates {
            XCTAssertTrue(DNSSystemConfidence.allCases.contains(state))
        }

        // Test high confidence states
        let highConfidenceStates: [DNSSystemConfidence] = [.high]
        for state in highConfidenceStates {
            XCTAssertTrue(DNSSystemConfidence.allCases.contains(state))
        }
    }

    func testConfidenceOrdering() throws {
        // Test that confidence levels exist in expected order
        let orderedCases = DNSSystemConfidence.allCases
        XCTAssertEqual(orderedCases[0], .none)
        XCTAssertEqual(orderedCases[1], .insufficient)
        XCTAssertEqual(orderedCases[2], .low)
        XCTAssertEqual(orderedCases[3], .medium)
        XCTAssertEqual(orderedCases[4], .high)
    }

    func testBusinessLogicScenarios() throws {
        // Test confidence level scenarios for system decision making
        XCTAssertTrue(DNSSystemConfidence.allCases.contains(.none)) // No confidence, unknown state
        XCTAssertTrue(DNSSystemConfidence.allCases.contains(.insufficient)) // Not enough data
        XCTAssertTrue(DNSSystemConfidence.allCases.contains(.low)) // Limited confidence
        XCTAssertTrue(DNSSystemConfidence.allCases.contains(.medium)) // Moderate confidence
        XCTAssertTrue(DNSSystemConfidence.allCases.contains(.high)) // Strong confidence
    }

    func testConfidenceThresholds() throws {
        // Test threshold-based logic scenarios
        let actionableConfidenceLevels: [DNSSystemConfidence] = [.medium, .high]
        let insufficientConfidenceLevels: [DNSSystemConfidence] = [.none, .insufficient, .low]

        // Verify actionable confidence levels
        for level in actionableConfidenceLevels {
            XCTAssertTrue(DNSSystemConfidence.allCases.contains(level))
        }

        // Verify insufficient confidence levels
        for level in insufficientConfidenceLevels {
            XCTAssertTrue(DNSSystemConfidence.allCases.contains(level))
        }

        // Ensure categories are mutually exclusive
        for actionable in actionableConfidenceLevels {
            for insufficient in insufficientConfidenceLevels {
                XCTAssertNotEqual(actionable, insufficient)
            }
        }
    }

    func testJSONEncoding() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        // Test encoding all confidence levels
        for confidence in DNSSystemConfidence.allCases {
            let encoded = try encoder.encode(confidence)
            let jsonString = String(data: encoded, encoding: .utf8)
            XCTAssertNotNil(jsonString)
            XCTAssertTrue(jsonString!.contains("\"\(confidence.rawValue)\""))
        }
    }

    func testJSONDecoding() throws {
        let decoder = JSONDecoder()

        // Test decoding from JSON strings
        let testCases: [(String, DNSSystemConfidence)] = [
            ("\"none\"", .none),
            ("\"insufficient\"", .insufficient),
            ("\"low\"", .low),
            ("\"medium\"", .medium),
            ("\"high\"", .high)
        ]

        for (jsonString, expectedValue) in testCases {
            let data = jsonString.data(using: .utf8)!
            let decoded = try decoder.decode(DNSSystemConfidence.self, from: data)
            XCTAssertEqual(decoded, expectedValue)
        }
    }

    func testInvalidJSONDecoding() throws {
        let decoder = JSONDecoder()
        let invalidJSON = "\"invalidConfidence\"".data(using: .utf8)!

        XCTAssertThrowsError(try decoder.decode(DNSSystemConfidence.self, from: invalidJSON)) { error in
            // Verify that decoding invalid value throws an error
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testCaseIterationCompleteness() throws {
        // Ensure allCases contains exactly the expected number of cases
        let allCases = DNSSystemConfidence.allCases
        XCTAssertEqual(allCases.count, 5)

        // Verify no duplicates in allCases
        let uniqueCases = Set(allCases.map { $0.rawValue })
        XCTAssertEqual(uniqueCases.count, allCases.count)
    }
}
