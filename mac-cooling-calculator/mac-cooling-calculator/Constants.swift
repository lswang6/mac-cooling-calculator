//
//  Constants.swift
//  mac-cooling-calculator
//
//  CoolCalc Pro 常量定义
//

import Foundation

// MARK: - ASHRAE Load Factors (W/m²)

let ASHRAE_FACTORS: [RoomType: Double] = [
    .bedroom: 100,
    .livingRoom: 160,
    .kitchen: 200,
    .office: 180,
    .serverRoom: 350,
    .gym: 250
]

// MARK: - Adjustment Percentages

struct AdjustmentPercentages {
    static let highSunExposure: Double = 0.10   // +10%
    static let poorInsulation: Double = 0.15    // +15%
    static let extraOccupants: Double = 0.10    // +10%
    static let highElectronicLoad: Double = 0.10 // +10%
}

// MARK: - Unit Conversion

let CONVERSION_BTU_PER_WATT: Double = 3.412142
let BTU_PER_HP: Double = 9000

// MARK: - Translations

struct Translations {
    let title: String
    let subtitle: String
    let areaLabel: String
    let roomTypeLabel: String
    let resultsTitle: String
    let kwLabel: String
    let btuLabel: String
    let hpLabel: String
    let m2Label: String
    let disclaimer: String
    let tropicalAreaLabel: String
    let factorsTitle: String
    let factorHighSun: String
    let factorPoorInsulation: String
    let factorExtraOccupants: String
    let factorElectronics: String
    let confirmBtn: String
    let recordsTitle: String
    let exportBtn: String
    let clearAllBtn: String
    let noRecords: String
    let roomNamePrefix: String
    let roomTypes: [RoomType: String]
    let quickSliderLabel: String
    
    // AC Recommendation
    let recTitle: String
    let recTipPrefix: String
    let recSmallSplit: String
    let recStandardSplit: String
    let recMediumSplit: String
    let recLargeSplit: String
    let recFloorUnit: String
    let recLargeFloor: String
    let recMultiUnit: String
    
    // Cost Estimation
    let costTitle: String
    let totalRooms: String
    let totalArea: String
    let totalPower: String
    let totalBTU: String
    let efficiencyClass: String
    let estMonthlyCost: String
    let costDisclaimer: String
}

let TRANSLATIONS: [Language: Translations] = [
    .en: Translations(
        title: "CoolCalc Pro",
        subtitle: "ASHRAE Standard Cooling Capacity Estimator",
        areaLabel: "Cooling Area (m²)",
        roomTypeLabel: "Room Type",
        resultsTitle: "Recommended Capacity",
        kwLabel: "Kilowatts (kW)",
        btuLabel: "BTU per Hour (BTU/h)",
        hpLabel: "Horsepower (HP)",
        m2Label: "Square Meters",
        disclaimer: "Calculations are based on ASHRAE standard load factors. Adjustments are applied additively based on environmental conditions.",
        tropicalAreaLabel: "Tropical Area Application (+30%)",
        factorsTitle: "Environmental Factors (Optional)",
        factorHighSun: "High Sun Exposure (South-facing/Large windows)",
        factorPoorInsulation: "Poor Insulation (Old building/Thin walls)",
        factorExtraOccupants: "High Occupancy (>2 people regularly)",
        factorElectronics: "Many Electronics/Appliances (Heat sources)",
        confirmBtn: "Confirm & Add",
        recordsTitle: "Cooling Capacity Records",
        exportBtn: "Export to CSV",
        clearAllBtn: "Clear All",
        noRecords: "No records yet",
        roomNamePrefix: "Room",
        roomTypes: [
            .bedroom: "Bedroom / Rest Area",
            .livingRoom: "Living Room / Lounge",
            .kitchen: "Kitchen / Dining",
            .office: "Office / Workspace",
            .serverRoom: "Server / Tech Room",
            .gym: "Gym / Fitness Area"
        ],
        quickSliderLabel: "Quick slider for 2-1000 m²",
        
        // EN Recommendations
        recTitle: "Recommended AC Configuration",
        recTipPrefix: "Tip",
        recSmallSplit: "1x Small Split Unit (0.75-1 HP)",
        recStandardSplit: "1x Standard Split Unit (1-1.5 HP)",
        recMediumSplit: "1x Medium Split Unit (1.5-2 HP)",
        recLargeSplit: "1x Large Split Unit (2-2.5 HP)",
        recFloorUnit: "1x Floor Unit or 2x 1.5HP Splits",
        recLargeFloor: "1x Large Floor Unit or Multi-Split",
        recMultiUnit: "Recommend multiple units",
        
        // EN Cost
        costTitle: "Total Capacity Summary",
        totalRooms: "Rooms",
        totalArea: "Total Area",
        totalPower: "Total Power",
        totalBTU: "Total BTU",
        efficiencyClass: "Efficiency",
        estMonthlyCost: "Est. Monthly",
        costDisclaimer: "* Estimate based on 8 hours/day usage at $0.12/kWh. Actual costs vary by region and usage patterns."
    ),
    .fr: Translations(
        title: "CoolCalc Pro",
        subtitle: "Estimateur de Capacité de Refroidissement (ASHRAE)",
        areaLabel: "Surface à refroidir (m²)",
        roomTypeLabel: "Type de pièce",
        resultsTitle: "Estimation de Capacité",
        kwLabel: "Kilowatts (kW)",
        btuLabel: "BTU par heure (BTU/h)",
        hpLabel: "Chevaux (HP)",
        m2Label: "m²",
        disclaimer: "Calculé selon les facteurs de charge standard ASHRAE.",
        tropicalAreaLabel: "Application Zone Tropicale (+30%)",
        factorsTitle: "Facteurs Environnementaux (Optionnel)",
        factorHighSun: "Exposition Solaire Élevée",
        factorPoorInsulation: "Isolation Faible",
        factorExtraOccupants: "Occupation Élevée",
        factorElectronics: "Nombreux Électronique",
        confirmBtn: "Confirmer & Ajouter",
        recordsTitle: "Registres de Capacité",
        exportBtn: "Exporter en CSV",
        clearAllBtn: "Tout Effacer",
        noRecords: "Aucun registre",
        roomNamePrefix: "Pièce",
        roomTypes: [
            .bedroom: "Chambre / Repos",
            .livingRoom: "Salon / Séjour",
            .kitchen: "Cuisine / Repas",
            .office: "Bureau / Travail",
            .serverRoom: "Serveur / Tech",
            .gym: "Gym / Fitness"
        ],
        quickSliderLabel: "Curseur rapide pour 2-1000 m²",
        
        // FR Recommendations
        recTitle: "Configuration AC Recommandée",
        recTipPrefix: "Astuce",
        recSmallSplit: "1x Petite unité divisée",
        recStandardSplit: "1x Unité divisée standard",
        recMediumSplit: "1x Unité divisée moyenne",
        recLargeSplit: "1x Grande unité divisée",
        recFloorUnit: "1x Unité au sol ou 2x Split",
        recLargeFloor: "1x Grande unité au sol ou Multi-Split",
        recMultiUnit: "Recommander plusieurs unités",
        
        // FR Cost
        costTitle: "Résumé de la Capacité Totale",
        totalRooms: "Pièces",
        totalArea: "Surface Totale",
        totalPower: "Puissance Totale",
        totalBTU: "Total BTU",
        efficiencyClass: "Efficacité",
        estMonthlyCost: "Est. Mensuel",
        costDisclaimer: "* Estimation basée sur 8h/jour à $0.12/kWh. Les coûts réels varient."
    ),
    .zh: Translations(
        title: "CoolCalc Pro",
        subtitle: "ASHRAE 标准冷负荷计算器",
        areaLabel: "制冷面积 (m²)",
        roomTypeLabel: "房间类型",
        resultsTitle: "推荐容量",
        kwLabel: "千瓦 (kW)",
        btuLabel: "英热单位/小时 (BTU/h)",
        hpLabel: "匹 (HP)",
        m2Label: "平方米",
        disclaimer: "计算基于 ASHRAE 标准负荷系数。环境调整按叠加方式应用。",
        tropicalAreaLabel: "热带地区应用 (+30%)",
        factorsTitle: "环境因素（可选）",
        factorHighSun: "高日照（朝南/大窗户）",
        factorPoorInsulation: "保温差（老建筑/薄墙）",
        factorExtraOccupants: "人员较多（经常>2人）",
        factorElectronics: "电器设备多（热源）",
        confirmBtn: "确认并添加",
        recordsTitle: "冷负荷记录",
        exportBtn: "导出 CSV",
        clearAllBtn: "清空全部",
        noRecords: "暂无记录",
        roomNamePrefix: "房间",
        roomTypes: [
            .bedroom: "卧室 / 休息区",
            .livingRoom: "客厅 / 起居室",
            .kitchen: "厨房 / 餐厅",
            .office: "办公室 / 工作区",
            .serverRoom: "机房 / 设备间",
            .gym: "健身房 / 运动区"
        ],
        quickSliderLabel: "2-1000 m² 快速调节滑块",
        
        // ZH Recommendations
        recTitle: "推荐空调配置",
        recTipPrefix: "建议",
        recSmallSplit: "1台小型分体机 (0.75-1 HP)",
        recStandardSplit: "1台标准分体机 (1-1.5 HP)",
        recMediumSplit: "1台中型分体机 (1.5-2 HP)",
        recLargeSplit: "1台大型分体机 (2-2.5 HP)",
        recFloorUnit: "1台柜机 或 2台1.5HP分体机",
        recLargeFloor: "1台大柜机 或多联机系系统",
        recMultiUnit: "建议多台设备组合",
        
        // ZH Cost
        costTitle: "总容量汇总",
        totalRooms: "房间数",
        totalArea: "总面积",
        totalPower: "总功率",
        totalBTU: "总BTU",
        efficiencyClass: "能效等级",
        estMonthlyCost: "预估月费",
        costDisclaimer: "* 预估基于每天8小时使用，电价$0.12/kWh。实际费用因地区和使用习惯而异。"
    ),
    .ar: Translations(
        title: "CoolCalc Pro",
        subtitle: "حاسبة سعة التبريد وفق معايير ASHRAE",
        areaLabel: "مساحة التبريد (م²)",
        roomTypeLabel: "نوع الغرفة",
        resultsTitle: "السعة الموصى بها",
        kwLabel: "كيلوواط (kW)",
        btuLabel: "وحدة حرارية/ساعة (BTU/h)",
        hpLabel: "حصان (HP)",
        m2Label: "متر مربع",
        disclaimer: "تستند الحسابات إلى معايير ASHRAE.",
        tropicalAreaLabel: "تطبيق المنطقة الاستوائية (+30%)",
        factorsTitle: "العوامل البيئية (اختياري)",
        factorHighSun: "تعرض عالي للشمس",
        factorPoorInsulation: "عزل ضعيف",
        factorExtraOccupants: "إشغال عالي",
        factorElectronics: "أجهزة إلكترونية كثيرة",
        confirmBtn: "تأكيد وإضافة",
        recordsTitle: "سجلات سعة التبريد",
        exportBtn: "تصدير CSV",
        clearAllBtn: "مسح الكل",
        noRecords: "لا توجد سجلات",
        roomNamePrefix: "غرفة",
        roomTypes: [
            .bedroom: "غرفة نوم",
            .livingRoom: "غرفة معيشة",
            .kitchen: "مطبخ",
            .office: "مكتب",
            .serverRoom: "غرفة خوادم",
            .gym: "صالة رياضية"
        ],
        quickSliderLabel: "مؤشر سريع لـ 2-1000 متر مربع",
        
        // AR Recommendations
        recTitle: "تكوين مكيف الهواء الموصى به",
        recTipPrefix: "نصيحة",
        recSmallSplit: "1x وحدة تقسيم صغيرة",
        recStandardSplit: "1x وحدة تقسيم قياسية",
        recMediumSplit: "1x وحدة تقسيم متوسطة",
        recLargeSplit: "1x وحدة تقسيم كبيرة",
        recFloorUnit: "1x وحدة أرضية أو 2x انقسام",
        recLargeFloor: "1x وحدة أرضية كبيرة أو متعددة",
        recMultiUnit: "نوصي بوحدات متعددة",
        
        // AR Cost
        costTitle: "ملخص القدرة الكلية",
        totalRooms: "غرف",
        totalArea: "المساحة الكلية",
        totalPower: "القدرة الكلية",
        totalBTU: "إجمالي BTU",
        efficiencyClass: "كفاءة",
        estMonthlyCost: "تقدير شهري",
        costDisclaimer: "* تقدير يعتمد على 8 ساعات/يوم بسعر 0.12 دولار/كيلوواط. تختلف التكاليف الفعلية."
    )
]
