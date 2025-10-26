@echo off
echo 🔧 自动安装Git...
echo.

REM 检查是否已安装Git
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git已经安装
    git --version
    goto :continue
)

echo 📥 正在下载Git安装程序...
echo.

REM 使用PowerShell下载Git安装程序
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe' -OutFile 'GitInstaller.exe'}"

if exist "GitInstaller.exe" (
    echo ✅ Git安装程序下载完成
    echo.
    echo 🚀 正在安装Git...
    echo ⚠️  请在弹出的安装窗口中点击"Next"使用默认设置
    echo.
    
    REM 静默安装Git
    GitInstaller.exe /VERYSILENT /NORESTART
    
    echo ⏳ 等待安装完成...
    timeout /t 30 /nobreak >nul
    
    REM 添加到PATH
    setx PATH "%PATH%;C:\Program Files\Git\bin" /M >nul 2>&1
    
    echo ✅ Git安装完成！
    echo.
    
    REM 清理安装文件
    del GitInstaller.exe >nul 2>&1
    
    echo 🔄 请重新打开命令行窗口以使用Git
    echo.
    pause
    exit /b 0
) else (
    echo ❌ Git安装程序下载失败
    echo.
    echo 📋 请手动安装Git:
    echo 1. 访问: https://git-scm.com/download/win
    echo 2. 下载Git for Windows
    echo 3. 运行安装程序
    echo 4. 使用默认设置安装
    echo.
    pause
    exit /b 1
)

:continue
echo.
echo 🎉 Git安装完成，继续设置GitHub Actions...
echo.
pause
