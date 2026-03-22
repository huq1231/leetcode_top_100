//
//  UserAvatarView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI

struct UserAvatarView: View {
    var avatarImage: Image? = nil
    var size: CGFloat = 60

    var body: some View {
        ZStack {
            if let avatarImage = avatarImage {
                avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: size, height: size)
                    .overlay {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: size * 0.5))
                            .foregroundColor(.blue)
                    }
            }
        }
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 2)
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    VStack(spacing: 20) {
        UserAvatarView()
        UserAvatarView(size: 80)
        UserAvatarView(
            avatarImage: Image(systemName: "star.fill"),
            size: 100
        )
    }
    .padding()
}