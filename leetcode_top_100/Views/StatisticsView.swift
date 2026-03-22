//
//  StatisticsView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Overall stats
                overviewSection

                // Progress charts
                progressSection

                // Time tracking
                timeSection

                // Categories breakdown
                categoriesSection

                // Streak info
                streakSection
            }
            .padding()
            .navigationTitle(AppStrings.statisticsTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
        }
    }

    private var overviewSection: some View {
        VStack(spacing: 20) {
            Text(AppStrings.overviewProgress)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 30) {
                StatCard(
                    title: AppStrings.solvedCount,
                    value: "\(dataManager.statistics.completedProblems)",
                    color: .green
                )

                StatCard(
                    title: AppStrings.totalCount,
                    value: "\(dataManager.statistics.totalProblems)",
                    color: .blue
                )
            }

            StatCard(
                title: AppStrings.completionRate,
                value: "\(Int(dataManager.statistics.completionRate))%",
                color: .purple,
                progress: dataManager.statistics.completionRate / 100
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }

    private var progressSection: some View {
        SectionView(title: AppStrings.progressByDifficulty) {
            VStack(spacing: 16) {
                difficultyRow(difficulty: .easy)
                difficultyRow(difficulty: .medium)
                difficultyRow(difficulty: .hard)
            }
        }
    }

    private func difficultyRow(difficulty: Problem.Difficulty) -> some View {
        let problems = dataManager.problems.filter { $0.difficulty == difficulty }
        let completed = problems.filter { $0.isCompleted }.count
        let percentage = problems.isEmpty ? 0 : Double(completed) / Double(problems.count) * 100

        let difficultyText: String
        switch difficulty {
        case .easy: difficultyText = AppStrings.easy
        case .medium: difficultyText = AppStrings.medium
        case .hard: difficultyText = AppStrings.hard
        }

        return VStack(spacing: 8) {
            HStack {
                Text(difficultyText)
                    .font(.body)
                    .fontWeight(.medium)

                Spacer()

                Text("\(completed)/\(problems.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            ProgressView(value: percentage, total: 100)
                .tint(difficultyColor(for: difficulty))
        }
    }

    private var timeSection: some View {
        SectionView(title: AppStrings.timeTracking) {
            VStack(spacing: 16) {
                StatCard(
                    title: AppStrings.totalTime,
                    value: formatTime(dataManager.statistics.totalTimeSpent),
                    color: .orange
                )

                StatCard(
                    title: AppStrings.averageTime,
                    value: formatTime(dataManager.statistics.averageTimePerProblem),
                    color: .yellow
                )
            }
        }
    }

    private var categoriesSection: some View {
        SectionView(title: AppStrings.categories) {
            let categoryGroups = Dictionary(grouping: dataManager.problems, by: { $0.category })

            VStack(spacing: 12) {
                ForEach(categoryGroups.keys.sorted(), id: \.self) { category in
                    let problems = categoryGroups[category] ?? []
                    let completed = problems.filter { $0.isCompleted }.count
                    let percentage = problems.isEmpty ? 0 : Double(completed) / Double(problems.count) * 100

                    HStack {
                        Text(category)
                            .font(.body)

                        Spacer()

                        Text("\(Int(percentage))%")
                            .font(.caption)
                            .fontWeight(.medium)
                    }

                    ProgressView(value: percentage, total: 100)
                        .tint(.blue)
                        .progressViewStyle(.linear)
                        .frame(height: 6)
                }
            }
        }
    }

    private var streakSection: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(AppStrings.currentStreak)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("\(dataManager.statistics.currentStreak) 天")
                        .font(.title.bold())
                        .foregroundColor(.orange)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(AppStrings.longestStreak)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("\(dataManager.statistics.longestStreak) 天")
                        .font(.title.bold())
                        .foregroundColor(.red)
                }
            }

            if dataManager.statistics.currentStreak > 0 {
                HStack {
                    Image(systemName: "flame.fill")
                        .font(.title)
                        .foregroundColor(.orange)

                    Text(AppStrings.keepItUp)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange.opacity(0.1))
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }

    private func difficultyColor(for difficulty: Problem.Difficulty) -> Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }

    private func formatTime(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60

        if hours > 0 {
            return "\(hours)小时 \(minutes)分钟"
        } else {
            return "\(minutes)分钟"
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    var progress: Double = 0

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.body)
                .foregroundColor(.secondary)

            HStack {
                Text(value)
                    .font(.title.bold())
                    .foregroundColor(.primary)

                Spacer()

                if progress > 0 {
                    ProgressView(value: progress, total: 1)
                        .progressViewStyle(CircularProgressViewStyle(tint: color))
                        .scaleEffect(0.8)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
        )
    }
}

#Preview {
    StatisticsView()
        .environmentObject(DataManager())
}