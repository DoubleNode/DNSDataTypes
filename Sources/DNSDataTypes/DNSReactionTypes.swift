//
//  DNSReactionTypes.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

// MARK: - Reaction Types

/// Reaction type enumeration
public enum DNSReactionType: String, CaseIterable {
    case like
    case love
    case laugh
    case wow
    case sad
    case angry
    case dislike
}

/// User reaction structure
public struct DNSUserReaction {
    public var userId: String
    public var reactionType: DNSReactionType
    public var timestamp: Date
    
    public init(userId: String, reactionType: DNSReactionType, timestamp: Date = Date()) {
        self.userId = userId
        self.reactionType = reactionType
        self.timestamp = timestamp
    }
}

/// Reaction counts structure
public struct DNSReactionCounts {
    public var like: Int
    public var love: Int
    public var laugh: Int
    public var wow: Int
    public var sad: Int
    public var angry: Int
    public var dislike: Int
    
    public init() {
        self.like = 0
        self.love = 0
        self.laugh = 0
        self.wow = 0
        self.sad = 0
        self.angry = 0
        self.dislike = 0
    }
}