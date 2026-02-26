//
//  GitCommandListView.swift
//  LearnGit_SourceTree
//
//  Created by Trần Chí Thiện on 27/2/26.
//

import SwiftUI

// MARK: - Data Model

struct GitCommand: Identifiable {
    let id = UUID()
    let command: String
    let description: String
    let example: String
}

struct GitCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let commands: [GitCommand]
}

// MARK: - Data

let gitCategories: [GitCategory] = [
    GitCategory(
        name: "Cấu hình (Config)",
        icon: "gearshape.fill",
        color: .purple,
        commands: [
            GitCommand(command: "git config --global user.name", description: "Đặt tên người dùng toàn cục", example: "git config --global user.name \"Tên của bạn\""),
            GitCommand(command: "git config --global user.email", description: "Đặt email người dùng toàn cục", example: "git config --global user.email \"email@example.com\""),
            GitCommand(command: "git config --list", description: "Xem tất cả cấu hình hiện tại", example: "git config --list"),
        ]
    ),
    GitCategory(
        name: "Khởi tạo & Clone",
        icon: "arrow.down.doc.fill",
        color: .blue,
        commands: [
            GitCommand(command: "git init", description: "Khởi tạo repository mới", example: "git init"),
            GitCommand(command: "git clone", description: "Sao chép repository từ remote", example: "git clone https://github.com/user/repo.git"),
        ]
    ),
    GitCategory(
        name: "Thay đổi cơ bản",
        icon: "pencil.circle.fill",
        color: .green,
        commands: [
            GitCommand(command: "git status", description: "Kiểm tra trạng thái working directory", example: "git status"),
            GitCommand(command: "git add", description: "Thêm file vào staging area", example: "git add file.txt\ngit add ."),
            GitCommand(command: "git commit", description: "Lưu thay đổi vào repository", example: "git commit -m \"Mô tả commit\""),
            GitCommand(command: "git diff", description: "Xem sự khác biệt giữa các thay đổi", example: "git diff\ngit diff --staged"),
            GitCommand(command: "git rm", description: "Xoá file khỏi working directory và staging", example: "git rm file.txt"),
            GitCommand(command: "git mv", description: "Di chuyển hoặc đổi tên file", example: "git mv old_name.txt new_name.txt"),
        ]
    ),
    GitCategory(
        name: "Nhánh (Branch)",
        icon: "arrow.triangle.branch",
        color: .orange,
        commands: [
            GitCommand(command: "git branch", description: "Liệt kê, tạo hoặc xoá nhánh", example: "git branch\ngit branch new-branch\ngit branch -d old-branch"),
            GitCommand(command: "git checkout", description: "Chuyển đổi nhánh hoặc khôi phục file", example: "git checkout branch-name\ngit checkout -b new-branch"),
            GitCommand(command: "git switch", description: "Chuyển đổi nhánh (lệnh mới)", example: "git switch branch-name\ngit switch -c new-branch"),
            GitCommand(command: "git merge", description: "Gộp nhánh khác vào nhánh hiện tại", example: "git merge feature-branch"),
            GitCommand(command: "git rebase", description: "Áp dụng lại commit trên base khác", example: "git rebase main"),
        ]
    ),
    GitCategory(
        name: "Lịch sử & Log",
        icon: "clock.fill",
        color: .cyan,
        commands: [
            GitCommand(command: "git log", description: "Xem lịch sử commit", example: "git log\ngit log --oneline\ngit log --graph"),
            GitCommand(command: "git show", description: "Xem chi tiết một commit", example: "git show abc1234"),
            GitCommand(command: "git blame", description: "Xem ai đã thay đổi từng dòng", example: "git blame file.txt"),
            GitCommand(command: "git reflog", description: "Xem lịch sử tham chiếu HEAD", example: "git reflog"),
        ]
    ),
    GitCategory(
        name: "Remote",
        icon: "cloud.fill",
        color: .indigo,
        commands: [
            GitCommand(command: "git remote", description: "Quản lý remote repository", example: "git remote -v\ngit remote add origin URL"),
            GitCommand(command: "git fetch", description: "Tải dữ liệu từ remote (không merge)", example: "git fetch origin"),
            GitCommand(command: "git pull", description: "Tải và merge dữ liệu từ remote", example: "git pull origin main"),
            GitCommand(command: "git push", description: "Đẩy thay đổi lên remote", example: "git push origin main\ngit push -u origin main"),
        ]
    ),
    GitCategory(
        name: "Stash",
        icon: "archivebox.fill",
        color: .brown,
        commands: [
            GitCommand(command: "git stash", description: "Lưu tạm thay đổi chưa commit", example: "git stash\ngit stash save \"mô tả\""),
            GitCommand(command: "git stash list", description: "Liệt kê các stash đã lưu", example: "git stash list"),
            GitCommand(command: "git stash pop", description: "Áp dụng stash gần nhất và xoá", example: "git stash pop"),
            GitCommand(command: "git stash apply", description: "Áp dụng stash mà không xoá", example: "git stash apply stash@{0}"),
        ]
    ),
    GitCategory(
        name: "Hoàn tác (Undo)",
        icon: "arrow.uturn.backward.circle.fill",
        color: .red,
        commands: [
            GitCommand(command: "git reset", description: "Huỷ staging hoặc quay về commit trước", example: "git reset HEAD file.txt\ngit reset --hard HEAD~1"),
            GitCommand(command: "git revert", description: "Tạo commit đảo ngược thay đổi", example: "git revert abc1234"),
            GitCommand(command: "git restore", description: "Khôi phục file về trạng thái trước", example: "git restore file.txt\ngit restore --staged file.txt"),
            GitCommand(command: "git clean", description: "Xoá file không được theo dõi", example: "git clean -fd"),
        ]
    ),
    GitCategory(
        name: "Tag",
        icon: "tag.fill",
        color: .pink,
        commands: [
            GitCommand(command: "git tag", description: "Tạo, liệt kê hoặc xoá tag", example: "git tag v1.0\ngit tag -a v1.0 -m \"Version 1.0\""),
            GitCommand(command: "git push --tags", description: "Đẩy tất cả tag lên remote", example: "git push --tags"),
        ]
    ),
]

// MARK: - Main View

struct GitCommandListView: View {
    @State private var searchText = ""
    @State private var expandedCategories: Set<UUID> = []
    
    var filteredCategories: [GitCategory] {
        if searchText.isEmpty {
            return gitCategories
        }
        return gitCategories.compactMap { category in
            let filtered = category.commands.filter {
                $0.command.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
            if filtered.isEmpty { return nil }
            return GitCategory(name: category.name, icon: category.icon, color: category.color, commands: filtered)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color(.systemBackground), Color(.systemGray6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        // Header card
                        headerCard
                        
                        // Categories
                        ForEach(filteredCategories) { category in
                            CategoryCardView(
                                category: category,
                                isExpanded: expandedCategories.contains(category.id),
                                onToggle: {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        if expandedCategories.contains(category.id) {
                                            expandedCategories.remove(category.id)
                                        } else {
                                            expandedCategories.insert(category.id)
                                        }
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Git Commands")
            .searchable(text: $searchText, prompt: "Tìm kiếm lệnh Git...")
        }
    }
    
    // MARK: - Header Card
    
    private var headerCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "terminal.fill")
                .font(.system(size: 40))
                .foregroundStyle(
                    LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            Text("Danh sách câu lệnh Git")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Tổng hợp \(gitCategories.flatMap(\.commands).count) câu lệnh thường dùng")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
        )
    }
}

// MARK: - Category Card View

struct CategoryCardView: View {
    let category: GitCategory
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Category header
            Button(action: onToggle) {
                HStack(spacing: 14) {
                    Image(systemName: category.icon)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(category.color.gradient)
                        )
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(category.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("\(category.commands.count) câu lệnh")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                .padding(16)
            }
            .buttonStyle(.plain)
            
            // Expanded commands
            if isExpanded {
                Divider()
                    .padding(.horizontal, 16)
                
                VStack(spacing: 0) {
                    ForEach(Array(category.commands.enumerated()), id: \.element.id) { index, command in
                        CommandRowView(command: command)
                        
                        if index < category.commands.count - 1 {
                            Divider()
                                .padding(.leading, 16)
                        }
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.06), radius: 8, y: 3)
        )
    }
}

// MARK: - Command Row View

struct CommandRowView: View {
    let command: GitCommand
    @State private var showExample = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(command.command)
                        .font(.system(.subheadline, design: .monospaced))
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                    
                    Text(command.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showExample.toggle()
                    }
                } label: {
                    Image(systemName: showExample ? "chevron.up.circle.fill" : "info.circle.fill")
                        .font(.title3)
                        .foregroundColor(.blue.opacity(0.7))
                }
                .buttonStyle(.plain)
            }
            
            if showExample {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ví dụ:")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    
                    Text(command.example)
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(.green)
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.black.opacity(0.85))
                        )
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
            }
        }
        .padding(16)
    }
}

// MARK: - Preview

#Preview {
    GitCommandListView()
}
