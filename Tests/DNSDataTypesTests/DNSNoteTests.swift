//
//  DNSNoteTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
@testable import DNSDataTypes
import XCTest

final class DNSNoteTests: XCTestCase {
    
    func testDefaultInitialization() throws {
        let note = DNSNote()
        
        XCTAssertNotNil(note.body)
        XCTAssertEqual(note.distribution, .everyone)
        XCTAssertEqual(note.priority, DNSPriority.normal)
    }
    
    func testConvenienceInitialization() throws {
        let body = DNSString(with: "Test note content")
        let note = DNSNote(body: body, distribution: .staffOnly, priority: DNSPriority.high)
        
        XCTAssertEqual(note.body.asString, "Test note content")
        XCTAssertEqual(note.distribution, .staffOnly)
        XCTAssertEqual(note.priority, DNSPriority.high)
    }
    
    func testCopyInitialization() throws {
        let originalBody = DNSString(with: "Original content")
        let original = DNSNote(body: originalBody, distribution: .adminOnly, priority: DNSPriority.highest)
        
        let copy = DNSNote(from: original)
        
        XCTAssertEqual(copy.body.asString, original.body.asString)
        XCTAssertEqual(copy.distribution, original.distribution)
        XCTAssertEqual(copy.priority, original.priority)
        XCTAssertTrue(copy !== original) // Different instances
        XCTAssertTrue(copy.body !== original.body) // Deep copy
    }
    
    func testUpdateMethod() throws {
        let note1Body = DNSString(with: "Note 1 content")
        let note1 = DNSNote(body: note1Body, distribution: .staffYouth, priority: DNSPriority.low)
        
        let note2 = DNSNote()
        note2.update(from: note1)
        
        XCTAssertEqual(note2.body.asString, note1.body.asString)
        XCTAssertEqual(note2.distribution, note1.distribution)
        XCTAssertEqual(note2.priority, note1.priority)
        XCTAssertTrue(note2.body !== note1.body) // Deep copy
    }
    
    func testDAOInitFromDictionary() throws {
        let bodyData: DNSDataDictionary = [
            "en": "Dictionary note content"
        ]
        let data: DNSDataDictionary = [
            "body": bodyData,
            "distribution": "adultsOnly",
            "priority": DNSPriority.high
        ]
        
        let note = DNSNote(from: data)
        
        XCTAssertEqual(note.body.asString, "Dictionary note content")
        XCTAssertEqual(note.distribution, .adultsOnly)
        XCTAssertEqual(note.priority, DNSPriority.high)
    }
    
    func testDAOFromMethod() throws {
        let note = DNSNote()
        let bodyData: DNSDataDictionary = [
            "en": "DAO method content"
        ]
        let data: DNSDataDictionary = [
            "body": bodyData,
            "distribution": "staffOnly",
            "priority": DNSPriority.highest
        ]
        
        let result = note.dao(from: data)
        
        XCTAssertTrue(result === note) // Should return self
        XCTAssertEqual(note.body.asString, "DAO method content")
        XCTAssertEqual(note.distribution, .staffOnly)
        XCTAssertEqual(note.priority, DNSPriority.highest)
    }
    
    func testAsDictionary() throws {
        let body = DNSString(with: "Dictionary export content")
        let note = DNSNote(body: body, distribution: .everyone, priority: DNSPriority.normal)
        
        let dictionary = note.asDictionary
        
        let bodyDict = dictionary["body"] as? DNSDataDictionary
        XCTAssertNotNil(bodyDict)
        XCTAssertEqual(bodyDict?["en"] as? String, "Dictionary export content")
        XCTAssertEqual(dictionary["distribution"] as? String, "everyone")
        XCTAssertEqual(dictionary["priority"] as? Int, DNSPriority.normal)
    }
    
    func testCodableConformance() throws {
        let body = DNSString(with: "Codable test content")
        let note = DNSNote(body: body, distribution: .staffYouth, priority: DNSPriority.high)
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encoded = try encoder.encode(note)
        let decoded = try decoder.decode(DNSNote.self, from: encoded)
        
        XCTAssertEqual(decoded.body.asString, note.body.asString)
        XCTAssertEqual(decoded.distribution, note.distribution)
        XCTAssertEqual(decoded.priority, note.priority)
    }
    
    func testJSONDecodingWithMissingFields() throws {
        let json = """
        {
            "body": {"en": "Partial JSON content"},
            "distribution": "adminOnly"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let note = try decoder.decode(DNSNote.self, from: json)
        
        XCTAssertEqual(note.body.asString, "Partial JSON content")
        XCTAssertEqual(note.distribution, .adminOnly)
        XCTAssertEqual(note.priority, DNSPriority.normal) // Default value
    }
    
    func testNSCopyingConformance() throws {
        let body = DNSString(with: "Copy test content")
        let note = DNSNote(body: body, distribution: .adultsOnly, priority: DNSPriority.low)
        
        let copy = note.copy() as! DNSNote
        
        XCTAssertEqual(copy.body.asString, note.body.asString)
        XCTAssertEqual(copy.distribution, note.distribution)
        XCTAssertEqual(copy.priority, note.priority)
        XCTAssertTrue(copy !== note) // Different instances
        XCTAssertTrue(copy.body !== note.body) // Deep copy
    }
    
    func testEquatableProtocol() throws {
        let body1 = DNSString(with: "Same content")
        let note1 = DNSNote(body: body1, distribution: .everyone, priority: DNSPriority.normal)
        
        let body2 = DNSString(with: "Same content")
        let note2 = DNSNote(body: body2, distribution: .everyone, priority: DNSPriority.normal)
        
        let body3 = DNSString(with: "Different content")
        let note3 = DNSNote(body: body3, distribution: .everyone, priority: DNSPriority.normal)
        
        XCTAssertTrue(note1 == note2)
        XCTAssertFalse(note1 == note3)
        XCTAssertFalse(note1 != note2)
        XCTAssertTrue(note1 != note3)
    }
    
    func testIsDiffFromMethod() throws {
        let body1 = DNSString(with: "Content 1")
        let note1 = DNSNote(body: body1, distribution: .staffOnly, priority: DNSPriority.high)
        
        let body2 = DNSString(with: "Content 1")
        let note2 = DNSNote(body: body2, distribution: .staffOnly, priority: DNSPriority.high)
        
        let body3 = DNSString(with: "Content 2")
        let note3 = DNSNote(body: body3, distribution: .staffOnly, priority: DNSPriority.high)
        
        XCTAssertFalse(note1.isDiffFrom(note2))
        XCTAssertTrue(note1.isDiffFrom(note3))
        XCTAssertTrue(note1.isDiffFrom("not a note object"))
        XCTAssertTrue(note1.isDiffFrom(nil))
    }
    
    func testPriorityValidation() throws {
        let note = DNSNote()
        
        // Test priority clamping to highest
        note.priority = DNSPriority.highest + 100
        XCTAssertEqual(note.priority, DNSPriority.highest)
        
        // Test priority clamping to none (lowest)
        note.priority = DNSPriority.none - 100
        XCTAssertEqual(note.priority, DNSPriority.none)
        
        // Test valid priority values
        note.priority = DNSPriority.normal
        XCTAssertEqual(note.priority, DNSPriority.normal)
        
        note.priority = DNSPriority.high
        XCTAssertEqual(note.priority, DNSPriority.high)
    }
    
    func testDistributionValues() throws {
        // Test all visibility levels
        let everyoneNote = DNSNote()
        everyoneNote.distribution = .everyone
        XCTAssertEqual(everyoneNote.distribution, .everyone)
        
        let staffOnlyNote = DNSNote()
        staffOnlyNote.distribution = .staffOnly
        XCTAssertEqual(staffOnlyNote.distribution, .staffOnly)
        
        let adminOnlyNote = DNSNote()
        adminOnlyNote.distribution = .adminOnly
        XCTAssertEqual(adminOnlyNote.distribution, .adminOnly)
        
        let adultsOnlyNote = DNSNote()
        adultsOnlyNote.distribution = .adultsOnly
        XCTAssertEqual(adultsOnlyNote.distribution, .adultsOnly)
        
        let staffYouthNote = DNSNote()
        staffYouthNote.distribution = .staffYouth
        XCTAssertEqual(staffYouthNote.distribution, .staffYouth)
    }
    
    func testDAOFromWithInvalidTypes() throws {
        let note = DNSNote()
        let data: DNSDataDictionary = [
            "body": "not a dictionary",
            "distribution": 123,
            "priority": "not a number"
        ]
        
        _ = note.dao(from: data)
        
        // Should handle invalid types gracefully
        XCTAssertNotNil(note.body) // Should remain default
        XCTAssertEqual(note.distribution, .everyone) // Default fallback
        XCTAssertEqual(note.priority, DNSPriority.normal) // Default fallback
    }
    
    func testDAOFromWithMissingKeys() throws {
        let originalBody = DNSString(with: "Original content")
        let note = DNSNote(body: originalBody, distribution: .adminOnly, priority: DNSPriority.highest)
        
        let data: DNSDataDictionary = [
            "priority": DNSPriority.low
            // Missing body and distribution
        ]
        
        _ = note.dao(from: data)
        
        // Should only update priority, keep original values for missing keys
        XCTAssertEqual(note.body.asString, "Original content")
        XCTAssertEqual(note.distribution, .adminOnly)
        XCTAssertEqual(note.priority, DNSPriority.low)
    }
    
    func testBusinessLogicScenarios() throws {
        // System announcement (high priority, everyone)
        let systemAnnouncement = DNSNote()
        let systemBody = DNSString(with: "System maintenance scheduled for tonight")
        systemAnnouncement.body = systemBody
        systemAnnouncement.distribution = .everyone
        systemAnnouncement.priority = DNSPriority.highest
        
        XCTAssertEqual(systemAnnouncement.distribution, .everyone)
        XCTAssertEqual(systemAnnouncement.priority, DNSPriority.highest)
        
        // Internal staff note (restricted distribution)
        let staffNote = DNSNote()
        let staffBody = DNSString(with: "Remember to update the daily reports")
        staffNote.body = staffBody
        staffNote.distribution = .staffOnly
        staffNote.priority = DNSPriority.normal
        
        XCTAssertEqual(staffNote.distribution, .staffOnly)
        XCTAssertEqual(staffNote.priority, DNSPriority.normal)
        
        // Age-restricted content
        let adultContent = DNSNote()
        let adultBody = DNSString(with: "Adult-only event notification")
        adultContent.body = adultBody
        adultContent.distribution = .adultsOnly
        adultContent.priority = DNSPriority.normal
        
        XCTAssertEqual(adultContent.distribution, .adultsOnly)
    }
    
    func testFieldMapping() throws {
        let note = DNSNote()
        let bodyData: DNSDataDictionary = [
            "en": "Field mapping test"
        ]
        
        // Test field mapping using raw CodingKeys
        let data: DNSDataDictionary = [
            DNSNote.CodingKeys.body.rawValue: bodyData,
            DNSNote.CodingKeys.distribution.rawValue: "staffYouth",
            DNSNote.CodingKeys.priority.rawValue: DNSPriority.high
        ]
        
        _ = note.dao(from: data)
        
        XCTAssertEqual(note.body.asString, "Field mapping test")
        XCTAssertEqual(note.distribution, .staffYouth)
        XCTAssertEqual(note.priority, DNSPriority.high)
    }
    
    func testBodyModification() throws {
        let note = DNSNote()
        
        // Test body content changes
        note.body = DNSString(with: "Initial content")
        XCTAssertEqual(note.body.asString, "Initial content")
        
        note.body = DNSString(with: "Updated content")
        XCTAssertEqual(note.body.asString, "Updated content")
        
        // Test with empty content
        note.body = DNSString(with: "")
        XCTAssertEqual(note.body.asString, "")
    }
    
    func testInvalidDistributionFallback() throws {
        let note = DNSNote()
        let data: DNSDataDictionary = [
            "distribution": "invalidVisibility"
        ]
        
        _ = note.dao(from: data)
        
        // Should fall back to .everyone for invalid distribution
        XCTAssertEqual(note.distribution, .everyone)
    }
}