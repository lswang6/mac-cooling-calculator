//
//  CoolingCalculator.swift
//  mac-cooling-calculator
//
//  冷负荷计算核心逻辑
//

import Foundation

struct CoolingCalculator {
    
    static func calculate(
        area: Double,
        roomType: RoomType,
        factors: EnvironmentalFactors,
        isTropical: Bool
    ) -> CalculationResult {
        let baseLoad = ASHRAE_FACTORS[roomType] ?? 100
        
        // 计算调整乘数
        var totalMultiplier: Double = 1.0
        if factors.highSunExposure {
            totalMultiplier += AdjustmentPercentages.highSunExposure
        }
        if factors.poorInsulation {
            totalMultiplier += AdjustmentPercentages.poorInsulation
        }
        if factors.extraOccupants {
            totalMultiplier += AdjustmentPercentages.extraOccupants
        }
        if factors.highElectronicLoad {
            totalMultiplier += AdjustmentPercentages.highElectronicLoad
        }
        
        // 热带地区系数
        let tropicalMultiplier = isTropical ? 1.30 : 1.0
        
        // 计算各单位值
        let adjustedWattsPerM2 = baseLoad * totalMultiplier * tropicalMultiplier
        let watts = area * adjustedWattsPerM2
        let kw = watts / 1000
        let btu = watts * CONVERSION_BTU_PER_WATT
        let hp = btu / BTU_PER_HP
        
        return CalculationResult(
            watts: watts,
            kw: kw,
            btu: btu,
            hp: hp,
            area: area,
            roomType: roomType,
            baseLoad: baseLoad,
            adjustmentMultiplier: totalMultiplier,
            isTropical: isTropical
        )
    }
    // MARK: - Recommendations
    
    static func getACRecommendation(hp: Double, t: Translations) -> ACRecommendation {
        if hp <= 0.75 {
            return ACRecommendation(
                size: "0.75 HP / 9000 BTU",
                units: t.recSmallSplit,
                tip: "\(t.recTipPrefix): \(t.roomTypes[.bedroom] ?? "")"
            )
        } else if hp <= 1 {
            return ACRecommendation(
                size: "1 HP / 12000 BTU",
                units: t.recStandardSplit,
                tip: "\(t.recTipPrefix): \(t.roomTypes[.bedroom] ?? "")"
            )
        } else if hp <= 1.5 {
            return ACRecommendation(
                size: "1.5 HP / 18000 BTU",
                units: t.recMediumSplit,
                tip: "\(t.recTipPrefix): \(t.roomTypes[.livingRoom] ?? "")"
            )
        } else if hp <= 2 {
            return ACRecommendation(
                size: "2 HP / 24000 BTU",
                units: t.recLargeSplit,
                tip: "\(t.recTipPrefix): \(t.roomTypes[.livingRoom] ?? "")"
            )
        } else if hp <= 3 {
            return ACRecommendation(
                size: "3 HP / 36000 BTU",
                units: t.recFloorUnit,
                tip: "\(t.recTipPrefix): \(t.recMultiUnit)"
            )
        } else if hp <= 5 {
            return ACRecommendation(
                size: "5 HP / 60000 BTU",
                units: t.recLargeFloor,
                tip: "\(t.recTipPrefix): \(t.roomTypes[.serverRoom] ?? "")"
            )
        } else {
            let unitCount = Int(ceil(hp / 3))
            return ACRecommendation(
                size: String(format: "%.1f HP / %.0f BTU", hp, hp * 12000),
                units: "\(t.recMultiUnit) (\(unitCount)x 3HP)",
                tip: t.recMultiUnit
            )
        }
    }
}
