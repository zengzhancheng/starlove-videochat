# 💫 星恋 GitHub Actions 云端构建指南

## 🎯 概述

GitHub Actions 是 GitHub 提供的免费 CI/CD 服务，可以自动构建、测试和部署您的应用。

## 🚀 快速开始

### 1. 安装Git（如果还没有安装）

1. 访问 [Git官网](https://git-scm.com/download/win)
2. 下载Git for Windows
3. 运行安装程序，使用默认设置
4. 重新打开命令行窗口

### 2. 创建GitHub仓库

1. 访问 [GitHub](https://github.com) 并登录
2. 点击 "New repository" 创建新仓库
3. 仓库名称建议: `starlove-videochat`
4. 设置为公开仓库（免费使用GitHub Actions）
5. 不要初始化README、.gitignore或license（因为我们已经有了代码）

### 3. 推送代码到GitHub

在项目目录中运行以下命令：

```bash
# 初始化Git仓库
git init

# 添加所有文件
git add .

# 提交代码
git commit -m "Initial commit: 星恋应用"

# 设置主分支
git branch -M main

# 添加远程仓库（替换YOUR_USERNAME为您的GitHub用户名）
git remote add origin https://github.com/YOUR_USERNAME/starlove-videochat.git

# 推送代码到GitHub
git push -u origin main
```

### 4. 设置Expo Token

1. 访问 [Expo Dashboard](https://expo.dev) 并登录
2. 在 Settings 中找到 Access Tokens
3. 创建新的 Access Token
4. 在GitHub仓库的 Settings → Secrets and variables → Actions 中添加 `EXPO_TOKEN`
5. 将Expo Token粘贴到Value字段中

### 5. 触发构建

推送代码后，GitHub Actions 会自动开始构建APK。您可以在GitHub仓库的 Actions 页面查看构建进度。

## 📱 下载APK

1. 访问GitHub仓库的 Actions 页面
2. 点击最新的构建任务
3. 等待构建完成（通常需要5-10分钟）
4. 在 Artifacts 部分下载 `starlove-apk`

## 🔧 自定义配置

可以修改 `.github/workflows/build-apk.yml` 文件来自定义构建流程：

- 修改Node.js版本
- 添加测试步骤
- 修改构建参数
- 添加部署步骤

## ❓ 常见问题

### Q: 构建失败怎么办？
A: 检查GitHub Actions日志，通常是因为：
- 缺少EXPO_TOKEN
- 依赖安装失败
- 配置文件错误

### Q: 如何修改构建配置？
A: 编辑 `.github/workflows/build-apk.yml` 文件

### Q: 构建时间太长怎么办？
A: 这是正常现象，首次构建通常需要5-10分钟

### Q: 如何查看构建日志？
A: 在GitHub仓库的Actions页面点击具体的构建任务

## 🎉 完成！

现在您可以通过GitHub Actions在云端自动构建星恋APK了！

每次推送代码到main分支时，都会自动触发构建，生成最新的APK文件。
