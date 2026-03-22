//
//  ProblemCellView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI

struct ProblemCellView: View {
    let problem: Problem
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        HStack(spacing: 16) {
            // Status icon
            statusIcon

            // Problem content
            VStack(alignment: .leading, spacing: 4) {
                Text("#\(problem.id): \(problem.title)")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(problem.category)
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack {
                    difficultyBadge
                    if problem.isCompleted {
                        Spacer()
                        Text("已完成")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Time spent
            if problem.timeSpent > 0 && problem.isCompleted {
                Text(timeString)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(problem.isCompleted ? Color.green.opacity(0.1) : Color.gray.opacity(0.05))
                .stroke(problem.isCompleted ? Color.green.opacity(0.3) : Color.gray.opacity(0.2), lineWidth: 1)
        )
    }

    private var statusIcon: some View {
        ZStack {
            Circle()
                .fill(difficultyColor)
                .frame(width: 40, height: 40)

            if problem.isCompleted {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            } else {
                Text("#\(problem.id)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }

    private var difficultyBadge: some View {
        HStack(spacing: 4) {
            Text(difficulty.rawValue)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(difficultyColor.opacity(0.2))
                .foregroundColor(difficultyColor)
                .clipShape(Capsule())
        }
    }

    private var difficulty: Problem.Difficulty {
        problem.difficulty
    }

    private var difficultyColor: Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }

    private var timeString: String {
        let minutes = Int(problem.timeSpent / 60)
        let seconds = Int(problem.timeSpent) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    ProblemCellView(problem: Problem.sampleProblems[0])
        .environmentObject(DataManager())
        .padding()
}