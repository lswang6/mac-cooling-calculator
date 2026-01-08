//
//  SummaryView.swift
//  mac-cooling-calculator
//
//  汇总看板视图
//

import SwiftUI

struct SummaryView: View {
    @Bindable var state: AppState
    
    // 计算属性: 总容量
    var totalKw: Double { state.records.reduce(0) { $0 + $1.kw } }
    var totalBtu: Double { state.records.reduce(0) { $0 + $1.btu } }
    var totalArea: Double { state.records.reduce(0) { $0 + $1.area } }
    
    // 计算属性: 预估月费 ($0.12/kWh * 8h * 30d)
    var estimatedMonthlyCost: Double { totalKw * 8 * 30 * 0.12 }
    
    // 计算属性: 效率等级 W/m²
    var wattsPerSqm: Double { totalArea > 0 ? (totalKw * 1000) / totalArea : 0 }
    var efficiencyRating: String {
        if wattsPerSqm == 0 { return "-" }
        return wattsPerSqm < 120 ? "A" : wattsPerSqm < 150 ? "B" : wattsPerSqm < 180 ? "C" : "D"
    }
    
    var efficiencyColor: Color {
        switch efficiencyRating {
        case "A": return .green
        case "B": return .yellow
        case "C": return .orange
        default: return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(state.t.costTitle)
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                // Room Count
                SummaryCard(
                    title: state.t.totalRooms,
                    value: "\(state.records.count)",
                    icon: "door.left.hand.open"
                )
                
                // Total Area
                SummaryCard(
                    title: state.t.totalArea,
                    value: String(format: "%.0f m²", totalArea),
                    icon: "square.dashed"
                )
                
                // Total kW
                SummaryCard(
                    title: state.t.totalPower,
                    value: String(format: "%.2f kW", totalKw),
                    icon: "bolt.fill",
                    iconColor: .yellow
                )
                
                // Total BTU
                SummaryCard(
                    title: state.t.totalBTU,
                    value: String(format: "%.0fk", totalBtu / 1000),
                    icon: "flame.fill",
                    iconColor: .red
                )
                
                // Efficiency
                SummaryCard(
                    title: state.t.efficiencyClass,
                    value: efficiencyRating,
                    subValue: String(format: "%.0f W/m²", wattsPerSqm),
                    icon: "leaf.fill",
                    iconColor: .green,
                    valueColor: efficiencyColor
                )
                
                // Estimated Cost
                SummaryCard(
                    title: state.t.estMonthlyCost,
                    value: String(format: "$%.0f", estimatedMonthlyCost),
                    icon: "dollarsign.circle.fill",
                    iconColor: .green
                )
            }
            
            Text(state.t.costDisclaimer)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .italic()
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct SummaryCard: View {
    let title: String
    let value: String
    var subValue: String? = nil
    let icon: String
    var iconColor: Color = .secondary
    var valueColor: Color = .primary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(valueColor)
                
                if let sub = subValue {
                    Text(sub)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(nsColor: .controlBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
