//
//  ProblemDetailView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI
import Combine

struct ProblemDetailView: View {
    let problem: Problem
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) private var dismiss
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeSpent: TimeInterval = 0
    @State private var showSuccess = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Problem header
                problemHeaderView

                // Problem description
                descriptionSection

                // 示例
                examplesSection

                // Solution
                solutionSection

                // Timer
                timerSection

                // Action buttons
                actionButtons
            }
            .padding()
        }
        .navigationTitle("题目 #\(problem.id)")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(timer) { _ in
            if !problem.isCompleted {
                timeSpent += 1
            }
        }
        .alert(AppStrings.problemCompleted, isPresented: $showSuccess) {
            Button("OK") {
                dataManager.toggleProblemCompletion(problem.id, timeSpent: timeSpent)
                dismiss()
            }
        }
    }

    private var problemHeaderView: some View {
        VStack(spacing: 12) {
            Text("#\(problem.id): \(problem.title)")
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Text(problem.category)
                .font(.body)
                .foregroundColor(.secondary)

            HStack {
                difficultyBadge
                Spacer()
                Text("题目ID: \(problem.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.05))
        )
    }

    private var difficultyBadge: some View {
        HStack(spacing: 4) {
            Text(problem.difficulty.rawValue)
                .font(.body)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(difficultyColor.opacity(0.2))
                .foregroundColor(difficultyColor)
                .clipShape(Capsule())
        }
    }

    private var difficultyColor: Color {
        switch problem.difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }

    private var descriptionSection: some View {
        SectionView(title: AppStrings.problemDescription) {
            Text(problem.description)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(4)
        }
    }

    private var examplesSection: some View {
        SectionView(title: AppStrings.examples) {
            ForEach(Array(problem.examples.enumerated()), id: \.offset) { index, example in
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(AppStrings.examplePrefix) \(index + 1):")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    Text(AppStrings.formatExample(example))
                        .font(.body.monospaced())
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.05))
                        )
                        .foregroundColor(.primary)
                }
            }
        }
    }

    private var solutionSection: some View {
        SectionView(title: AppStrings.solution) {
            Text(problem.solution)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(4)
        }
    }

    private var timerSection: some View {
        VStack(spacing: 8) {
            Text(AppStrings.timeSpent)
                .font(.headline)

            HStack(spacing: 16) {
                VStack {
                    Text(formatTime(timeSpent))
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.primary)
                    Text("分钟")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                VStack {
                    Text("\(Int(timeSpent) % 60)")
                        .font(.title.bold())
                    Text("秒")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue.opacity(0.1))
        )
    }

    private var actionButtons: some View {
        VStack(spacing: 16) {
            Button(action: {
                dataManager.toggleProblemCompletion(problem.id, timeSpent: timeSpent)
                dismiss()
            }) {
                Text(problem.isCompleted ? AppStrings.resetProgress : AppStrings.markAsCompleted)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(problem.isCompleted ? Color.orange : Color.green)
                    .clipShape(Capsule())
            }

            if !problem.isCompleted {
                Button(action: {
                    timeSpent = 0
                }) {
                    Text(AppStrings.resetTimer)
                        .font(.body)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
            }
        }
        .padding(.top)
    }

    private func formatTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        return String(format: "%02d", minutes)
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            content
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
    }
}

#Preview {
    NavigationStack {
        ProblemDetailView(problem: Problem.sampleProblems[0])
            .environmentObject(DataManager())
    }
}