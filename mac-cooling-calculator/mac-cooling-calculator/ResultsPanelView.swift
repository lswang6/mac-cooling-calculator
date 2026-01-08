//
//  ResultsPanelView.swift
//  mac-cooling-calculator
//
//  计算结果面板视图
//

import SwiftUI

struct ResultsPanelView: View {
    @Bindable var state: AppState
    
    private var recommendation: ACRecommendation {
        CoolingCalculator.getACRecommendation(hp: state.result.hp, t: state.t)
    }

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text(state.t.resultsTitle)
                .font(.title2)
                .fontWeight(.bold)
            
            // Results Grid
            HStack(spacing: 24) {
                ResultCard(
                    label: state.t.kwLabel,
                    value: String(format: "%.2f", state.result.kw),
                    unit: "kW",
                    color: .blue
                )
                
                ResultCard(
                    label: state.t.btuLabel,
                    value: String(format: "%.0f", state.result.btu),
                    unit: "BTU/h",
                    color: .orange
                )
                
                ResultCard(
                    label: state.t.hpLabel,
                    value: String(format: "%.2f", state.result.hp),
                    unit: "HP",
                    color: .green
                )
            }
            
            
            // Recommendation Card
            let rec = recommendation
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "fanblades.fill")
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(state.t.recTitle)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                        
                        Text(rec.size)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(rec.units)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "lightbulb.fill")
                            .font(.caption2)
                            .foregroundStyle(.yellow)
                        Text(rec.tip)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.blue.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
            )
            Button(action: { state.confirmAndAdd() }) {
                Label(state.t.confirmBtn, systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!state.canAddRecord)
            .controlSize(.large)
            
            // Disclaimer
            Text(state.t.disclaimer)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(.background.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ResultCard: View {
    let label: String
    let value: String
    let unit: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(color)
            
            Text(unit)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text(label)
                .font(.caption)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ResultsPanelView(state: AppState())
        .frame(width: 500)
        .padding()
}
