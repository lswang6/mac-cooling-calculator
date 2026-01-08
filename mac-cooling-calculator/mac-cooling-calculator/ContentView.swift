//
//  ContentView.swift
//  mac-cooling-calculator
//
//  主视图布局
//

import SwiftUI

struct ContentView: View {
    @State private var state = AppState()
    
    var body: some View {
        HStack(spacing: 0) {
            // 左侧 - 输入面板
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 标题区域
                    VStack(alignment: .leading, spacing: 4) {
                        Text(state.t.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(state.t.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.bottom, 8)
                    
                    InputPanelView(state: state)
                }
                .padding(24)
            }
            .frame(width: 380)
            .background(Color(nsColor: .windowBackgroundColor))
            
            Divider()
            
            // 右侧 - 结果和记录
            ScrollView {
                VStack(spacing: 24) {
                    ResultsPanelView(state: state)
                    RecordsListView(state: state)
                    
                    if !state.records.isEmpty {
                        SummaryView(state: state)
                    }
                }
                .padding(24)
            }
            .frame(minWidth: 500)
            .background(
                LinearGradient(
                    colors: state.isDarkMode 
                        ? [.black.opacity(0.3), .black.opacity(0.1)]
                        : [.gray.opacity(0.03), .white],
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
            )
        }
        .toolbar {
            ToolbarItemGroup {
                // 语言选择
                Picker("", selection: $state.language) {
                    ForEach(Language.allCases, id: \.self) { lang in
                        Text(lang.displayName).tag(lang)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 100)
                
                // 暗黑模式切换
                Button(action: { state.isDarkMode.toggle() }) {
                    Image(systemName: state.isDarkMode ? "sun.max.fill" : "moon.fill")
                        .foregroundStyle(state.isDarkMode ? .yellow : .indigo)
                        .imageScale(.large)
                }
                .buttonStyle(.plain)
                .help(state.isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode")
            }
        }
        .preferredColorScheme(state.isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
        .frame(width: 1000, height: 700)
}
