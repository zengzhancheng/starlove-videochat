@echo off
chcp 65001 >nul
echo ☁️ 饭友APP云端构建APK脚本
echo ================================
echo.

REM 检查Node.js是否安装
node --version >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Node.js已安装
    node --version
) else (
    echo ❌ Node.js未安装
    echo 请先运行 install-nodejs.bat 安装Node.js
    echo.
    pause
    exit /b 1
)

echo.
echo 📦 安装EAS CLI...
call npm install -g @expo/eas-cli
if %errorLevel% == 0 (
    echo ✅ EAS CLI安装成功
) else (
    echo ❌ EAS CLI安装失败
    pause
    exit /b 1
)

echo.
echo 🔐 登录Expo账号...
echo 如果没有账号，请访问 https://expo.dev 注册
echo.
call eas login
if %errorLevel% == 0 (
    echo ✅ 登录成功
) else (
    echo ❌ 登录失败
    pause
    exit /b 1
)

echo.
echo ⚙️ 配置构建...
call eas build:configure
if %errorLevel% == 0 (
    echo ✅ 构建配置完成
) else (
    echo ❌ 构建配置失败
    pause
    exit /b 1
)

echo.
echo 🚀 开始构建APK...
echo 这将在云端构建，请耐心等待...
echo.
call eas build --platform android --profile preview
if %errorLevel% == 0 (
    echo ✅ APK构建成功！
    echo.
    echo 📱 构建完成后会提供下载链接
    echo 您可以直接下载APK文件到手机安装
) else (
    echo ❌ APK构建失败
    echo 请检查构建日志
)

echo.
echo 📋 构建完成后您可以:
echo 1. 下载APK文件
echo 2. 复制到手机安装
echo 3. 分享给其他人使用
echo.
pause

