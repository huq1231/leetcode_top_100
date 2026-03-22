# LeetCode Top 100 - iOS 应用

iOS app for tracking LeetCode Top 100 problems - 一个基于 SwiftUI 开发的 iOS 应用，帮助用户追踪和管理 LeetCode Top 100 算法题目的学习进度。

## 技术栈

- **语言**: Swift 5.0
- **UI 框架**: SwiftUI
- **数据持久化**: UserDefaults
- **状态管理**: @ObservableObject
- **iOS 版本**: 15.0+

## 应用架构

```
leetcode_top_100/
├── Models/
│   ├── Problem.swift        # 问题数据模型
│   └── Statistics.swift     # 统计数据模型
├── Managers/
│   └── DataManager.swift    # 数据管理器
├── Views/
│   ├── ProblemListView.swift    # 问题列表视图
│   ├── ProblemCellView.swift    # 问题列表项
│   ├── ProblemDetailView.swift  # 问题详情视图
│   ├── StatisticsView.swift     # 统计页面
│   ├── SettingsView.swift       # 设置页面
│   └── FilterChipView.swift     # 筛选组件
└── Utils/
    └── AppStrings.swift     # 中文文本常量
```

## 核心功能

- **问题管理**: 分类筛选、进度追踪、题目详情
- **学习统计**: 完成率、时间统计、连续学习天数
- **头像系统**: 用户头像显示和管理
- **中文化界面**: 完整的中文 UI

## 使用方法

1. 打开 `leetcode_top_100.xcodeproj`
2. 选择 iOS Simulator 目标
3. 点击运行 (⌘R)

## 许可证

MIT License
