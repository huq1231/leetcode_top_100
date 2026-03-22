//
//  DataManager.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    @Published var problems: [Problem] = Problem.sampleProblems
    @Published var statistics = Statistics(
        totalProblems: 100,
        completedProblems: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalTimeSpent: 0,
        averageTimePerProblem: 0
    )

    private let userDefaults = UserDefaults.standard
    private let problemsKey = "leetcode_problems"
    private let statisticsKey = "leetcode_statistics"

    init() {
        loadProblems()
        loadStatistics()
    }

    // MARK: - Problem Management

    func toggleProblemCompletion(_ problemId: Int, timeSpent: TimeInterval) {
        if let index = problems.firstIndex(where: { $0.id == problemId }) {
            problems[index].isCompleted.toggle()
            problems[index].timeSpent = timeSpent

            if problems[index].isCompleted {
                problems[index].completedDate = Date()
            } else {
                problems[index].completedDate = nil
            }

            saveProblems()
            updateStatistics()
        }
    }

    func updateTimeSpent(for problemId: Int, additionalTime: TimeInterval) {
        if let index = problems.firstIndex(where: { $0.id == problemId }) {
            problems[index].timeSpent += additionalTime
            saveProblems()
            updateStatistics()
        }
    }

    // MARK: - Statistics Calculation

    private func updateStatistics() {
        let completed = problems.filter { $0.isCompleted }.count
        let totalTime = problems.reduce(0) { $0 + $1.timeSpent }
        let averageTime = completed > 0 ? totalTime / Double(completed) : 0

        // Calculate current streak (simplified logic)
        _ = Calendar.current.isDateInToday(Date())
        let completedToday = problems.filter {
            $0.isCompleted && Calendar.current.isDateInToday($0.completedDate ?? .distantPast)
        }.count

        let currentStreak = completedToday > 0 ? 1 : 0

        statistics = Statistics(
            totalProblems: problems.count,
            completedProblems: completed,
            currentStreak: currentStreak,
            longestStreak: max(statistics.longestStreak, currentStreak),
            totalTimeSpent: totalTime,
            averageTimePerProblem: averageTime
        )

        saveStatistics()
    }

    // MARK: - Persistence

    private func saveProblems() {
        if let encoded = try? JSONEncoder().encode(problems) {
            userDefaults.set(encoded, forKey: problemsKey)
        }
    }

    private func loadProblems() {
        if let data = userDefaults.data(forKey: problemsKey),
           let decoded = try? JSONDecoder().decode([Problem].self, from: data) {
            problems = decoded
        }
    }

    private func saveStatistics() {
        if let encoded = try? JSONEncoder().encode(statistics) {
            userDefaults.set(encoded, forKey: statisticsKey)
        }
    }

    private func loadStatistics() {
        if let data = userDefaults.data(forKey: statisticsKey),
           let decoded = try? JSONDecoder().decode(Statistics.self, from: data) {
            statistics = decoded
        }
    }
}