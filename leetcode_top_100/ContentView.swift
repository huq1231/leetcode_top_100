//
//  ContentView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager()
    @State private var showSettings = false

    var body: some View {
        NavigationView {
            ProblemListView()
                .environmentObject(dataManager)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showSettings = true
                        }) {
                            UserAvatarView(size: 40)
                        }
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }


#Preview {
    ContentView()
}
