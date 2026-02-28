//
//  ContentView.swift
//  LearnGit_SourceTree
//
//  Created by Trần Chí Thiện on 27/2/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GitCommandListView()
                .tabItem {
                    Label("Git Commands", systemImage: "terminal.fill")
                }
            
            SourceTreeBasicsView()
                .tabItem {
                    Label("SourceTree", systemImage: "point.3.connected.trianglepath.dotted")
                }
            
            TaskChecklistView()
                .tabItem {
                    Label("Checklist", systemImage: "checklist")
                }
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView()
}
