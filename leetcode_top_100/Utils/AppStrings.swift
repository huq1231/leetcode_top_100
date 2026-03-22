//
//  AppStrings.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import Foundation

// 应用常量
struct AppStrings {

    // 应用名称
    static let appName = "LeetCode Top 100"

    // 主界面
    static let problemsTitle = "LeetCode Top 100"
    static let problemsSolved = "已完成题目"
    static let completionRate = "完成率"
    static let allProblems = "全部"
    static let completedProblems = "已完成"
    static let todoProblems = "待完成"
    static let easy = "简单"
    static let medium = "中等"
    static let hard = "困难"

    // 问题详情
    static let problemDescription = "题目描述"
    static let examples = "示例"
    static let examplePrefix = "示例"
    static let solution = "解题思路"
    static let timeSpent = "用时"
    static let markAsCompleted = "标记为已完成"
    static let resetProgress = "重置进度"
    static let resetTimer = "重置计时器"

    // 统计页面
    static let statisticsTitle = "学习统计"
    static let overviewProgress = "总体进度"
    static let solvedCount = "已解决"
    static let totalCount = "总计"
    static let progressByDifficulty = "难度分布"
    static let timeTracking = "时间统计"
    static let totalTime = "总用时"
    static let averageTime = "平均用时"
    static let categories = "分类统计"
    static let currentStreak = "当前连续"
    static let longestStreak = "最长连续"
    static let keepItUp = "太棒了！继续加油！"

    // 提示信息
    static let problemCompleted = "题目完成！"
    static let continueLearning = "继续学习"
    static let resetConfirmation = "确定要重置进度吗？"

    // 示例格式转换
    static func formatExample(_ example: String) -> String {
        return example
            .replacingOccurrences(of: "Input:", with: "输入:")
            .replacingOccurrences(of: "Output:", with: "输出:")
            .replacingOccurrences(of: "input:", with: "输入:")
            .replacingOccurrences(of: "output:", with: "输出:")
    }
}