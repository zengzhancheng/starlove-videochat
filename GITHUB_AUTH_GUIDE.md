# GitHub身份验证和代码推送指南

## 🔐 GitHub身份验证解决方案

### 方案1: 使用Personal Access Token（推荐）

1. **创建Personal Access Token**:
   - 访问: https://github.com/settings/tokens
   - 点击 "Generate new token" → "Generate new token (classic)"
   - 设置权限: 选择 "repo" (完整仓库访问权限)
   - 复制生成的Token

2. **使用Token推送代码**:
   ```bash
   git push -u origin main
   # 用户名: 输入您的GitHub用户名
   # 密码: 输入Personal Access Token（不是GitHub密码）
   ```

### 方案2: 在浏览器中完成身份验证

1. **重新运行推送命令**:
   ```bash
   git push -u origin main
   ```

2. **在浏览器中完成身份验证**:
   - 会自动打开浏览器
   - 登录GitHub账户
   - 授权Git访问

### 方案3: 使用GitHub CLI

1. **安装GitHub CLI**:
   - 访问: https://cli.github.com/
   - 下载并安装

2. **登录GitHub**:
   ```bash
   gh auth login
   ```

3. **推送代码**:
   ```bash
   git push -u origin main
   ```

## 🚀 推送成功后

一旦代码推送成功，GitHub Actions将自动开始构建APK：

1. **查看构建状态**: https://github.com/zengzhancheng/starlove-videochat/actions
2. **等待构建完成**: 通常需要5-10分钟
3. **下载APK**: 在Actions页面的Artifacts部分下载

## 🎯 设置Expo Token

为了确保构建成功，还需要设置Expo Token：

1. **访问**: https://expo.dev/settings/access-tokens
2. **创建新的Access Token**
3. **在GitHub仓库设置中添加**:
   - 访问: https://github.com/zengzhancheng/starlove-videochat/settings/secrets/actions
   - 点击 "New repository secret"
   - Name: `EXPO_TOKEN`
   - Value: 粘贴Expo Token
   - 点击 "Add secret"

## 💡 推荐步骤

1. 使用Personal Access Token推送代码
2. 设置Expo Token
3. 等待GitHub Actions自动构建
4. 下载生成的APK文件
