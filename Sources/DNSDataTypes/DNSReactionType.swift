//
//  DNSReactionType.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// Reaction type enumeration
public enum DNSReactionType: String, CaseIterable, Codable {
    case unknown = "unknown"
    case angered = "angered"
    case cared = "cared"
    case favorited = "favorited"
    case humored = "humored"
    case like = "like"
    case liked = "liked"
    case loved = "loved"
    case saddened = "saddened"
    case wowed = "wowed"
}
