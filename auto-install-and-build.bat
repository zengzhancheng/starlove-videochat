@echo off
echo 💫 星恋 - 完全自动化Git安装和构建流程
echo.

REM 设置错误处理
setlocal enabledelayedexpansion

REM 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  需要管理员权限来安装Git
    echo 🔄 正在请求管理员权限...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)

echo ✅ 管理员权限已获取
echo.

REM 检查是否已安装Git
echo 🔍 检查Git安装状态...
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git已经安装
    git --version
    goto :setup_github
)

echo 📥 Git未安装，开始自动安装...
echo.

REM 下载Git安装程序
echo 📥 正在下载Git安装程序...
set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe"
set "GIT_INSTALLER=GitInstaller.exe"

powershell -Command "& {try {Invoke-WebRequest -Uri '%GIT_URL%' -OutFile '%GIT_INSTALLER%' -UseBasicParsing; Write-Host '✅ Git安装程序下载完成'} catch {Write-Host '❌ Git下载失败: ' $_.Exception.Message; exit 1}}"

if not exist "%GIT_INSTALLER%" (
    echo ❌ Git安装程序下载失败
    echo 📋 请手动安装Git: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo ✅ Git安装程序下载完成
echo.

REM 静默安装Git
echo 🚀 正在安装Git...
"%GIT_INSTALLER%" /VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"

echo ⏳ 等待Git安装完成...
timeout /t 60 /nobreak >nul

REM 添加到PATH
echo 🔧 配置Git环境变量...
setx PATH "%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd" /M >nul 2>&1

REM 刷新环境变量
call refreshenv >nul 2>&1

REM 验证Git安装
echo 🔍 验证Git安装...
"C:\Program Files\Git\bin\git.exe" --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git安装成功！
    "C:\Program Files\Git\bin\git.exe" --version
) else (
    echo ❌ Git安装验证失败
    echo 🔄 请重新打开命令行窗口
    pause
    exit /b 1
)

REM 清理安装文件
del "%GIT_INSTALLER%" >nul 2>&1

echo.
echo 🎉 Git安装完成！继续设置GitHub Actions...
echo.

:setup_github
echo 📋 开始设置GitHub Actions...

REM 检查Git配置
echo 🔍 检查Git用户配置...
git config --global user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  Git用户信息未配置
    set /p username="请输入GitHub用户名: "
    set /p email="请输入GitHub邮箱: "
    git config --global user.name "!username!"
    git config --global user.email "!email!"
    echo ✅ Git用户信息已配置
)

echo.
echo 📝 创建GitHub仓库...
echo.
echo 🌐 请按照以下步骤创建GitHub仓库:
echo 1. 访问: https://github.com/new
echo 2. 仓库名称: starlove-videochat
echo 3. 设置为公开仓库
echo 4. 不要初始化README、.gitignore或license
echo 5. 点击"Create repository"
echo.

set /p github_url="请输入GitHub仓库URL (例如: https://github.com/username/starlove-videochat.git): "

if "%github_url%"=="" (
    echo ❌ 未提供GitHub仓库URL
    pause
    exit /b 1
)

echo.
echo 🚀 开始推送代码到GitHub...

REM 初始化Git仓库
echo 📝 初始化Git仓库...
git init

REM 添加所有文件
echo 📁 添加项目文件...
git add .

REM 提交代码
echo 💾 提交代码...
git commit -m "Initial commit: 星恋应用 - 视频聊天社交"

REM 设置主分支
echo 🌿 设置主分支...
git branch -M main

REM 添加远程仓库
echo 🔗 添加远程仓库...
git remote add origin "%github_url%"

REM 推送代码
echo 📤 推送代码到GitHub...
git push -u origin main

if %errorlevel% equ 0 (
    echo ✅ 代码推送成功！
) else (
    echo ❌ 代码推送失败
    echo 💡 请检查GitHub仓库URL和网络连接
    pause
    exit /b 1
)

echo.
echo 🎯 设置Expo Token...
echo.
echo 🌐 请按照以下步骤设置Expo Token:
echo 1. 访问: https://expo.dev/settings/access-tokens
echo 2. 创建新的Access Token
echo 3. 复制Token
echo 4. 在GitHub仓库的Settings → Secrets → Actions中添加EXPO_TOKEN
echo.

set /p expo_token="请输入Expo Token (可选，稍后可在GitHub中设置): "

if not "%expo_token%"=="" (
    echo 🔧 配置Expo Token...
    echo EXPO_TOKEN=%expo_token% > .env.local
    echo ✅ Expo Token已配置
)

echo.
echo 🎉 GitHub Actions设置完成！
echo.
echo 📋 接下来GitHub Actions将自动:
echo 1. 检测到代码推送
echo 2. 开始云端构建APK
echo 3. 构建完成后在Actions页面提供下载
echo.
echo 🌐 查看构建状态: %github_url%/actions
echo.
echo ⏳ 首次构建通常需要5-10分钟
echo 💡 构建完成后，在Actions页面的Artifacts部分下载APK
echo.
pause
