//
//  DNSReactionCountsTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSReactionCountsTests: XCTestCase {
    
    func testDefaultInitialization() throws {
        let counts = DNSReactionCounts()
        
        XCTAssertEqual(counts.angered, 0)
        XCTAssertEqual(counts.cared, 0)
        XCTAssertEqual(counts.favorited, 0)
        XCTAssertEqual(counts.humored, 0)
        XCTAssertEqual(counts.liked, 0)
        XCTAssertEqual(counts.loved, 0)
        XCTAssertEqual(counts.saddened, 0)
        XCTAssertEqual(counts.wowed, 0)
    }
    
    func testCopyInitialization() throws {
        let original = DNSReactionCounts()
        original.angered = 5
        original.cared = 10
        original.favorited = 15
        original.humored = 20
        original.liked = 25
        original.loved = 30
        original.saddened = 35
        original.wowed = 40
        
        let copy = DNSReactionCounts(from: original)
        
        XCTAssertEqual(copy.angered, original.angered)
        XCTAssertEqual(copy.cared, original.cared)
        XCTAssertEqual(copy.favorited, original.favorited)
        XCTAssertEqual(copy.humored, original.humored)
        XCTAssertEqual(copy.liked, original.liked)
        XCTAssertEqual(copy.loved, original.loved)
        XCTAssertEqual(copy.saddened, original.saddened)
        XCTAssertEqual(copy.wowed, original.wowed)
        
        // Ensure they are different instances
        XCTAssertTrue(copy !== original)
    }
    
    func testUpdateMethod() throws {
        let counts1 = DNSReactionCounts()
        counts1.angered = 1
        counts1.cared = 2
        counts1.favorited = 3
        counts1.humored = 4
        counts1.liked = 5
        counts1.loved = 6
        counts1.saddened = 7
        counts1.wowed = 8
        
        let counts2 = DNSReactionCounts()
        counts2.update(from: counts1)
        
        XCTAssertEqual(counts2.angered, 1)
        XCTAssertEqual(counts2.cared, 2)
        XCTAssertEqual(counts2.favorited, 3)
        XCTAssertEqual(counts2.humored, 4)
        XCTAssertEqual(counts2.liked, 5)
        XCTAssertEqual(counts2.loved, 6)
        XCTAssertEqual(counts2.saddened, 7)
        XCTAssertEqual(counts2.wowed, 8)
    }
    
    func testDAOInitFromDictionary() throws {
        let data: DNSDataDictionary = [
            "angered": UInt(100),
            "cared": UInt(200),
            "favorited": UInt(300),
            "humored": UInt(400),
            "liked": UInt(500),
            "loved": UInt(600),
            "saddened": UInt(700),
            "wowed": UInt(800)
        ]
        
        let counts = DNSReactionCounts(from: data)
        
        XCTAssertEqual(counts.angered, 100)
        XCTAssertEqual(counts.cared, 200)
        XCTAssertEqual(counts.favorited, 300)
        XCTAssertEqual(counts.humored, 400)
        XCTAssertEqual(counts.liked, 500)
        XCTAssertEqual(counts.loved, 600)
        XCTAssertEqual(counts.saddened, 700)
        XCTAssertEqual(counts.wowed, 800)
    }
    
    func testDAOFromMethod() throws {
        let counts = DNSReactionCounts()
        let data: DNSDataDictionary = [
            "angered": UInt(50),
            "cared": UInt(60),
            "favorited": UInt(70),
            "humored": UInt(80),
            "liked": UInt(90),
            "loved": UInt(100),
            "saddened": UInt(110),
            "wowed": UInt(120)
        ]
        
        let result = counts.dao(from: data)
        
        // Should return self and modify the instance
        XCTAssertTrue(result === counts)
        XCTAssertEqual(counts.angered, 50)
        XCTAssertEqual(counts.cared, 60)
        XCTAssertEqual(counts.favorited, 70)
        XCTAssertEqual(counts.humored, 80)
        XCTAssertEqual(counts.liked, 90)
        XCTAssertEqual(counts.loved, 100)
        XCTAssertEqual(counts.saddened, 110)
        XCTAssertEqual(counts.wowed, 120)
    }
    
    func testAsDictionary() throws {
        let counts = DNSReactionCounts()
        counts.angered = 11
        counts.cared = 12
        counts.favorited = 13
        counts.humored = 14
        counts.liked = 15
        counts.loved = 16
        counts.saddened = 17
        counts.wowed = 18
        
        let dictionary = counts.asDictionary
        
        XCTAssertEqual(dictionary["angered"] as? UInt, 11)
        XCTAssertEqual(dictionary["cared"] as? UInt, 12)
        XCTAssertEqual(dictionary["favorited"] as? UInt, 13)
        XCTAssertEqual(dictionary["humored"] as? UInt, 14)
        XCTAssertEqual(dictionary["liked"] as? UInt, 15)
        XCTAssertEqual(dictionary["loved"] as? UInt, 16)
        XCTAssertEqual(dictionary["saddened"] as? UInt, 17)
        XCTAssertEqual(dictionary["wowed"] as? UInt, 18)
    }
    
    func testCodableConformance() throws {
        let counts = DNSReactionCounts()
        counts.angered = 111
        counts.cared = 222
        counts.favorited = 333
        counts.humored = 444
        counts.liked = 555
        counts.loved = 666
        counts.saddened = 777
        counts.wowed = 888
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(counts)
        let decoded = try decoder.decode(DNSReactionCounts.self, from: encoded)
        
        XCTAssertEqual(decoded.angered, counts.angered)
        XCTAssertEqual(decoded.cared, counts.cared)
        XCTAssertEqual(decoded.favorited, counts.favorited)
        XCTAssertEqual(decoded.humored, counts.humored)
        XCTAssertEqual(decoded.liked, counts.liked)
        XCTAssertEqual(decoded.loved, counts.loved)
        XCTAssertEqual(decoded.saddened, counts.saddened)
        XCTAssertEqual(decoded.wowed, counts.wowed)
    }
    
    func testJSONDecodingWithMissingFields() throws {
        let json = """
        {
            "liked": 1000,
            "loved": 2000
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let counts = try decoder.decode(DNSReactionCounts.self, from: json)
        
        XCTAssertEqual(counts.liked, 1000)
        XCTAssertEqual(counts.loved, 2000)
        XCTAssertEqual(counts.angered, 0)
        XCTAssertEqual(counts.cared, 0)
        XCTAssertEqual(counts.favorited, 0)
        XCTAssertEqual(counts.humored, 0)
        XCTAssertEqual(counts.saddened, 0)
        XCTAssertEqual(counts.wowed, 0)
    }
    
    func testNSCopyingConformance() throws {
        let counts = DNSReactionCounts()
        counts.angered = 99
        counts.cared = 88
        counts.favorited = 77
        counts.humored = 66
        counts.liked = 55
        counts.loved = 44
        counts.saddened = 33
        counts.wowed = 22
        
        let copy = counts.copy() as! DNSReactionCounts
        
        XCTAssertEqual(copy.angered, counts.angered)
        XCTAssertEqual(copy.cared, counts.cared)
        XCTAssertEqual(copy.favorited, counts.favorited)
        XCTAssertEqual(copy.humored, counts.humored)
        XCTAssertEqual(copy.liked, counts.liked)
        XCTAssertEqual(copy.loved, counts.loved)
        XCTAssertEqual(copy.saddened, counts.saddened)
        XCTAssertEqual(copy.wowed, counts.wowed)
        
        // Ensure they are different instances
        XCTAssertTrue(copy !== counts)
    }
    
    func testEquatableProtocol() throws {
        let counts1 = DNSReactionCounts()
        counts1.liked = 100
        counts1.loved = 200
        
        let counts2 = DNSReactionCounts()
        counts2.liked = 100
        counts2.loved = 200
        
        let counts3 = DNSReactionCounts()
        counts3.liked = 101
        counts3.loved = 200
        
        XCTAssertTrue(counts1 == counts2)
        XCTAssertFalse(counts1 == counts3)
        XCTAssertFalse(counts1 != counts2)
        XCTAssertTrue(counts1 != counts3)
    }
    
    func testIsDiffFromMethod() throws {
        let counts1 = DNSReactionCounts()
        counts1.liked = 500
        counts1.loved = 600
        
        let counts2 = DNSReactionCounts()
        counts2.liked = 500
        counts2.loved = 600
        
        let counts3 = DNSReactionCounts()
        counts3.liked = 501
        counts3.loved = 600
        
        XCTAssertFalse(counts1.isDiffFrom(counts2))
        XCTAssertTrue(counts1.isDiffFrom(counts3))
        XCTAssertTrue(counts1.isDiffFrom("not a counts object"))
        XCTAssertTrue(counts1.isDiffFrom(nil))
    }
    
    func testDAOFromWithInvalidTypes() throws {
        let counts = DNSReactionCounts()
        let data: DNSDataDictionary = [
            "liked": "not a number",
            "loved": 500,
            "angered": true,
            "cared": 3.14
        ]
        
        _ = counts.dao(from: data)
        
        // Should handle invalid types gracefully (DNSDataTranslation handles this)
        XCTAssertEqual(counts.liked, 0)
        XCTAssertEqual(counts.loved, 500)
        XCTAssertEqual(counts.angered, 0)
        XCTAssertEqual(counts.cared, 0)
    }
    
    func testDAOFromWithMissingKeys() throws {
        let counts = DNSReactionCounts()
        counts.liked = 100
        counts.loved = 200
        counts.angered = 300
        
        let data: DNSDataDictionary = [
            "liked": UInt(150)
        ]
        
        _ = counts.dao(from: data)
        
        // Should only update liked, keep original values for missing keys
        XCTAssertEqual(counts.liked, 150)
        XCTAssertEqual(counts.loved, 200)
        XCTAssertEqual(counts.angered, 300)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test analytics tracking for social media post
        let postCounts = DNSReactionCounts()
        postCounts.liked = 1250
        postCounts.loved = 890
        postCounts.wowed = 45
        postCounts.humored = 320
        postCounts.saddened = 12
        postCounts.angered = 8
        postCounts.cared = 156
        postCounts.favorited = 234
        
        // Calculate total reactions
        let total = postCounts.liked + postCounts.loved + postCounts.wowed + 
                   postCounts.humored + postCounts.saddened + postCounts.angered + 
                   postCounts.cared + postCounts.favorited
        
        XCTAssertEqual(total, 2915)
        
        // Most popular reactions
        XCTAssertTrue(postCounts.liked > postCounts.loved)
        XCTAssertTrue(postCounts.loved > postCounts.humored)
        XCTAssertTrue(postCounts.angered < postCounts.saddened)
        
        // Test copy and modify
        let copy = DNSReactionCounts(from: postCounts)
        copy.liked += 50
        
        XCTAssertNotEqual(copy.liked, postCounts.liked)
        XCTAssertTrue(copy != postCounts)
    }
    
    func testPerformanceWithLargeNumbers() throws {
        // Test with large numbers (millions of reactions)
        let viralContent = DNSReactionCounts()
        viralContent.liked = 5_000_000
        viralContent.loved = 2_500_000
        viralContent.wowed = 1_000_000
        viralContent.humored = 750_000
        viralContent.cared = 500_000
        viralContent.favorited = 300_000
        viralContent.saddened = 100_000
        viralContent.angered = 50_000
        
        XCTAssertEqual(viralContent.liked, 5_000_000)
        XCTAssertEqual(viralContent.loved, 2_500_000)
        
        // Test dictionary conversion with large numbers
        let dictionary = viralContent.asDictionary
        XCTAssertEqual(dictionary["liked"] as? UInt, 5_000_000)
        XCTAssertEqual(dictionary["loved"] as? UInt, 2_500_000)
    }
    
    func testFieldMapping() throws {
        let counts = DNSReactionCounts()
        
        // Test that field mapping is working correctly by using raw CodingKeys
        let data: DNSDataDictionary = [
            DNSReactionCounts.CodingKeys.liked.rawValue: UInt(123),
            DNSReactionCounts.CodingKeys.loved.rawValue: UInt(456),
            DNSReactionCounts.CodingKeys.wowed.rawValue: UInt(789)
        ]
        
        _ = counts.dao(from: data)
        
        XCTAssertEqual(counts.liked, 123)
        XCTAssertEqual(counts.loved, 456)
        XCTAssertEqual(counts.wowed, 789)
    }
    
    func testZeroValues() throws {
        let counts = DNSReactionCounts()
        
        // Explicitly test zero handling
        let data: DNSDataDictionary = [
            "liked": UInt(0),
            "loved": UInt(0)
        ]
        
        _ = counts.dao(from: data)
        
        XCTAssertEqual(counts.liked, 0)
        XCTAssertEqual(counts.loved, 0)
        
        // Test that zero values are properly encoded/decoded
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(counts)
        let decoded = try decoder.decode(DNSReactionCounts.self, from: encoded)
        
        XCTAssertEqual(decoded.liked, 0)
        XCTAssertEqual(decoded.loved, 0)
    }
    
    func testIndividualReactionFields() throws {
        let counts = DNSReactionCounts()
        
        // Test each field individually
        counts.angered = 1
        XCTAssertEqual(counts.angered, 1)
        
        counts.cared = 2
        XCTAssertEqual(counts.cared, 2)
        
        counts.favorited = 3
        XCTAssertEqual(counts.favorited, 3)
        
        counts.humored = 4
        XCTAssertEqual(counts.humored, 4)
        
        counts.liked = 5
        XCTAssertEqual(counts.liked, 5)
        
        counts.loved = 6
        XCTAssertEqual(counts.loved, 6)
        
        counts.saddened = 7
        XCTAssertEqual(counts.saddened, 7)
        
        counts.wowed = 8
        XCTAssertEqual(counts.wowed, 8)
    }
}
