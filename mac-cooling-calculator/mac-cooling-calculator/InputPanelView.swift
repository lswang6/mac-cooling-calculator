//
//  InputPanelView.swift
//  mac-cooling-calculator
//
//  输入面板视图
//

import SwiftUI

struct InputPanelView: View {
    @Bindable var state: AppState
    @State private var areaText: String = "20"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Area Input - 滑块 + 输入框
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(state.t.areaLabel)
                        .fontWeight(.medium)
                    Spacer()
                }
                
                HStack(spacing: 16) {
                    // 输入框
                    HStack(spacing: 4) {
                        TextField("", text: $areaText)
                            .textFieldStyle(.plain)
                            .frame(width: 80) // 稍微加宽以容纳 20000
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(Color.secondary.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .monospacedDigit()
                            .multilineTextAlignment(.trailing)
                            .onSubmit {
                                updateAreaFromText()
                            }
                            .onChange(of: state.area) { _, newValue in
                                // 只有当新值与当前文本不匹配（且文本是有效数字）时才更新文本，避免输入 0. 时被重置
                                if let currentVal = Double(areaText), abs(currentVal - newValue) < 0.1 {
                                    return
                                }
                                areaText = String(format: "%.1f", newValue)
                            }
                        
                        Text("m²")
                            .foregroundStyle(.secondary)
                    }
                    
                    // 滑块区域
                    VStack(alignment: .leading, spacing: 4) {
                        Text(state.t.quickSliderLabel)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        
                        Slider(value: $state.area, in: 2...1000, step: 0.5)
                            .tint(.blue)
                    }
                }
            }
            
            // Room Type Picker - 改用 Picker menu 样式
            VStack(alignment: .leading, spacing: 8) {
                Text(state.t.roomTypeLabel)
                    .fontWeight(.medium)
                
                Picker("", selection: $state.roomType) {
                    ForEach(RoomType.allCases) { type in
                        Text(state.t.roomTypes[type] ?? type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.radioGroup)
                .labelsHidden()
            }
            
            
            // Environmental Factors
            VStack(alignment: .leading, spacing: 12) {
                Text(state.t.factorsTitle)
                    .fontWeight(.medium)
                
                VStack(alignment: .leading, spacing: 10) {
                    Toggle(state.t.factorHighSun, isOn: $state.factors.highSunExposure)
                    Toggle(state.t.factorPoorInsulation, isOn: $state.factors.poorInsulation)
                    Toggle(state.t.factorExtraOccupants, isOn: $state.factors.extraOccupants)
                    Toggle(state.t.factorElectronics, isOn: $state.factors.highElectronicLoad)
                }
                .toggleStyle(.checkbox)
            }
            
            
            // Tropical Toggle
            HStack {
                Toggle(state.t.tropicalAreaLabel, isOn: $state.isTropical)
                    .toggleStyle(.switch)
                    .tint(.orange)
            }
        }
        .onAppear {
            areaText = String(format: "%.1f", state.area)
        }
    }
    
    private func updateAreaFromText() {
        if let value = Double(areaText) {
            let clamped = min(max(value, 0), 20000)
            state.area = clamped
            // Format accordingly
            areaText = String(format: "%.1f", clamped)
        } else {
            areaText = String(format: "%.1f", state.area)
        }
    }
}

#Preview {
    InputPanelView(state: AppState())
        .frame(width: 350)
        .padding()
}
