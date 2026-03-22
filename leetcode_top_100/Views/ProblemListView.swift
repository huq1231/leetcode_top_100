//
//  ProblemListView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI

struct ProblemListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedFilter: FilterOption = .all
    @State private var showStatistics = false

    private var filteredProblems: [Problem] {
        switch selectedFilter {
        case .all:
            return dataManager.problems
        case .completed:
            return dataManager.problems.filter { $0.isCompleted }
        case .uncompleted:
            return dataManager.problems.filter { !$0.isCompleted }
        case .easy:
            return dataManager.problems.filter { $0.difficulty == .easy }
        case .medium:
            return dataManager.problems.filter { $0.difficulty == .medium }
        case .hard:
            return dataManager.problems.filter { $0.difficulty == .hard }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header with statistics
                headerView

                // Filter chips
                filterChips

                // Problem list
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredProblems) { problem in
                            NavigationLink {
                                ProblemDetailView(problem: problem)
                            } label: {
                                ProblemCellView(problem: problem)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(AppStrings.problemsTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showStatistics = true
                    }) {
                        Image(systemName: "chart.bar.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showStatistics) {
                StatisticsView()
            }
        }
    }

    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(dataManager.statistics.completedProblems)/\(dataManager.statistics.totalProblems)")
                        .font(.title.bold())
                    Text(AppStrings.problemsSolved)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(Int(dataManager.statistics.completionRate))%")
                        .font(.title.bold())
                    Text(AppStrings.completionRate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            ProgressView(value: dataManager.statistics.completionRate, total: 100)
                .accentColor(.blue)
                .frame(height: 4)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(FilterOption.allCases, id: \.self) { filter in
                    FilterChipView(
                        title: filter.title,
                        isSelected: selectedFilter == filter,
                        action: { selectedFilter = filter }
                    )
                }
            }
            .padding(.horizontal)
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

enum FilterOption: CaseIterable {
    case all, completed, uncompleted, easy, medium, hard

    var title: String {
        switch self {
        case .all: return AppStrings.allProblems
        case .completed: return AppStrings.completedProblems
        case .uncompleted: return AppStrings.todoProblems
        case .easy: return AppStrings.easy
        case .medium: return AppStrings.medium
        case .hard: return AppStrings.hard
        }
    }
}

#Preview {
    ProblemListView()
        .environmentObject(DataManager())
}