//
//  DNSMediaTypeTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSMediaTypeTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSMediaType] = [.image, .video, .audio, .document, .other]
        XCTAssertEqual(DNSMediaType.allCases.count, 5)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSMediaType.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSMediaType.image.rawValue, "image")
        XCTAssertEqual(DNSMediaType.video.rawValue, "video")
        XCTAssertEqual(DNSMediaType.audio.rawValue, "audio")
        XCTAssertEqual(DNSMediaType.document.rawValue, "document")
        XCTAssertEqual(DNSMediaType.other.rawValue, "other")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSMediaType(rawValue: "image"), .image)
        XCTAssertEqual(DNSMediaType(rawValue: "video"), .video)
        XCTAssertEqual(DNSMediaType(rawValue: "audio"), .audio)
        XCTAssertEqual(DNSMediaType(rawValue: "document"), .document)
        XCTAssertEqual(DNSMediaType(rawValue: "other"), .other)
        XCTAssertNil(DNSMediaType(rawValue: "invalid"))
    }
    
    func testMediaTypeClassification() throws {
        // Test that different media types are distinct
        XCTAssertNotEqual(DNSMediaType.image, DNSMediaType.video)
        XCTAssertNotEqual(DNSMediaType.video, DNSMediaType.audio)
        XCTAssertNotEqual(DNSMediaType.audio, DNSMediaType.document)
        XCTAssertNotEqual(DNSMediaType.document, DNSMediaType.other)
    }
    
    func testDefaultFallback() throws {
        // Test that 'other' can serve as a fallback for unknown types
        let fallbackType = DNSMediaType.other
        XCTAssertEqual(fallbackType.rawValue, "other")
    }
    
    func testStringRepresentation() throws {
        XCTAssertEqual("\(DNSMediaType.image)", "image")
        XCTAssertEqual("\(DNSMediaType.video)", "video")
    }
}