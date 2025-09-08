//
//  DNSReactionTypeTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

@testable import DNSDataTypes
import XCTest

final class DNSReactionTypeTests: XCTestCase {
    
    func testAllCases() throws {
        let expectedCases: [DNSReactionType] = [
            .unknown, .angered, .cared, .favorited, .humored, .liked, .loved, .saddened, .wowed
        ]
        
        XCTAssertEqual(DNSReactionType.allCases.count, expectedCases.count)
        
        for expectedCase in expectedCases {
            XCTAssertTrue(DNSReactionType.allCases.contains(expectedCase))
        }
    }
    
    func testRawValues() throws {
        XCTAssertEqual(DNSReactionType.unknown.rawValue, "unknown")
        XCTAssertEqual(DNSReactionType.angered.rawValue, "angered")
        XCTAssertEqual(DNSReactionType.cared.rawValue, "cared")
        XCTAssertEqual(DNSReactionType.favorited.rawValue, "favorited")
        XCTAssertEqual(DNSReactionType.humored.rawValue, "humored")
        XCTAssertEqual(DNSReactionType.liked.rawValue, "liked")
        XCTAssertEqual(DNSReactionType.loved.rawValue, "loved")
        XCTAssertEqual(DNSReactionType.saddened.rawValue, "saddened")
        XCTAssertEqual(DNSReactionType.wowed.rawValue, "wowed")
    }
    
    func testInitFromRawValue() throws {
        XCTAssertEqual(DNSReactionType(rawValue: "unknown"), .unknown)
        XCTAssertEqual(DNSReactionType(rawValue: "angered"), .angered)
        XCTAssertEqual(DNSReactionType(rawValue: "cared"), .cared)
        XCTAssertEqual(DNSReactionType(rawValue: "favorited"), .favorited)
        XCTAssertEqual(DNSReactionType(rawValue: "humored"), .humored)
        XCTAssertEqual(DNSReactionType(rawValue: "liked"), .liked)
        XCTAssertEqual(DNSReactionType(rawValue: "loved"), .loved)
        XCTAssertEqual(DNSReactionType(rawValue: "saddened"), .saddened)
        XCTAssertEqual(DNSReactionType(rawValue: "wowed"), .wowed)
    }
    
    func testInitFromInvalidRawValue() throws {
        XCTAssertNil(DNSReactionType(rawValue: "invalid"))
        XCTAssertNil(DNSReactionType(rawValue: ""))
        XCTAssertNil(DNSReactionType(rawValue: "LIKED"))  // Case sensitive
        XCTAssertNil(DNSReactionType(rawValue: "like"))   // Old format
    }
    
    func testCodableConformance() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // Test encoding each case
        for reactionType in DNSReactionType.allCases {
            let encoded = try encoder.encode(reactionType)
            let decoded = try decoder.decode(DNSReactionType.self, from: encoded)
            XCTAssertEqual(decoded, reactionType)
        }
    }
    
    func testJSONRepresentation() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // Test specific JSON values
        let liked = try encoder.encode(DNSReactionType.liked)
        let likedString = String(data: liked, encoding: .utf8)
        XCTAssertEqual(likedString, "\"liked\"")
        
        let loved = try encoder.encode(DNSReactionType.loved)
        let lovedString = String(data: loved, encoding: .utf8)
        XCTAssertEqual(lovedString, "\"loved\"")
        
        // Test decoding from JSON string
        let jsonData = "\"favorited\"".data(using: .utf8)!
        let decoded = try decoder.decode(DNSReactionType.self, from: jsonData)
        XCTAssertEqual(decoded, .favorited)
    }
    
    func testEquatable() throws {
        XCTAssertEqual(DNSReactionType.liked, DNSReactionType.liked)
        XCTAssertNotEqual(DNSReactionType.liked, DNSReactionType.loved)
        XCTAssertNotEqual(DNSReactionType.unknown, DNSReactionType.angered)
    }
    
    func testHashable() throws {
        let reactionSet: Set<DNSReactionType> = [.liked, .loved, .liked, .wowed]
        XCTAssertEqual(reactionSet.count, 3)  // Should deduplicate
        XCTAssertTrue(reactionSet.contains(.liked))
        XCTAssertTrue(reactionSet.contains(.loved))
        XCTAssertTrue(reactionSet.contains(.wowed))
    }
    
    func testCaseIterableOrdering() throws {
        // Test that the order is consistent
        let cases = DNSReactionType.allCases
        XCTAssertEqual(cases[0], .unknown)
        XCTAssertEqual(cases[1], .angered)
        XCTAssertEqual(cases[2], .cared)
        XCTAssertEqual(cases[3], .favorited)
        XCTAssertEqual(cases[4], .humored)
        XCTAssertEqual(cases[5], .liked)
        XCTAssertEqual(cases[6], .loved)
        XCTAssertEqual(cases[7], .saddened)
        XCTAssertEqual(cases[8], .wowed)
    }
    
    func testPositiveReactions() throws {
        let positiveReactions: Set<DNSReactionType> = [.liked, .loved, .cared, .favorited, .humored, .wowed]
        
        XCTAssertTrue(positiveReactions.contains(.liked))
        XCTAssertTrue(positiveReactions.contains(.loved))
        XCTAssertTrue(positiveReactions.contains(.cared))
        XCTAssertTrue(positiveReactions.contains(.favorited))
        XCTAssertTrue(positiveReactions.contains(.humored))
        XCTAssertTrue(positiveReactions.contains(.wowed))
        
        XCTAssertFalse(positiveReactions.contains(.angered))
        XCTAssertFalse(positiveReactions.contains(.saddened))
        XCTAssertFalse(positiveReactions.contains(.unknown))
    }
    
    func testNegativeReactions() throws {
        let negativeReactions: Set<DNSReactionType> = [.angered, .saddened]
        
        XCTAssertTrue(negativeReactions.contains(.angered))
        XCTAssertTrue(negativeReactions.contains(.saddened))
        
        XCTAssertFalse(negativeReactions.contains(.liked))
        XCTAssertFalse(negativeReactions.contains(.loved))
        XCTAssertFalse(negativeReactions.contains(.unknown))
    }
    
    func testUnknownCase() throws {
        // Test that unknown is properly handled
        XCTAssertEqual(DNSReactionType.unknown.rawValue, "unknown")
        
        // Test that invalid raw values default to unknown in practical usage
        let invalidReaction = DNSReactionType(rawValue: "invalid_reaction")
        XCTAssertNil(invalidReaction)
        
        // But we can explicitly create unknown
        let unknownReaction = DNSReactionType.unknown
        XCTAssertEqual(unknownReaction, .unknown)
    }
}