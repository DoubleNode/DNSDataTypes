//
//  DNSMediaType.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// Media type enumeration
public enum DNSMediaType: String, CaseIterable {
    case image
    case video
    case audio
    case document
    case other
}