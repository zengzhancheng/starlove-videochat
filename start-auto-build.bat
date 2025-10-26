@echo off
echo 💫 星恋 - 自动安装Git并完成构建流程
echo.

REM 检查PowerShell版本
powershell -Command "if ($PSVersionTable.PSVersion.Major -ge 5) { exit 0 } else { exit 1 }" >nul 2>&1
if %errorlevel% equ 0 (
    echo 🚀 使用PowerShell执行自动化脚本...
    echo.
    powershell -ExecutionPolicy Bypass -File "auto-install-and-build.ps1"
) else (
    echo 🚀 使用批处理脚本执行自动化流程...
    echo.
    call "auto-install-and-build.bat"
)

echo.
echo 🎉 自动化流程执行完成！
pause
