//
//  DNSAppActionType.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
import Foundation

public enum DNSAppActionType: String, CaseIterable, Codable {
    case drawer
    case fullScreen
    case popup
    case stage
}
