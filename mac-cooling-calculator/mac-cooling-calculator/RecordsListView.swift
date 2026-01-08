//
//  RecordsListView.swift
//  mac-cooling-calculator
//
//  记录列表视图
//

import SwiftUI
import UniformTypeIdentifiers

struct RecordsListView: View {
    @Bindable var state: AppState
    @State private var editingId: UUID?
    @State private var editingName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text(state.t.recordsTitle)
                    .font(.headline)
                
                Spacer()
                
                Text("\(state.records.count)/20")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            if state.records.isEmpty {
                // Empty State
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.largeTitle)
                        .foregroundStyle(.tertiary)
                    Text(state.t.noRecords)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, minHeight: 150)
            } else {
                // Records List
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(state.records) { record in
                            RecordRow(
                                record: record,
                                roomTypeName: state.t.roomTypes[record.roomType] ?? record.roomType.rawValue,
                                isEditing: editingId == record.id,
                                editingName: $editingName,
                                onStartEdit: {
                                    editingId = record.id
                                    editingName = record.roomName
                                },
                                onEndEdit: {
                                    state.updateRecordName(record, newName: editingName)
                                    editingId = nil
                                },
                                onDelete: {
                                    state.deleteRecord(record)
                                }
                            )
                        }
                    }
                }
                .frame(maxHeight: 200)
                
                // Action Buttons
                HStack {
                    Button(action: { state.clearAll() }) {
                        Label(state.t.clearAllBtn, systemImage: "trash")
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    
                    Spacer()
                    
                    Button(action: { exportCSV() }) {
                        Label(state.t.exportBtn, systemImage: "arrow.down.doc")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding()
        .background(.background.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private func exportCSV() {
        guard let csvContent = state.generateCSVContent() else { return }
        
        let panel = NSSavePanel()
        panel.title = "Export Records"
        panel.nameFieldStringValue = "CoolCal_Pro_Records_\(ISO8601DateFormatter().string(from: Date()).prefix(10)).csv"
        panel.allowedContentTypes = [.commaSeparatedText]
        panel.canCreateDirectories = true
        
        panel.begin { response in
            if response == .OK, let url = panel.url {
                do {
                    try csvContent.write(to: url, atomically: true, encoding: .utf8)
                } catch {
                    print("Export failed: \(error)")
                }
            }
        }
    }
}

struct RecordRow: View {
    let record: RoomRecord
    let roomTypeName: String
    let isEditing: Bool
    @Binding var editingName: String
    let onStartEdit: () -> Void
    let onEndEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            if isEditing {
                TextField("Name", text: $editingName, onCommit: onEndEdit)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 120)
            } else {
                Text(record.roomName)
                    .fontWeight(.medium)
                    .onTapGesture(count: 2, perform: onStartEdit)
            }
            
            Text(roomTypeName)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text("\(record.area, specifier: "%.1f") m²")
                .font(.caption)
                .monospacedDigit()
            
            Text("\(record.kw, specifier: "%.2f") kW")
                .font(.caption)
                .foregroundStyle(.blue)
                .monospacedDigit()
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.red.opacity(0.7))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.secondary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    RecordsListView(state: {
        let s = AppState()
        s.confirmAndAdd()
        s.confirmAndAdd()
        return s
    }())
    .frame(width: 400)
    .padding()
}
