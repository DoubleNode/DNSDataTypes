//
//  DNSUserRole.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// User role enumeration (hierarchical role-based access control)
public enum DNSUserRole: Int, CaseIterable, Codable {
    case blocked = -1
    case endUser = 0
    case placeViewer = 6000
    case placeStaff = 7000
    case placeOperations = 8000
    case placeAdmin = 9000
    case districtViewer = 60000
    case districtStaff = 70000
    case districtOperations = 80000
    case districtAdmin = 90000
    case regionalViewer = 100000
    case regionalStaff = 200000
    case regionalOperations = 300000
    case regionalAdmin = 400000
    case supportViewer = 500000
    case supportStaff = 600000
    case supportOperations = 700000
    case supportAdmin = 800000
    case superUser = 900000

    public var isSuperUser: Bool { self.rawValue == DNSUserRole.superUser.rawValue }
    public func isAdmin(for scope: DNSScope = .place) -> Bool {
        switch scope {
        case .all: return self.rawValue >= DNSUserRole.supportViewer.rawValue
        case .region: return self.rawValue >= DNSUserRole.regionalViewer.rawValue
        case .district: return self.rawValue >= DNSUserRole.districtViewer.rawValue
        case .place: return self.rawValue >= DNSUserRole.placeViewer.rawValue
        }
    }
    public var code: String {
        switch self {
        case .superUser:  return "SuperUser"
        case .supportAdmin:  return "SupportAdmin"
        case .supportOperations:  return "SupportOperations"
        case .supportStaff:  return "SupportStaff"
        case .supportViewer:  return "SupportViewer"
        case .regionalAdmin:  return "RegionalAdmin"
        case .regionalOperations:  return "RegionalOperations"
        case .regionalStaff:  return "RegionalStaff"
        case .regionalViewer:  return "RegionalViewer"
        case .districtAdmin:  return "DistrictAdmin"
        case .districtOperations:  return "DistrictOperations"
        case .districtStaff:  return "DistrictStaff"
        case .districtViewer:  return "DistrictViewer"
        case .placeAdmin:  return "PlaceAdmin"
        case .placeOperations:  return "PlaceOperations"
        case .placeStaff:  return "PlaceStaff"
        case .placeViewer:  return "PlaceViewer"
        case .endUser:  return "EndUser"
        case .blocked:  return "Blocked"
        }
    }
    public static func userRole(from code: String) -> DNSUserRole {
        switch code {
        case "SuperUser":  return .superUser
        case "SupportAdmin":  return .supportAdmin
        case "SupportOperations":  return .supportOperations
        case "SupportStaff":  return .supportStaff
        case "SupportViewer":  return .supportViewer
        case "RegionalAdmin":  return .regionalAdmin
        case "RegionalOperations":  return .regionalOperations
        case "RegionalStaff":  return .regionalStaff
        case "RegionalViewer":  return .regionalViewer
        case "DistrictAdmin":  return .districtAdmin
        case "DistrictOperations":  return .districtOperations
        case "DistrictStaff":  return .districtStaff
        case "DistrictViewer":  return .districtViewer
        case "PlaceAdmin":  return .placeAdmin
        case "PlaceOperations":  return .placeOperations
        case "PlaceStaff":  return .placeStaff
        case "PlaceViewer":  return .placeViewer
        case "EndUser":  return .endUser
        case "Blocked":  return .blocked
        default: return .blocked
        }
    }
}