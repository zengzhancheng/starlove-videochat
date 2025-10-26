@echo off
echo 💫 星恋 GitHub Actions 云端构建设置
echo.

REM 检查是否已安装Git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未检测到Git，请先安装Git
    echo 📥 下载地址: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo ✅ Git已安装
echo.

REM 检查是否已登录GitHub
echo 🔍 检查GitHub登录状态...
git config --global user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 请先配置Git用户信息
    echo.
    set /p username="请输入GitHub用户名: "
    set /p email="请输入GitHub邮箱: "
    git config --global user.name "%username%"
    git config --global user.email "%email%"
    echo ✅ Git用户信息已配置
)

echo.
echo 📋 开始设置GitHub Actions...

REM 创建GitHub Actions工作流文件
echo 📝 创建GitHub Actions工作流文件...
if not exist ".github\workflows" mkdir .github\workflows

echo name: Build APK for 星恋 > .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo on: >> .github\workflows\build-apk.yml
echo   push: >> .github\workflows\build-apk.yml
echo     branches: [ main, master ] >> .github\workflows\build-apk.yml
echo   pull_request: >> .github\workflows\build-apk.yml
echo     branches: [ main, master ] >> .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo jobs: >> .github\workflows\build-apk.yml
echo   build: >> .github\workflows\build-apk.yml
echo     runs-on: ubuntu-latest >> .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo     steps: >> .github\workflows\build-apk.yml
echo     - uses: actions/checkout@v3 >> .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo     - name: Setup Node.js >> .github\workflows\build-apk.yml
echo       uses: actions/setup-node@v3 >> .github\workflows\build-apk.yml
echo       with: >> .github\workflows\build-apk.yml
echo         node-version: '18' >> .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo     - name: Install dependencies >> .github\workflows\build-apk.yml
echo       run: npm install >> .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo     - name: Setup Expo CLI >> .github\workflows\build-apk.yml
echo       run: npm install -g @expo/cli >> .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo     - name: Build APK >> .github\workflows\build-apk.yml
echo       run: npx expo build:android --type apk >> .github\workflows\build-apk.yml
echo       env: >> .github\workflows\build-apk.yml
echo         EXPO_TOKEN: ${{ secrets.EXPO_TOKEN }} >> .github\workflows\build-apk.yml
echo. >> .github\workflows\build-apk.yml
echo     - name: Upload APK >> .github\workflows\build-apk.yml
echo       uses: actions/upload-artifact@v3 >> .github\workflows\build-apk.yml
echo       with: >> .github\workflows\build-apk.yml
echo         name: starlove-apk >> .github\workflows\build-apk.yml
echo         path: *.apk >> .github\workflows\build-apk.yml

echo ✅ GitHub Actions工作流文件已创建
echo.

REM 创建EAS配置文件
echo 📝 创建EAS配置文件...
echo { > eas.json
echo   "cli": { >> eas.json
echo     "version": ">= 3.0.0" >> eas.json
echo   }, >> eas.json
echo   "build": { >> eas.json
echo     "development": { >> eas.json
echo       "developmentClient": true, >> eas.json
echo       "distribution": "internal" >> eas.json
echo     }, >> eas.json
echo     "preview": { >> eas.json
echo       "distribution": "internal" >> eas.json
echo     }, >> eas.json
echo     "production": { >> eas.json
echo       "android": { >> eas.json
echo         "buildType": "apk" >> eas.json
echo       } >> eas.json
echo     } >> eas.json
echo   }, >> eas.json
echo   "submit": { >> eas.json
echo     "production": {} >> eas.json
echo   } >> eas.json
echo } >> eas.json

echo ✅ EAS配置文件已创建
echo.

REM 创建GitHub Actions设置指南
echo 📝 创建GitHub Actions设置指南...
echo # 💫 星恋 GitHub Actions 云端构建指南 > GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ## 🎯 概述 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo GitHub Actions 是 GitHub 提供的免费 CI/CD 服务，可以自动构建、测试和部署您的应用。 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ## 🚀 快速开始 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ### 1. 创建GitHub仓库 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo 1. 访问 [GitHub](https://github.com) 并登录 >> GITHUB_ACTIONS_GUIDE.md
echo 2. 点击 "New repository" 创建新仓库 >> GITHUB_ACTIONS_GUIDE.md
echo 3. 仓库名称建议: `starlove-videochat` >> GITHUB_ACTIONS_GUIDE.md
echo 4. 设置为公开仓库（免费使用GitHub Actions） >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ### 2. 推送代码到GitHub >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ```bash >> GITHUB_ACTIONS_GUIDE.md
echo git init >> GITHUB_ACTIONS_GUIDE.md
echo git add . >> GITHUB_ACTIONS_GUIDE.md
echo git commit -m "Initial commit: 星恋应用" >> GITHUB_ACTIONS_GUIDE.md
echo git branch -M main >> GITHUB_ACTIONS_GUIDE.md
echo git remote add origin https://github.com/YOUR_USERNAME/starlove-videochat.git >> GITHUB_ACTIONS_GUIDE.md
echo git push -u origin main >> GITHUB_ACTIONS_GUIDE.md
echo ``` >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ### 3. 设置Expo Token >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo 1. 访问 [Expo Dashboard](https://expo.dev) 并登录 >> GITHUB_ACTIONS_GUIDE.md
echo 2. 在 Settings 中找到 Access Tokens >> GITHUB_ACTIONS_GUIDE.md
echo 3. 创建新的 Access Token >> GITHUB_ACTIONS_GUIDE.md
echo 4. 在GitHub仓库的 Settings → Secrets 中添加 `EXPO_TOKEN` >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ### 4. 触发构建 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo 推送代码后，GitHub Actions 会自动开始构建APK >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ## 📱 下载APK >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo 1. 访问GitHub仓库的 Actions 页面 >> GITHUB_ACTIONS_GUIDE.md
echo 2. 点击最新的构建任务 >> GITHUB_ACTIONS_GUIDE.md
echo 3. 在 Artifacts 部分下载 `starlove-apk` >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ## 🔧 自定义配置 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo 可以修改 `.github/workflows/build-apk.yml` 文件来自定义构建流程 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ## ❓ 常见问题 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ### Q: 构建失败怎么办？ >> GITHUB_ACTIONS_GUIDE.md
echo A: 检查GitHub Actions日志，通常是因为缺少依赖或配置错误 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ### Q: 如何修改构建配置？ >> GITHUB_ACTIONS_GUIDE.md
echo A: 编辑 `.github/workflows/build-apk.yml` 文件 >> GITHUB_ACTIONS_GUIDE.md
echo. >> GITHUB_ACTIONS_GUIDE.md
echo ### Q: 构建时间太长怎么办？ >> GITHUB_ACTIONS_GUIDE.md
echo A: 这是正常现象，首次构建通常需要5-10分钟 >> GITHUB_ACTIONS_GUIDE.md

echo ✅ GitHub Actions设置指南已创建
echo.

echo 🎉 GitHub Actions 设置完成！
echo.
echo 📋 接下来需要:
echo 1. 创建GitHub仓库
echo 2. 推送代码到GitHub
echo 3. 设置Expo Token
echo 4. 触发自动构建
echo.
echo 📖 详细步骤请查看: GITHUB_ACTIONS_GUIDE.md
echo.
pause
