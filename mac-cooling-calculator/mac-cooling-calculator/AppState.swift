//
//  AppState.swift
//  mac-cooling-calculator
//
//  应用状态管理
//

import SwiftUI

@Observable
class AppState {
    // MARK: - Settings
    var language: Language {
        didSet { saveLanguage() }
    }
    var isDarkMode: Bool {
        didSet { saveDarkMode() }
    }
    
    // MARK: - Input State
    var area: Double = 20
    var roomType: RoomType = .bedroom
    var factors = EnvironmentalFactors()
    var isTropical: Bool = true
    
    // MARK: - Records (不持久化，每次启动清空)
    var records: [RoomRecord] = []
    
    // MARK: - Computed
    var result: CalculationResult {
        CoolingCalculator.calculate(
            area: area,
            roomType: roomType,
            factors: factors,
            isTropical: isTropical
        )
    }
    
    var t: Translations {
        TRANSLATIONS[language] ?? TRANSLATIONS[.en]!
    }
    
    var canAddRecord: Bool {
        records.count < 20
    }
    
    // MARK: - Init
    init() {
        // Load saved settings
        if let langStr = UserDefaults.standard.string(forKey: "coolcalc_language"),
           let lang = Language(rawValue: langStr) {
            self.language = lang
        } else {
            self.language = .en
        }
        
        self.isDarkMode = UserDefaults.standard.object(forKey: "coolcalc_darkmode_v2") == nil 
            ? true  // 默认暗黑模式
            : UserDefaults.standard.bool(forKey: "coolcalc_darkmode_v2")
    }
    
    // MARK: - Actions
    func confirmAndAdd() {
        guard canAddRecord else { return }
        
        let newRecord = RoomRecord(
            roomName: "\(t.roomNamePrefix) \(records.count + 1)",
            area: result.area,
            kw: result.kw,
            btu: result.btu,
            hp: result.hp,
            roomType: result.roomType
        )
        records.append(newRecord)
    }
    
    func deleteRecord(_ record: RoomRecord) {
        records.removeAll { $0.id == record.id }
    }
    
    func updateRecordName(_ record: RoomRecord, newName: String) {
        if let index = records.firstIndex(where: { $0.id == record.id }) {
            records[index].roomName = newName
        }
    }
    
    func clearAll() {
        records.removeAll()
    }
    
    func generateCSVContent() -> String? {
        guard !records.isEmpty else { return nil }
        
        let headers = "Room Name,Type,Area (m2),Capacity (kW),Capacity (BTU),Capacity (HP)"
        let rows = records.map { r in
            let typeName = t.roomTypes[r.roomType] ?? r.roomType.rawValue
            return "\(r.roomName),\(typeName),\(r.area),\(String(format: "%.2f", r.kw)),\(Int(r.btu)),\(String(format: "%.2f", r.hp))"
        }
        
        return "\u{FEFF}" + ([headers] + rows).joined(separator: "\n")
    }
    
    // MARK: - Persistence
    private func saveLanguage() {
        UserDefaults.standard.set(language.rawValue, forKey: "coolcalc_language")
    }
    
    private func saveDarkMode() {
        UserDefaults.standard.set(isDarkMode, forKey: "coolcalc_darkmode_v2")
    }
}
