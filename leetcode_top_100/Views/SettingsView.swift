//
//  SettingsView.swift
//  leetcode_top_100
//
//  Created by adia on 2026/3/21.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedImage: PhotosPickerItem?
    @State private var showImagePicker = false

    // 默认头像
    private let defaultAvatarImage: Image? = {
        if let image = UIImage(named: "AppIcon") {
            return Image(uiImage: image)
        }
        return nil
    }()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // 头像部分
                avatarSection

                Spacer()

                // 设置选项
                settingsSection
            }
            .padding()
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("关闭") {
                        dismiss()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }

    private var avatarSection: some View {
        VStack(spacing: 20) {
            Text("个人头像")
                .font(.title2.bold())

            UserAvatarView(
                avatarImage: defaultAvatarImage,
                size: 100
            )
            .onTapGesture {
                // 可以添加选择头像的功能
            }

            Button(action: {
                // 选择头像照片
                showImagePicker = true
            }) {
                Text("选择头像")
                    .font(.body)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.05))
        )
        .sheet(isPresented: $showImagePicker) {
            Text("照片选择功能暂未启用")
                .padding()
        }
    }

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("应用设置")
                .font(.headline)

            SettingRow(icon: "bell", title: "学习提醒", subtitle: "开启学习进度提醒")
            SettingRow(icon: "chart.bar", title: "统计概览", subtitle: "查看学习统计数据")
            SettingRow(icon: "gear", title: "常规设置", subtitle: "应用配置选项")
            SettingRow(icon: "info.circle", title: "关于", subtitle: "应用版本信息")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.05))
        )
    }
}

struct SettingRow: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.5))
        )
    }
}

#Preview {
    SettingsView()
        .navigationViewStyle(.stack)
}