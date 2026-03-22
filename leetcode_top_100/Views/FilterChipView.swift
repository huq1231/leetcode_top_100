//
//  FilterChipView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI

struct FilterChipView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.clear)
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.blue, lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        FilterChipView(
            title: "All",
            isSelected: true,
            action: {}
        )

        FilterChipView(
            title: "Easy",
            isSelected: false,
            action: {}
        )

        FilterChipView(
            title: "Medium",
            isSelected: false,
            action: {}
        )

        FilterChipView(
            title: "Hard",
            isSelected: false,
            action: {}
        )
    }
    .padding()
}