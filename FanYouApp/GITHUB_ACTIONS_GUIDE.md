# 🚀 GitHub Actions 云端构建指南

## 📋 概述

GitHub Actions可以自动构建饭友APP的APK文件，每次代码推送都会触发构建，并自动创建Release供下载。

## 🔧 配置步骤

### 1. 创建GitHub仓库

1. 访问 [GitHub](https://github.com)
2. 点击"New repository"
3. 仓库名：`FanYouApp`
4. 设置为公开仓库
5. 点击"Create repository"

### 2. 上传代码到GitHub

```bash
# 初始化Git仓库
git init

# 添加所有文件
git add .

# 提交代码
git commit -m "Initial commit: FanYouApp"

# 添加远程仓库
git remote add origin https://github.com/YOUR_USERNAME/FanYouApp.git

# 推送到GitHub
git push -u origin main
```

### 3. 配置Expo Token

1. 访问 [Expo Dashboard](https://expo.dev)
2. 登录您的Expo账号
3. 进入"Account Settings"
4. 找到"Access Tokens"
5. 创建新的Token
6. 复制Token值

### 4. 在GitHub中设置Secrets

1. 进入GitHub仓库页面
2. 点击"Settings"标签
3. 左侧菜单选择"Secrets and variables" → "Actions"
4. 点击"New repository secret"
5. 添加以下Secret：

```
Name: EXPO_TOKEN
Value: [您的Expo Token]
```

### 5. 触发构建

#### 自动触发
- 推送代码到main分支
- 创建Pull Request
- 手动触发（在Actions页面点击"Run workflow"）

#### 手动触发
1. 进入GitHub仓库
2. 点击"Actions"标签
3. 选择"Build FanYouApp APK"
4. 点击"Run workflow"
5. 选择分支并点击"Run workflow"

## 📱 构建流程

### 构建步骤
1. **Checkout代码** - 获取最新代码
2. **Setup Node.js** - 安装Node.js环境
3. **Install依赖** - 安装项目依赖
4. **Setup Expo** - 配置Expo环境
5. **Build APK** - 使用EAS构建APK
6. **Download APK** - 下载构建的APK
7. **Upload Artifact** - 上传APK到GitHub
8. **Create Release** - 自动创建Release

### 构建时间
- **Android APK**: 约5-10分钟
- **iOS IPA**: 约10-15分钟

## 📥 获取APK

### 方法1：从Release下载
1. 进入GitHub仓库
2. 点击"Releases"
3. 找到最新版本
4. 点击"FanYouApp.apk"下载

### 方法2：从Artifacts下载
1. 进入GitHub仓库
2. 点击"Actions"标签
3. 选择最新的构建
4. 在"Artifacts"部分下载APK

## 🔧 高级配置

### 自定义构建配置

#### 修改构建触发条件
```yaml
on:
  push:
    branches: [ main, develop ]
    tags: [ 'v*' ]
  schedule:
    - cron: '0 0 * * 1' # 每周一自动构建
```

#### 添加测试步骤
```yaml
- name: 🧪 Run tests
  run: npm test
  
- name: 🔍 Lint code
  run: npm run lint
```

#### 添加通知
```yaml
- name: 📢 Notify on success
  if: success()
  uses: 8398a7/action-slack@v3
  with:
    status: success
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

### 多环境构建

#### 开发版本
```yaml
- name: Build development APK
  run: eas build --platform android --profile development --non-interactive
```

#### 预览版本
```yaml
- name: Build preview APK
  run: eas build --platform android --profile preview --non-interactive
```

#### 生产版本
```yaml
- name: Build production AAB
  run: eas build --platform android --profile production --non-interactive
```

## 📊 监控和调试

### 查看构建日志
1. 进入GitHub仓库
2. 点击"Actions"标签
3. 选择构建任务
4. 查看详细日志

### 常见问题

#### 构建失败
- 检查Expo Token是否正确
- 确认app.json配置正确
- 查看构建日志中的错误信息

#### APK下载失败
- 检查网络连接
- 确认构建成功完成
- 尝试重新下载

#### 权限问题
- 确认GitHub仓库权限
- 检查Secrets配置
- 验证Expo账号权限

## 🎯 最佳实践

### 代码管理
- 使用语义化版本号
- 添加详细的提交信息
- 定期更新依赖

### 构建优化
- 使用构建缓存
- 并行构建多个平台
- 设置构建超时

### 发布管理
- 使用标签管理版本
- 添加发布说明
- 设置发布权限

## 📈 自动化流程

### 完整CI/CD流程
1. **开发** - 在feature分支开发
2. **测试** - 创建Pull Request触发测试
3. **合并** - 合并到main分支
4. **构建** - 自动构建APK
5. **发布** - 自动创建Release
6. **部署** - 自动部署到应用商店

### 版本管理
```bash
# 创建新版本
git tag v1.0.0
git push origin v1.0.0

# 触发构建
git push origin main
```

## 🎉 优势

### 自动化优势
- ✅ 无需手动构建
- ✅ 自动版本管理
- ✅ 持续集成
- ✅ 自动发布

### 协作优势
- ✅ 团队协作
- ✅ 代码审查
- ✅ 版本控制
- ✅ 问题跟踪

### 部署优势
- ✅ 云端构建
- ✅ 自动优化
- ✅ 多平台支持
- ✅ 快速分发

## 📞 技术支持

如果遇到问题：
1. 查看GitHub Actions日志
2. 检查Expo Dashboard
3. 参考官方文档
4. 提交Issue

**GitHub Actions让您的饭友APP构建完全自动化！** 🚀

