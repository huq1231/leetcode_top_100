//
//  Problem.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import Foundation

struct Problem: Identifiable, Codable {
    let id: Int
    let title: String
    let difficulty: Difficulty
    let category: String
    let description: String
    let examples: [String]
    let solution: String
    var isCompleted: Bool = false
    var completedDate: Date?
    var timeSpent: TimeInterval = 0

    enum Difficulty: String, Codable {
        case easy = "简单"
        case medium = "中等"
        case hard = "困难"
    }
}

extension Problem {
    static let sampleProblems: [Problem] = [
        Problem(
            id: 1,
            title: "Two Sum",
            difficulty: .easy,
            category: "数组",
            description: "给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。",
            examples: ["输入: nums = [2,7,11,15], target = 9\n输出: [0,1]"],
            solution: "使用哈希表存储每个数字的补数。"
        ),
        Problem(
            id: 2,
            title: "Add Two Numbers",
            difficulty: .medium,
            category: "链表",
            description: "给你两个非空链表代表两个非负整数。",
            examples: ["输入: l1 = [2,4,3], l2 = [5,6,7]\n输出: [7,0,8]"],
            solution: "同时遍历两个链表并相加，处理进位。"
        ),
        Problem(
            id: 3,
            title: "Longest Substring Without Repeating Characters",
            difficulty: .medium,
            category: "字符串",
            description: "给定一个字符串 s ，请你找出其中不含有重复字符的最长子串的长度。",
            examples: ["输入: s = \"abcabcbb\"\n输出: 3"],
            solution: "使用双指针滑动窗口技术。"
        )
    ]
}