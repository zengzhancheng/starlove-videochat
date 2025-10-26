@echo off
chcp 65001 >nul
echo 🚀 GitHub Actions 云端构建设置脚本
echo ================================
echo.

echo 📋 此脚本将帮助您设置GitHub Actions云端构建
echo.

echo 📝 设置步骤:
echo 1. 创建GitHub仓库
echo 2. 上传代码到GitHub
echo 3. 配置Expo Token
echo 4. 设置GitHub Secrets
echo 5. 触发自动构建
echo.

echo 🔧 已创建的文件:
echo ✅ .github/workflows/build-apk.yml - GitHub Actions工作流
echo ✅ eas.json - EAS构建配置
echo ✅ GITHUB_ACTIONS_GUIDE.md - 详细设置指南
echo.

echo 📚 详细说明请查看: GITHUB_ACTIONS_GUIDE.md
echo.

echo 🎯 快速开始:
echo 1. 访问 https://github.com 创建新仓库
echo 2. 将代码推送到GitHub
echo 3. 在仓库设置中添加EXPO_TOKEN
echo 4. 推送代码触发自动构建
echo.

echo 📱 构建完成后:
echo - 在Releases页面下载APK
echo - 在Actions页面查看构建日志
echo - APK会自动优化和签名
echo.

echo 🎉 GitHub Actions优势:
echo ✅ 完全自动化构建
echo ✅ 每次推送自动构建
echo ✅ 自动创建Release
echo ✅ 支持多平台构建
echo ✅ 云端构建无需本地环境
echo.

echo 按任意键查看详细指南...
pause >nul

echo.
echo 📖 正在打开详细指南...
start GITHUB_ACTIONS_GUIDE.md

echo.
echo 🚀 设置完成后，您的饭友APP将实现完全自动化构建！
echo.
pause

