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
        let expectedCases: [DNSMediaType] = [.unknown, .animatedImage, .pdfDocument, .staticImage, .text, .video]
        XCTAssertEqual(DNSMediaType.allCases.count, 6)
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSMediaType.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSMediaType.unknown.rawValue, "unknown")
        XCTAssertEqual(DNSMediaType.animatedImage.rawValue, "animatedImage")
        XCTAssertEqual(DNSMediaType.pdfDocument.rawValue, "pdfDocument")
        XCTAssertEqual(DNSMediaType.staticImage.rawValue, "staticImage")
        XCTAssertEqual(DNSMediaType.text.rawValue, "text")
        XCTAssertEqual(DNSMediaType.video.rawValue, "video")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSMediaType(rawValue: "unknown"), .unknown)
        XCTAssertEqual(DNSMediaType(rawValue: "animatedImage"), .animatedImage)
        XCTAssertEqual(DNSMediaType(rawValue: "pdfDocument"), .pdfDocument)
        XCTAssertEqual(DNSMediaType(rawValue: "staticImage"), .staticImage)
        XCTAssertEqual(DNSMediaType(rawValue: "text"), .text)
        XCTAssertEqual(DNSMediaType(rawValue: "video"), .video)
        XCTAssertNil(DNSMediaType(rawValue: "invalid"))
    }
    
    func testMediaTypeClassification() throws {
        // Test that different media types are distinct
        XCTAssertNotEqual(DNSMediaType.unknown, DNSMediaType.video)
        XCTAssertNotEqual(DNSMediaType.video, DNSMediaType.text)
        XCTAssertNotEqual(DNSMediaType.staticImage, DNSMediaType.animatedImage)
        XCTAssertNotEqual(DNSMediaType.pdfDocument, DNSMediaType.text)
    }
    
    func testDefaultFallback() throws {
        // Test that 'unknown' can serve as a fallback for unrecognized types
        let fallbackType = DNSMediaType.unknown
        XCTAssertEqual(fallbackType.rawValue, "unknown")
    }
    
    func testStringRepresentation() throws {
        XCTAssertEqual("\(DNSMediaType.staticImage)", "staticImage")
        XCTAssertEqual("\(DNSMediaType.video)", "video")
    }
}