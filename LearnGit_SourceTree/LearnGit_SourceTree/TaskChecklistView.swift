//
//  TaskChecklistView.swift
//  LearnGit_SourceTree
//
//  Created by Trần Chí Thiện on 27/2/26.
//

import SwiftUI

// MARK: - Data Model

struct TaskItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}

// MARK: - ViewModel

@Observable
@MainActor
class TaskChecklistViewModel {
    var tasks: [TaskItem] = []
    
    private static var fileURL: URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsPath.appendingPathComponent("tasks_checklist.json")
    }
    
    init() {
        loadTasks()
    }
    
    func addTask(_ title: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let task = TaskItem(title: title.trimmingCharacters(in: .whitespaces))
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            tasks.insert(task, at: 0)
        }
        saveTasks()
    }
    
    func toggleTask(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            withAnimation(.easeInOut(duration: 0.25)) {
                tasks[index].isCompleted.toggle()
            }
            saveTasks()
        }
    }
    
    func deleteTask(_ task: TaskItem) {
        withAnimation(.easeOut(duration: 0.25)) {
            tasks.removeAll { $0.id == task.id }
        }
        saveTasks()
    }
    
    func deleteAtOffsets(_ offsets: IndexSet) {
        withAnimation {
            tasks.remove(atOffsets: offsets)
        }
        saveTasks()
    }
    
    var completedCount: Int {
        tasks.filter(\.isCompleted).count
    }
    
    var pendingCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    var progress: Double {
        tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)
    }
    
    // MARK: - File-based Persistence
    
    private func saveTasks() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(tasks)
            try data.write(to: Self.fileURL, options: .atomic)
        } catch {
            print("❌ Lỗi lưu tasks: \(error)")
        }
    }
    
    private func loadTasks() {
        let url = Self.fileURL
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            tasks = try JSONDecoder().decode([TaskItem].self, from: data)
        } catch {
            print("❌ Lỗi đọc tasks: \(error)")
        }
    }
}

// MARK: - Main View

struct TaskChecklistView: View {
    @State private var viewModel = TaskChecklistViewModel()
    @State private var newTaskTitle = ""
    @State private var showCompleted = true
    @FocusState private var isInputFocused: Bool
    
    var pendingTasks: [TaskItem] {
        viewModel.tasks.filter { !$0.isCompleted }
    }
    
    var completedTasks: [TaskItem] {
        viewModel.tasks.filter(\.isCompleted)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(.systemBackground), Color(.systemGray6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Progress card
                        progressCard
                        
                        // Input card
                        inputCard
                        
                        // Pending tasks
                        if !pendingTasks.isEmpty {
                            taskSection(title: "Đang thực hiện", icon: "circle.dashed", color: .orange, tasks: pendingTasks)
                        }
                        
                        // Completed tasks
                        if !completedTasks.isEmpty {
                            taskSection(title: "Đã hoàn thành", icon: "checkmark.circle.fill", color: .green, tasks: completedTasks, isCompleted: true)
                        }
                        
                        // Empty state
                        if viewModel.tasks.isEmpty {
                            emptyState
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Checklist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if !completedTasks.isEmpty {
                        Button {
                            withAnimation {
                                showCompleted.toggle()
                            }
                        } label: {
                            Image(systemName: showCompleted ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Progress Card
    
    private var progressCard: some View {
        VStack(spacing: 14) {
            HStack {
                Image(systemName: "checklist")
                    .font(.system(size: 32))
                    .foregroundStyle(
                        LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(viewModel.completedCount)/\(viewModel.tasks.count)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("hoàn thành")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(.systemGray5))
                        .frame(height: 10)
                    
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(colors: [.green, .mint], startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(width: geometry.size.width * viewModel.progress, height: 10)
                        .animation(.spring(response: 0.4), value: viewModel.progress)
                }
            }
            .frame(height: 10)
            
            HStack {
                Label("\(viewModel.pendingCount) chưa xong", systemImage: "circle.dashed")
                    .font(.caption)
                    .foregroundColor(.orange)
                
                Spacer()
                
                Label("\(viewModel.completedCount) đã xong", systemImage: "checkmark.circle")
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
        )
    }
    
    // MARK: - Input Card
    
    private var inputCard: some View {
        HStack(spacing: 12) {
            Image(systemName: "plus.circle.fill")
                .font(.title2)
                .foregroundColor(.green)
            
            TextField("Thêm task mới...", text: $newTaskTitle)
                .font(.subheadline)
                .focused($isInputFocused)
                .onSubmit {
                    addNewTask()
                }
            
            if !newTaskTitle.isEmpty {
                Button {
                    addNewTask()
                } label: {
                    Text("Thêm")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color.green.gradient))
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.06), radius: 8, y: 3)
        )
    }
    
    // MARK: - Task Section
    
    private func taskSection(title: String, icon: String, color: Color, tasks: [TaskItem], isCompleted: Bool = false) -> some View {
        VStack(spacing: 0) {
            // Section header
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
                
                Text("\(tasks.count)")
                    .font(.caption.weight(.bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Capsule().fill(color))
                
                Spacer()
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 8)
            
            // Task rows
            if !isCompleted || showCompleted {
                VStack(spacing: 0) {
                    ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
                        TaskRowView(task: task, onToggle: {
                            viewModel.toggleTask(task)
                        }, onDelete: {
                            viewModel.deleteTask(task)
                        })
                        
                        if index < tasks.count - 1 {
                            Divider()
                                .padding(.leading, 52)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemGroupedBackground))
                        .shadow(color: .black.opacity(0.06), radius: 8, y: 3)
                )
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
    
    // MARK: - Empty State
    
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "text.badge.checkmark")
                .font(.system(size: 50))
                .foregroundColor(.secondary.opacity(0.5))
            
            Text("Chưa có task nào")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Thêm task để bắt đầu theo dõi\ncông việc của bạn")
                .font(.subheadline)
                .foregroundColor(.secondary.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
    }
    
    // MARK: - Helper
    
    private func addNewTask() {
        viewModel.addTask(newTaskTitle)
        newTaskTitle = ""
        isInputFocused = false
    }
}

// MARK: - Task Row View

struct TaskRowView: View {
    let task: TaskItem
    let onToggle: () -> Void
    let onDelete: () -> Void
    
    @State private var offset: CGFloat = 0
    
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yyyy HH:mm"
        return f
    }
    
    var body: some View {
        HStack(spacing: 14) {
            // Checkbox
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(task.isCompleted ? .green : .secondary)
                    .contentTransition(.symbolEffect(.replace))
            }
            .buttonStyle(.plain)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.subheadline)
                    .fontWeight(task.isCompleted ? .regular : .medium)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .secondary : .primary)
                
                Text(dateFormatter.string(from: task.createdAt))
                    .font(.caption2)
                    .foregroundColor(.secondary.opacity(0.7))
            }
            
            Spacer()
            
            // Delete button
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .font(.caption)
                    .foregroundColor(.red.opacity(0.6))
                    .padding(8)
                    .background(Circle().fill(Color.red.opacity(0.1)))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - Preview

#Preview {
    TaskChecklistView()
}
