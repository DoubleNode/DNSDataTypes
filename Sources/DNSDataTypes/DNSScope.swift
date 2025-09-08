//
//  DNSScope.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// Scope enumeration for role-based access control
public enum DNSScope: Int, CaseIterable, Codable {
    case place = 1000
    case district = 3000
    case region = 5000
    case all = 10000
}