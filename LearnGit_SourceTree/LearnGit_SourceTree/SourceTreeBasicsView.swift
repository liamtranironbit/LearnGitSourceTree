//
//  SourceTreeBasicsView.swift
//  LearnGit_SourceTree
//
//  Created by Trần Chí Thiện on 27/2/26.
//

import SwiftUI

// MARK: - Data Model

struct SourceTreeStep: Identifiable {
    let id = UUID()
    let stepNumber: Int
    let title: String
    let description: String
    let tip: String?
}

struct SourceTreeSection: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let steps: [SourceTreeStep]
}

// MARK: - Data

let sourceTreeSections: [SourceTreeSection] = [
    SourceTreeSection(
        name: "Cài đặt & Cấu hình",
        icon: "arrow.down.app.fill",
        color: .blue,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Tải SourceTree", description: "Truy cập sourcetreeapp.com, tải và cài đặt phiên bản phù hợp với hệ điều hành của bạn (macOS hoặc Windows).", tip: "SourceTree miễn phí nhưng cần tạo tài khoản Atlassian."),
            SourceTreeStep(stepNumber: 2, title: "Đăng nhập Atlassian", description: "Mở SourceTree lần đầu, đăng nhập bằng tài khoản Atlassian hoặc tạo tài khoản mới.", tip: nil),
            SourceTreeStep(stepNumber: 3, title: "Cấu hình Git", description: "Vào Preferences (⌘ + ,) → General, điền Full Name và Email Address. Đây là thông tin sẽ hiển thị trong mỗi commit.", tip: "Email nên trùng với email GitHub/GitLab của bạn."),
        ]
    ),
    SourceTreeSection(
        name: "Clone Repository",
        icon: "square.and.arrow.down.fill",
        color: .indigo,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Mở cửa sổ Clone", description: "Nhấn File → New → Clone from URL, hoặc nhấn nút + trên tab bar và chọn Clone.", tip: nil),
            SourceTreeStep(stepNumber: 2, title: "Nhập URL", description: "Dán URL của repository (ví dụ: https://github.com/user/repo.git) vào ô Source URL.", tip: "Bạn có thể lấy URL từ nút 'Code' trên GitHub."),
            SourceTreeStep(stepNumber: 3, title: "Chọn thư mục", description: "Chọn Destination Path — nơi lưu project trên máy. Nhấn Clone để bắt đầu.", tip: nil),
        ]
    ),
    SourceTreeSection(
        name: "Tạo Repository mới",
        icon: "plus.rectangle.fill",
        color: .green,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Tạo Local Repository", description: "Nhấn File → New → Create Local Repository. Chọn thư mục dự án và nhấn Create.", tip: nil),
            SourceTreeStep(stepNumber: 2, title: "Thêm Remote (tuỳ chọn)", description: "Click phải vào Remotes ở sidebar → Add Remote. Nhập tên (thường là 'origin') và URL remote.", tip: "Tạo repo trống trên GitHub trước rồi copy URL."),
        ]
    ),
    SourceTreeSection(
        name: "Stage & Commit",
        icon: "checkmark.circle.fill",
        color: .orange,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Xem thay đổi", description: "Mở tab File Status (ở trên). Bạn sẽ thấy danh sách file đã thay đổi trong Unstaged files.", tip: "Click vào file để xem diff (sự khác biệt) ở bên phải."),
            SourceTreeStep(stepNumber: 2, title: "Stage files", description: "Tick vào checkbox bên cạnh file để stage, hoặc nhấn Stage All để stage tất cả.", tip: "Stage = chọn file nào sẽ được đưa vào commit tiếp theo."),
            SourceTreeStep(stepNumber: 3, title: "Viết Commit Message", description: "Nhập mô tả commit vào ô ở dưới cùng. Mô tả nên ngắn gọn, rõ ràng.", tip: "Ví dụ: \"Thêm tính năng đăng nhập\" thay vì \"update code\"."),
            SourceTreeStep(stepNumber: 4, title: "Nhấn Commit", description: "Nhấn nút Commit ở góc dưới bên phải. Thay đổi đã được lưu vào lịch sử local.", tip: nil),
        ]
    ),
    SourceTreeSection(
        name: "Push & Pull",
        icon: "arrow.up.arrow.down.circle.fill",
        color: .purple,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Push lên Remote", description: "Nhấn nút Push trên toolbar (mũi tên lên). Chọn branch cần push và nhấn OK.", tip: "Push = đẩy commit từ máy lên GitHub/GitLab."),
            SourceTreeStep(stepNumber: 2, title: "Pull từ Remote", description: "Nhấn nút Pull trên toolbar (mũi tên xuống). Chọn remote branch và nhấn OK.", tip: "Pull = tải commit mới từ remote về máy và merge."),
            SourceTreeStep(stepNumber: 3, title: "Fetch", description: "Nhấn nút Fetch để kiểm tra xem remote có commit mới không (không merge tự động).", tip: "Fetch an toàn hơn Pull vì không thay đổi code trên máy."),
        ]
    ),
    SourceTreeSection(
        name: "Branch (Nhánh)",
        icon: "arrow.triangle.branch",
        color: .cyan,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Tạo branch mới", description: "Nhấn nút Branch trên toolbar. Nhập tên branch mới và nhấn Create Branch.", tip: "Đặt tên theo quy ước: feature/ten-tinh-nang, bugfix/ten-loi."),
            SourceTreeStep(stepNumber: 2, title: "Chuyển branch", description: "Double-click vào tên branch trong sidebar bên trái (dưới Branches) để chuyển sang branch đó.", tip: "Branch hiện tại sẽ được in đậm trong sidebar."),
            SourceTreeStep(stepNumber: 3, title: "Merge branch", description: "Đứng ở branch đích (ví dụ: main). Click chuột phải vào branch muốn merge → Merge vào current branch.", tip: "Luôn pull code mới nhất trước khi merge."),
            SourceTreeStep(stepNumber: 4, title: "Xoá branch", description: "Click chuột phải vào branch → Delete. Tick 'Force delete' nếu branch chưa được merge.", tip: nil),
        ]
    ),
    SourceTreeSection(
        name: "Xem lịch sử (History)",
        icon: "clock.arrow.circlepath",
        color: .teal,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Mở History", description: "Click vào tab History ở trên cùng. Bạn sẽ thấy cây commit với các nhánh đầy màu sắc.", tip: nil),
            SourceTreeStep(stepNumber: 2, title: "Xem chi tiết commit", description: "Click vào bất kỳ commit nào để xem: tác giả, thời gian, message, và danh sách file thay đổi.", tip: nil),
            SourceTreeStep(stepNumber: 3, title: "So sánh thay đổi", description: "Click vào file trong commit để xem diff — dòng xanh là thêm mới, dòng đỏ là đã xoá.", tip: nil),
        ]
    ),
    SourceTreeSection(
        name: "Stash (Lưu tạm)",
        icon: "archivebox.fill",
        color: .brown,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Tạo Stash", description: "Nhấn nút Stash trên toolbar. Nhập mô tả và nhấn OK. Thay đổi sẽ được lưu tạm.", tip: "Dùng khi bạn cần chuyển branch mà chưa muốn commit."),
            SourceTreeStep(stepNumber: 2, title: "Áp dụng Stash", description: "Mở Stashes trong sidebar bên trái. Click chuột phải vào stash → Apply Stash.", tip: "Apply giữ stash, còn Apply and Delete sẽ xoá stash sau khi áp dụng."),
        ]
    ),
    SourceTreeSection(
        name: "Giải quyết xung đột (Conflict)",
        icon: "exclamationmark.triangle.fill",
        color: .red,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Conflict là gì?", description: "Conflict xảy ra khi 2 người (hoặc 2 branch) cùng sửa CÙNG MỘT DÒNG trong cùng một file. Git không biết nên giữ phiên bản nào → yêu cầu bạn giải quyết thủ công.", tip: "Conflict thường xảy ra khi merge, pull, rebase, hoặc cherry-pick."),
            SourceTreeStep(stepNumber: 2, title: "Nhận biết Conflict trong SourceTree", description: "Khi có conflict, SourceTree sẽ: (1) Hiện cảnh báo 'Merge conflicts' trên toolbar, (2) File bị conflict có icon ⚠️ cam trong File Status, (3) Trạng thái file hiển thị 'Unmerged'.", tip: "Không thể commit khi còn file conflict chưa giải quyết."),
            SourceTreeStep(stepNumber: 3, title: "Ký hiệu Conflict trong file", description: "Mở file bị conflict, bạn sẽ thấy các ký hiệu đặc biệt:\n\n<<<<<<< HEAD\n(Code của bạn - branch hiện tại)\n=======\n(Code từ branch khác)\n>>>>>>> feature-branch", tip: "<<<<<<< HEAD = phần code CỦA BẠN.\n======= = ranh giới phân cách.\n>>>>>>> = phần code TỪ BRANCH KHÁC."),
            SourceTreeStep(stepNumber: 4, title: "Cách đọc Conflict", description: "Phần TRÊN dấu ======= là code trên branch hiện tại (HEAD/mine). Phần DƯỚI dấu ======= là code từ branch đang merge vào (theirs). Bạn cần chọn giữ phần nào, hoặc kết hợp cả hai.", tip: nil),
            SourceTreeStep(stepNumber: 5, title: "Giải quyết bằng SourceTree", description: "Click chuột phải vào file conflict → Resolve Conflicts → chọn:\n• Resolve Using Mine: giữ code của bạn\n• Resolve Using Theirs: lấy code từ branch khác\n• Open External Merge Tool: mở tool so sánh", tip: "Mine = giữ code CỦA BẠN (HEAD).\nTheirs = lấy code TỪ BRANCH KHÁC."),
            SourceTreeStep(stepNumber: 6, title: "Giải quyết thủ công (khuyên dùng)", description: "Mở file bằng editor (VS Code, Xcode...). Tìm các ký hiệu <<<<<<<, =======, >>>>>>>. Xoá các ký hiệu đó và chỉ giữ lại code đúng. Có thể kết hợp code từ cả 2 phiên bản.", tip: "⚠️ Phải xoá HẾT các dòng <<<<<<<, =======, >>>>>>> nếu không code sẽ lỗi!"),
            SourceTreeStep(stepNumber: 7, title: "Lỗi thường gặp khi có Conflict", description: "• Quên xoá ký hiệu <<<<<<< ======= >>>>>>> → code bị lỗi cú pháp\n• Chọn sai Mine/Theirs → mất code của người khác\n• Commit khi chưa giải quyết hết conflict\n• Không test lại code sau khi resolve", tip: "Luôn build và test lại sau khi giải quyết conflict!"),
            SourceTreeStep(stepNumber: 8, title: "Đánh dấu đã giải quyết", description: "Sau khi sửa xong TẤT CẢ file conflict: Click chuột phải vào file → Mark Resolved, hoặc stage file đó. Làm lần lượt cho từng file.", tip: nil),
            SourceTreeStep(stepNumber: 9, title: "Commit kết quả", description: "Sau khi tất cả conflict đã resolved, SourceTree sẽ tự điền commit message (thường là 'Merge branch...'). Nhấn Commit để hoàn tất.", tip: "Có thể sửa commit message cho rõ ràng hơn, ví dụ: 'Merge feature/login, resolve conflict in UserService'."),
            SourceTreeStep(stepNumber: 10, title: "Cách tránh Conflict", description: "• Pull/fetch thường xuyên để cập nhật code mới\n• Chia nhỏ task, tránh nhiều người sửa cùng file\n• Merge branch main vào feature branch thường xuyên\n• Giao tiếp với team về file đang sửa", tip: "Conflict là chuyện bình thường, không phải lỗi! Đừng lo lắng khi gặp."),
        ]
    ),
    SourceTreeSection(
        name: "Merge (Gộp nhánh)",
        icon: "arrow.triangle.merge",
        color: .mint,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Chuyển sang branch đích", description: "Double-click vào branch bạn muốn merge VÀO (ví dụ: main hoặc develop) trong sidebar để checkout.", tip: "Luôn fetch/pull trước khi merge để có code mới nhất."),
            SourceTreeStep(stepNumber: 2, title: "Bắt đầu Merge", description: "Click chuột phải vào branch muốn merge (ví dụ: feature/login) → chọn 'Merge feature/login into main'.", tip: nil),
            SourceTreeStep(stepNumber: 3, title: "Chọn kiểu Merge", description: "SourceTree sẽ hiện tuỳ chọn: tạo merge commit hoặc fast-forward. Thường nên tạo merge commit để giữ lịch sử rõ ràng.", tip: "Tick 'Create a commit even if fast-forward is possible' nếu muốn luôn có merge commit."),
            SourceTreeStep(stepNumber: 4, title: "Xử lý Conflict (nếu có)", description: "Nếu có conflict, SourceTree sẽ báo. Click chuột phải file conflict → Resolve Conflicts. Sau đó stage và commit.", tip: "Dùng External Merge Tool (ví dụ: VS Code) để xử lý conflict dễ hơn."),
            SourceTreeStep(stepNumber: 5, title: "Push kết quả", description: "Sau khi merge thành công, nhấn Push để đẩy kết quả lên remote.", tip: nil),
        ]
    ),
    SourceTreeSection(
        name: "Cherry-pick",
        icon: "arrow.right.circle.fill",
        color: .pink,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Chuyển sang branch đích", description: "Checkout branch mà bạn muốn áp dụng commit vào (ví dụ: main).", tip: "Cherry-pick = chọn 1 commit cụ thể từ nhánh khác để áp dụng."),
            SourceTreeStep(stepNumber: 2, title: "Tìm commit cần cherry-pick", description: "Mở tab History. Tìm commit muốn lấy — có thể ở branch khác. Click vào branch đó trong sidebar để xem.", tip: "Ghi nhớ mã hash của commit để dễ tìm."),
            SourceTreeStep(stepNumber: 3, title: "Thực hiện Cherry-pick", description: "Click chuột phải vào commit → chọn 'Cherry Pick'. SourceTree sẽ áp dụng commit đó vào branch hiện tại.", tip: nil),
            SourceTreeStep(stepNumber: 4, title: "Xử lý Conflict (nếu có)", description: "Nếu commit xung đột với code hiện tại, giải quyết conflict giống như khi merge. Stage và commit sau khi sửa.", tip: "Cherry-pick chỉ lấy 1 commit, không lấy toàn bộ lịch sử của branch nguồn."),
            SourceTreeStep(stepNumber: 5, title: "Push kết quả", description: "Nhấn Push để đẩy commit cherry-pick lên remote.", tip: nil),
        ]
    ),
    SourceTreeSection(
        name: "Rebase",
        icon: "arrow.triangle.swap",
        color: .yellow,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Hiểu Rebase là gì", description: "Rebase = di chuyển toàn bộ commit của branch hiện tại lên đầu branch khác. Giúp lịch sử commit thẳng hàng, gọn gàng.", tip: "⚠️ KHÔNG rebase branch đã push và có người khác dùng chung!"),
            SourceTreeStep(stepNumber: 2, title: "Checkout branch cần rebase", description: "Double-click vào branch muốn rebase (ví dụ: feature/login) trong sidebar.", tip: nil),
            SourceTreeStep(stepNumber: 3, title: "Thực hiện Rebase", description: "Click chuột phải vào branch đích (ví dụ: main) → chọn 'Rebase current changes onto main'.", tip: "Rebase sẽ áp dụng từng commit một lên đầu branch đích."),
            SourceTreeStep(stepNumber: 4, title: "Xử lý Conflict từng bước", description: "Nếu có conflict, SourceTree sẽ dừng ở commit bị conflict. Sửa conflict → stage → nhấn Actions → Continue Rebase.", tip: "Nếu muốn huỷ rebase, nhấn Actions → Abort Rebase."),
            SourceTreeStep(stepNumber: 5, title: "Force Push (nếu cần)", description: "Sau khi rebase, nếu branch đã push trước đó, cần Force Push. Nhấn Push → tick 'Force Push'.", tip: "⚠️ Force Push sẽ ghi đè lịch sử remote. Chỉ dùng khi bạn là người duy nhất làm trên branch đó."),
            SourceTreeStep(stepNumber: 6, title: "Interactive Rebase (nâng cao)", description: "Click chuột phải vào commit → 'Rebase children of [commit] interactively'. Có thể squash, reorder, edit commit.", tip: "Dùng để gộp nhiều commit nhỏ thành 1 commit gọn gàng trước khi merge."),
        ]
    ),
    SourceTreeSection(
        name: "Revert (Đảo ngược commit)",
        icon: "arrow.uturn.backward.circle.fill",
        color: .red,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Hiểu Revert là gì", description: "Revert tạo một commit MỚI để đảo ngược thay đổi của một commit cũ. Lịch sử commit được giữ nguyên, an toàn cho branch chung.", tip: "Revert an toàn hơn Reset vì không xoá lịch sử."),
            SourceTreeStep(stepNumber: 2, title: "Tìm commit cần revert", description: "Mở tab History. Tìm commit mà bạn muốn đảo ngược thay đổi.", tip: nil),
            SourceTreeStep(stepNumber: 3, title: "Thực hiện Revert", description: "Click chuột phải vào commit → chọn 'Reverse commit'. SourceTree sẽ tạo commit mới đảo ngược toàn bộ thay đổi.", tip: nil),
            SourceTreeStep(stepNumber: 4, title: "Xử lý Conflict (nếu có)", description: "Nếu revert gây conflict (do code đã thay đổi thêm sau commit đó), giải quyết conflict → stage → commit.", tip: "Conflict thường xảy ra khi revert commit cũ mà code sau đó đã thay đổi nhiều."),
            SourceTreeStep(stepNumber: 5, title: "Push kết quả", description: "Nhấn Push để đẩy commit revert lên remote. Không cần Force Push vì revert không thay đổi lịch sử.", tip: nil),
        ]
    ),
    SourceTreeSection(
        name: "Reset (Quay về commit trước)",
        icon: "arrow.counterclockwise.circle.fill",
        color: .gray,
        steps: [
            SourceTreeStep(stepNumber: 1, title: "Hiểu Reset là gì", description: "Reset di chuyển HEAD về commit trước đó. Tuỳ chế độ, code có thể bị xoá hoặc giữ lại. ⚠️ Reset thay đổi lịch sử!", tip: "⚠️ CHỈ dùng Reset trên branch cá nhân, KHÔNG dùng trên branch chung!"),
            SourceTreeStep(stepNumber: 2, title: "Tìm commit muốn quay về", description: "Mở tab History. Tìm commit mà bạn muốn quay về (các commit sau nó sẽ bị ảnh hưởng).", tip: nil),
            SourceTreeStep(stepNumber: 3, title: "Chọn kiểu Reset", description: "Click chuột phải vào commit → 'Reset current branch to this commit'. Chọn một trong 3 chế độ:", tip: nil),
            SourceTreeStep(stepNumber: 4, title: "Soft Reset", description: "Giữ tất cả thay đổi trong staging area. Code không mất, chỉ di chuyển HEAD. Dùng khi muốn gộp commit.", tip: "Soft = an toàn nhất, code vẫn sẵn sàng để commit lại."),
            SourceTreeStep(stepNumber: 5, title: "Mixed Reset (mặc định)", description: "Giữ thay đổi trong working directory nhưng unstage tất cả. Code không mất nhưng cần stage lại.", tip: "Mixed = mặc định, phù hợp khi muốn chỉnh sửa lại trước khi commit."),
            SourceTreeStep(stepNumber: 6, title: "Hard Reset", description: "Xoá TOÀN BỘ thay đổi. Code quay về trạng thái của commit được chọn. Không thể hoàn tác!", tip: "⚠️ Hard Reset rất nguy hiểm! Kiểm tra kỹ trước khi dùng. Dùng git reflog nếu cần khôi phục."),
            SourceTreeStep(stepNumber: 7, title: "Force Push (nếu đã push)", description: "Nếu branch đã push, cần Force Push sau khi reset. Nhấn Push → tick 'Force Push'.", tip: "⚠️ Chỉ Force Push khi bạn là người duy nhất làm trên branch đó."),
        ]
    ),
]

// MARK: - Main View

struct SourceTreeBasicsView: View {
    @State private var expandedSections: Set<UUID> = []
    @State private var searchText = ""
    
    var filteredSections: [SourceTreeSection] {
        if searchText.isEmpty {
            return sourceTreeSections
        }
        return sourceTreeSections.compactMap { section in
            let filtered = section.steps.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
            if filtered.isEmpty { return nil }
            return SourceTreeSection(name: section.name, icon: section.icon, color: section.color, steps: filtered)
        }
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
                    LazyVStack(spacing: 16) {
                        // Header
                        sourceTreeHeader
                        
                        // Sections
                        ForEach(filteredSections) { section in
                            SectionCardView(
                                section: section,
                                isExpanded: expandedSections.contains(section.id),
                                onToggle: {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        if expandedSections.contains(section.id) {
                                            expandedSections.remove(section.id)
                                        } else {
                                            expandedSections.insert(section.id)
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
            .navigationTitle("SourceTree")
            .searchable(text: $searchText, prompt: "Tìm kiếm thao tác...")
        }
    }
    
    // MARK: - Header
    
    private var sourceTreeHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: "point.3.connected.trianglepath.dotted")
                .font(.system(size: 40))
                .foregroundStyle(
                    LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            Text("Thao tác cơ bản trên SourceTree")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Hướng dẫn từng bước cho \(sourceTreeSections.count) nhóm thao tác")
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

// MARK: - Section Card View

struct SectionCardView: View {
    let section: SourceTreeSection
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Button(action: onToggle) {
                HStack(spacing: 14) {
                    Image(systemName: section.icon)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(section.color.gradient)
                        )
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(section.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("\(section.steps.count) bước")
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
            
            // Steps
            if isExpanded {
                Divider()
                    .padding(.horizontal, 16)
                
                VStack(spacing: 0) {
                    ForEach(Array(section.steps.enumerated()), id: \.element.id) { index, step in
                        StepRowView(step: step)
                        
                        if index < section.steps.count - 1 {
                            Divider()
                                .padding(.leading, 60)
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

// MARK: - Step Row View

struct StepRowView: View {
    let step: SourceTreeStep
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Step number badge
            Text("\(step.stepNumber)")
                .font(.caption.weight(.bold))
                .foregroundColor(.white)
                .frame(width: 26, height: 26)
                .background(Circle().fill(Color.blue.gradient))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(step.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(step.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                if let tip = step.tip {
                    HStack(alignment: .top, spacing: 6) {
                        Image(systemName: "lightbulb.fill")
                            .font(.caption2)
                            .foregroundColor(.yellow)
                        
                        Text(tip)
                            .font(.caption2)
                            .foregroundColor(.orange)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.orange.opacity(0.1))
                    )
                }
            }
        }
        .padding(16)
    }
}

// MARK: - Preview

#Preview {
    SourceTreeBasicsView()
}
