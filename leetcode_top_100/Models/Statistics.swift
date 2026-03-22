//
//  Statistics.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import Foundation

struct Statistics: Codable {
    let totalProblems: Int
    let completedProblems: Int
    let currentStreak: Int
    let longestStreak: Int
    let totalTimeSpent: TimeInterval
    let averageTimePerProblem: TimeInterval

    var completionRate: Double {
        Double(completedProblems) / Double(totalProblems) * 100
    }

    var todayProblems: Int {
        // Logic to count problems completed today
        return 0
    }
}