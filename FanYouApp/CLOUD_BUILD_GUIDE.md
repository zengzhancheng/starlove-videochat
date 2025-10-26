# ☁️ 饭友APP云端构建APK指南

## 🎯 方法一：EAS Build（推荐）

### 优势
- ✅ Expo官方服务，稳定可靠
- ✅ 无需本地Android环境
- ✅ 支持多种构建配置
- ✅ 自动处理签名和优化
- ✅ 支持持续集成

### 步骤1：安装EAS CLI
```bash
npm install -g @expo/eas-cli
```

### 步骤2：登录Expo账号
```bash
eas login
```
*如果没有账号，访问 https://expo.dev 注册*

### 步骤3：配置构建
```bash
eas build:configure
```
*这会创建 `eas.json` 配置文件*

### 步骤4：构建APK
```bash
# 构建预览版APK
eas build --platform android --profile preview

# 构建生产版APK
eas build --platform android --profile production
```

### 步骤5：下载APK
- 构建完成后会提供下载链接
- 直接下载APK文件到本地
- 可以分享给其他人安装

---

## 🚀 方法二：Expo Build Service

### 优势
- ✅ 简单易用
- ✅ 无需复杂配置
- ✅ 支持多种平台

### 步骤1：安装Expo CLI
```bash
npm install -g @expo/cli
```

### 步骤2：登录Expo账号
```bash
expo login
```

### 步骤3：构建APK
```bash
expo build:android
```

### 步骤4：下载APK
- 构建完成后提供下载链接
- 下载APK文件

---

## 🔧 方法三：GitHub Actions（自动化）

### 优势
- ✅ 完全自动化
- ✅ 支持版本管理
- ✅ 集成CI/CD

### 配置文件 `.github/workflows/build.yml`
```yaml
name: Build APK

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        
    - name: Install dependencies
      run: npm install
      
    - name: Setup Expo
      uses: expo/expo-github-action@v8
      with:
        expo-version: latest
        token: ${{ secrets.EXPO_TOKEN }}
        
    - name: Build APK
      run: eas build --platform android --non-interactive
      
    - name: Upload APK
      uses: actions/upload-artifact@v3
      with:
        name: FanYouApp.apk
        path: build-output/
```

---

## 📋 构建配置

### EAS配置文件 `eas.json`
```json
{
  "cli": {
    "version": ">= 5.4.0"
  },
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal"
    },
    "preview": {
      "distribution": "internal",
      "android": {
        "buildType": "apk"
      }
    },
    "production": {
      "android": {
        "buildType": "aab"
      }
    }
  },
  "submit": {
    "production": {}
  }
}
```

### 应用配置 `app.json`
```json
{
  "expo": {
    "name": "饭友",
    "slug": "fanyou-app",
    "version": "1.0.0",
    "orientation": "portrait",
    "icon": "./assets/icon.png",
    "userInterfaceStyle": "light",
    "splash": {
      "image": "./assets/splash.png",
      "resizeMode": "contain",
      "backgroundColor": "#ffffff"
    },
    "assetBundlePatterns": [
      "**/*"
    ],
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.fanyou.app"
    },
    "android": {
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#FFFFFF"
      },
      "package": "com.fanyou.app",
      "permissions": [
        "android.permission.CAMERA",
        "android.permission.RECORD_AUDIO",
        "android.permission.ACCESS_FINE_LOCATION",
        "android.permission.ACCESS_COARSE_LOCATION",
        "android.permission.INTERNET",
        "android.permission.WRITE_EXTERNAL_STORAGE"
      ]
    },
    "web": {
      "favicon": "./assets/favicon.png"
    },
    "plugins": [
      "expo-camera",
      "expo-location",
      "expo-notifications"
    ]
  }
}
```

---

## 🎯 推荐流程

### 快速开始（5分钟）
1. **安装EAS CLI**
   ```bash
   npm install -g @expo/eas-cli
   ```

2. **登录Expo**
   ```bash
   eas login
   ```

3. **配置构建**
   ```bash
   eas build:configure
   ```

4. **构建APK**
   ```bash
   eas build --platform android --profile preview
   ```

5. **下载APK**
   - 等待构建完成
   - 点击下载链接
   - 获得FanYouApp.apk

### 高级配置
- 自定义构建环境
- 配置代码签名
- 设置构建缓存
- 集成CI/CD

---

## 📱 APK安装

### Android设备安装
1. **启用未知来源**
   - 设置 → 安全 → 未知来源
   - 或设置 → 应用 → 特殊访问权限

2. **安装APK**
   - 将APK复制到手机
   - 点击APK文件
   - 点击"安装"

3. **授予权限**
   - 相机权限
   - 麦克风权限
   - 位置权限
   - 存储权限

---

## 🔍 构建状态检查

### 查看构建进度
```bash
# 查看所有构建
eas build:list

# 查看特定构建
eas build:view [BUILD_ID]
```

### 构建日志
- 在Expo Dashboard查看详细日志
- 实时监控构建进度
- 错误诊断和修复

---

## 💡 优化建议

### 构建优化
- 使用构建缓存
- 优化依赖大小
- 配置构建环境

### APK优化
- 启用代码混淆
- 压缩资源文件
- 优化启动时间

### 分发优化
- 使用AAB格式（Google Play）
- 配置应用签名
- 设置版本管理

---

## 🎉 总结

云端构建APK的优势：
- ✅ 无需本地Android环境
- ✅ 自动处理复杂配置
- ✅ 支持多种构建选项
- ✅ 提供详细构建日志
- ✅ 支持持续集成

**推荐使用EAS Build，最简单可靠！** 🚀
