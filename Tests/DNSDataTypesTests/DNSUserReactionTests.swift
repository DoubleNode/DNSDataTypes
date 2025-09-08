//
//  DNSUserReactionTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSUserReactionTests: XCTestCase {
    
    func testDefaultInitialization() throws {
        let reaction = DNSUserReaction()
        
        XCTAssertEqual(reaction.userId, "")
        XCTAssertFalse(reaction.created)
        XCTAssertNil(reaction.reaction)
        XCTAssertNil(reaction.reactionOn)
        XCTAssertFalse(reaction.updated)
        XCTAssertFalse(reaction.viewed)
        XCTAssertNil(reaction.viewedOn)
    }
    
    func testCopyInitialization() throws {
        let original = DNSUserReaction()
        original.userId = "user123"
        original.created = true
        original.reaction = .liked
        original.reactionOn = Date()
        original.updated = true
        original.viewed = true
        original.viewedOn = Date()
        
        let copy = DNSUserReaction(from: original)
        
        XCTAssertEqual(copy.userId, original.userId)
        XCTAssertEqual(copy.created, original.created)
        XCTAssertEqual(copy.reaction, original.reaction)
        XCTAssertEqual(copy.reactionOn, original.reactionOn)
        XCTAssertEqual(copy.updated, original.updated)
        XCTAssertEqual(copy.viewed, original.viewed)
        XCTAssertEqual(copy.viewedOn, original.viewedOn)
        
        // Ensure they are different instances
        XCTAssertTrue(copy !== original)
    }
    
    func testUpdateMethod() throws {
        let reaction1 = DNSUserReaction()
        reaction1.userId = "user456"
        reaction1.created = true
        reaction1.reaction = .loved
        reaction1.reactionOn = Date()
        reaction1.updated = false
        reaction1.viewed = true
        reaction1.viewedOn = Date()
        
        let reaction2 = DNSUserReaction()
        reaction2.update(from: reaction1)
        
        XCTAssertEqual(reaction2.userId, reaction1.userId)
        XCTAssertEqual(reaction2.created, reaction1.created)
        XCTAssertEqual(reaction2.reaction, reaction1.reaction)
        XCTAssertEqual(reaction2.reactionOn, reaction1.reactionOn)
        XCTAssertEqual(reaction2.updated, reaction1.updated)
        XCTAssertEqual(reaction2.viewed, reaction1.viewed)
        XCTAssertEqual(reaction2.viewedOn, reaction1.viewedOn)
    }
    
    func testDAOInitFromDictionary() throws {
        let testDate = Date()
        let data: DNSDataDictionary = [
            "userId": "user789",
            "created": true,
            "reaction": "favorited",
            "reactionOn": testDate,
            "updated": false,
            "viewed": true,
            "viewedOn": testDate
        ]
        
        let reaction = DNSUserReaction(from: data)
        
        XCTAssertEqual(reaction.userId, "user789")
        XCTAssertTrue(reaction.created)
        XCTAssertEqual(reaction.reaction, .favorited)
        XCTAssertEqual(reaction.reactionOn, testDate)
        XCTAssertFalse(reaction.updated)
        XCTAssertTrue(reaction.viewed)
        XCTAssertEqual(reaction.viewedOn, testDate)
    }
    
    func testDAOFromMethod() throws {
        let reaction = DNSUserReaction()
        let testDate = Date()
        let data: DNSDataDictionary = [
            "userId": "user999",
            "created": false,
            "reaction": "angered",
            "reactionOn": testDate,
            "updated": true,
            "viewed": false,
            "viewedOn": testDate
        ]
        
        let result = reaction.dao(from: data)
        
        // Should return self and modify the instance
        XCTAssertTrue(result === reaction)
        XCTAssertEqual(reaction.userId, "user999")
        XCTAssertFalse(reaction.created)
        XCTAssertEqual(reaction.reaction, .angered)
        XCTAssertEqual(reaction.reactionOn, testDate)
        XCTAssertTrue(reaction.updated)
        XCTAssertFalse(reaction.viewed)
        XCTAssertEqual(reaction.viewedOn, testDate)
    }
    
    func testAsDictionary() throws {
        let testDate = Date()
        let reaction = DNSUserReaction()
        reaction.userId = "userABC"
        reaction.created = true
        reaction.reaction = .wowed
        reaction.reactionOn = testDate
        reaction.updated = false
        reaction.viewed = true
        reaction.viewedOn = testDate
        
        let dictionary = reaction.asDictionary
        
        XCTAssertEqual(dictionary["userId"] as? String, "userABC")
        XCTAssertEqual(dictionary["created"] as? Bool, true)
        XCTAssertEqual(dictionary["reaction"] as? String, "wowed")
        XCTAssertEqual(dictionary["reactionOn"] as? Date, testDate)
        XCTAssertEqual(dictionary["updated"] as? Bool, false)
        XCTAssertEqual(dictionary["viewed"] as? Bool, true)
        XCTAssertEqual(dictionary["viewedOn"] as? Date, testDate)
    }
    
    func testCodableConformance() throws {
        let testDate = Date()
        let reaction = DNSUserReaction()
        reaction.userId = "userDEF"
        reaction.created = false
        reaction.reaction = .saddened
        reaction.reactionOn = testDate
        reaction.updated = true
        reaction.viewed = false
        reaction.viewedOn = testDate
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(reaction)
        let decoded = try decoder.decode(DNSUserReaction.self, from: encoded)
        
        XCTAssertEqual(decoded.userId, reaction.userId)
        XCTAssertEqual(decoded.created, reaction.created)
        XCTAssertEqual(decoded.reaction, reaction.reaction)
        XCTAssertEqual(decoded.updated, reaction.updated)
        XCTAssertEqual(decoded.viewed, reaction.viewed)
    }
    
    func testJSONDecodingWithMissingFields() throws {
        let json = """
        {
            "userId": "userGHI",
            "reaction": "cared"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let reaction = try decoder.decode(DNSUserReaction.self, from: json)
        
        XCTAssertEqual(reaction.userId, "userGHI")
        XCTAssertEqual(reaction.reaction, .cared)
        XCTAssertFalse(reaction.created)
        XCTAssertNil(reaction.reactionOn)
        XCTAssertFalse(reaction.updated)
        XCTAssertFalse(reaction.viewed)
        XCTAssertNil(reaction.viewedOn)
    }
    
    func testNSCopyingConformance() throws {
        let reaction = DNSUserReaction()
        reaction.userId = "userJKL"
        reaction.created = true
        reaction.reaction = .humored
        reaction.updated = false
        reaction.viewed = true
        
        let copy = reaction.copy() as! DNSUserReaction
        
        XCTAssertEqual(copy.userId, reaction.userId)
        XCTAssertEqual(copy.created, reaction.created)
        XCTAssertEqual(copy.reaction, reaction.reaction)
        XCTAssertEqual(copy.updated, reaction.updated)
        XCTAssertEqual(copy.viewed, reaction.viewed)
        
        // Ensure they are different instances
        XCTAssertTrue(copy !== reaction)
    }
    
    func testEquatableProtocol() throws {
        let reaction1 = DNSUserReaction()
        reaction1.userId = "userMNO"
        reaction1.reaction = .liked
        reaction1.created = true
        
        let reaction2 = DNSUserReaction()
        reaction2.userId = "userMNO"
        reaction2.reaction = .liked
        reaction2.created = true
        
        let reaction3 = DNSUserReaction()
        reaction3.userId = "userPQR"
        reaction3.reaction = .liked
        reaction3.created = true
        
        XCTAssertTrue(reaction1 == reaction2)
        XCTAssertFalse(reaction1 == reaction3)
        XCTAssertFalse(reaction1 != reaction2)
        XCTAssertTrue(reaction1 != reaction3)
    }
    
    func testIsDiffFromMethod() throws {
        let reaction1 = DNSUserReaction()
        reaction1.userId = "userSTU"
        reaction1.reaction = .loved
        reaction1.created = false
        
        let reaction2 = DNSUserReaction()
        reaction2.userId = "userSTU"
        reaction2.reaction = .loved
        reaction2.created = false
        
        let reaction3 = DNSUserReaction()
        reaction3.userId = "userVWX"
        reaction3.reaction = .loved
        reaction3.created = false
        
        XCTAssertFalse(reaction1.isDiffFrom(reaction2))
        XCTAssertTrue(reaction1.isDiffFrom(reaction3))
        XCTAssertTrue(reaction1.isDiffFrom("not a reaction object"))
        XCTAssertTrue(reaction1.isDiffFrom(nil))
    }
    
    func testReactionTypeConvenienceProperties() throws {
        let reaction = DNSUserReaction()
        
        // Test each reaction type
        reaction.reaction = .angered
        XCTAssertTrue(reaction.isAngered)
        XCTAssertFalse(reaction.isCared)
        
        reaction.reaction = .cared
        XCTAssertFalse(reaction.isAngered)
        XCTAssertTrue(reaction.isCared)
        
        reaction.reaction = .favorited
        XCTAssertTrue(reaction.isFavorited)
        
        reaction.reaction = .humored
        XCTAssertTrue(reaction.isHumored)
        
        reaction.reaction = .liked
        XCTAssertTrue(reaction.isLiked)
        
        reaction.reaction = .loved
        XCTAssertTrue(reaction.isLoved)
        
        reaction.reaction = .saddened
        XCTAssertTrue(reaction.isSaddened)
        
        reaction.reaction = .wowed
        XCTAssertTrue(reaction.isWowed)
        
        reaction.reaction = nil
        XCTAssertFalse(reaction.isAngered)
        XCTAssertFalse(reaction.isLiked)
        XCTAssertFalse(reaction.isLoved)
    }
    
    func testDAOFromWithInvalidTypes() throws {
        let reaction = DNSUserReaction()
        let data: DNSDataDictionary = [
            "userId": 12345, // Invalid type
            "created": "not a boolean",
            "reaction": 999,
            "updated": "false",
            "viewed": 0
        ]
        
        _ = reaction.dao(from: data)
        
        // Should handle invalid types gracefully (DNSDataTranslation handles this)
        XCTAssertEqual(reaction.userId, "")
        XCTAssertFalse(reaction.created)
        XCTAssertEqual(reaction.reaction, .unknown)
        XCTAssertFalse(reaction.updated)
        XCTAssertFalse(reaction.viewed)
    }
    
    func testDAOFromWithMissingKeys() throws {
        let reaction = DNSUserReaction()
        reaction.userId = "originalUser"
        reaction.created = true
        reaction.reaction = .liked
        
        let data: DNSDataDictionary = [
            "userId": "newUser"
        ]
        
        _ = reaction.dao(from: data)
        
        // Should only update userId, keep original values for missing keys
        XCTAssertEqual(reaction.userId, "newUser")
        XCTAssertTrue(reaction.created)
        XCTAssertEqual(reaction.reaction, .liked)
    }
    
    func testBusinessLogicScenarios() throws {
        // Test user changing reaction
        let reaction = DNSUserReaction()
        reaction.userId = "user123"
        reaction.reaction = .liked
        reaction.reactionOn = Date()
        reaction.created = true
        
        // User changes to love
        reaction.reaction = .loved
        reaction.updated = true
        
        XCTAssertTrue(reaction.isLoved)
        XCTAssertFalse(reaction.isLiked)
        XCTAssertTrue(reaction.updated)
        
        // User views the content
        reaction.viewed = true
        reaction.viewedOn = Date()
        
        XCTAssertTrue(reaction.viewed)
        XCTAssertNotNil(reaction.viewedOn)
    }
    
    func testFieldMapping() throws {
        let reaction = DNSUserReaction()
        
        // Test that field mapping is working correctly by using raw CodingKeys
        let data: DNSDataDictionary = [
            DNSUserReaction.CodingKeys.userId.rawValue: "testUser",
            DNSUserReaction.CodingKeys.reaction.rawValue: "favorited",
            DNSUserReaction.CodingKeys.created.rawValue: true
        ]
        
        _ = reaction.dao(from: data)
        
        XCTAssertEqual(reaction.userId, "testUser")
        XCTAssertEqual(reaction.reaction, .favorited)
        XCTAssertTrue(reaction.created)
    }
}
