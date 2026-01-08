//
//  Models.swift
//  mac-cooling-calculator
//
//  CoolCalc Pro 数据模型
//

import Foundation

// MARK: - Enums

enum Language: String, CaseIterable, Codable {
    case en = "en"
    case fr = "fr"
    case zh = "zh"
    case ar = "ar"
    
    var displayName: String {
        switch self {
        case .en: return "English"
        case .fr: return "Français"
        case .zh: return "中文"
        case .ar: return "العربية"
        }
    }
}

enum RoomType: String, CaseIterable, Codable, Identifiable {
    case bedroom = "bedroom"
    case livingRoom = "living_room"
    case kitchen = "kitchen"
    case office = "office"
    case serverRoom = "server_room"
    case gym = "gym"
    
    var id: String { rawValue }
}

// MARK: - Structs

struct EnvironmentalFactors: Codable, Equatable {
    var highSunExposure: Bool = false
    var poorInsulation: Bool = false
    var extraOccupants: Bool = false
    var highElectronicLoad: Bool = false
}

struct RoomRecord: Identifiable, Codable, Equatable {
    let id: UUID
    var roomName: String
    let area: Double
    let kw: Double
    let btu: Double
    let hp: Double
    let roomType: RoomType
    
    init(id: UUID = UUID(), roomName: String, area: Double, kw: Double, btu: Double, hp: Double, roomType: RoomType) {
        self.id = id
        self.roomName = roomName
        self.area = area
        self.kw = kw
        self.btu = btu
        self.hp = hp
        self.roomType = roomType
    }
}

struct CalculationResult: Equatable {
    let watts: Double
    let kw: Double
    let btu: Double
    let hp: Double
    let area: Double
    let roomType: RoomType
    let baseLoad: Double
    let adjustmentMultiplier: Double
    let isTropical: Bool
}

struct ACRecommendation: Equatable {
    let size: String
    let units: String
    let tip: String
}
