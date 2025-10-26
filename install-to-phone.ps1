# 自动下载APK并安装到手机

Write-Host "=== 星恋APK自动安装到手机 ===" -ForegroundColor Cyan
Write-Host ""

# 检查ADB是否安装
$adbPath = Get-Command adb -ErrorAction SilentlyContinue
if (-not $adbPath) {
    Write-Host "❌ ADB未安装" -ForegroundColor Red
    Write-Host "正在下载ADB..." -ForegroundColor Yellow
    
    # 下载ADB平台工具
    $adbUrl = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
    $zipPath = "$env:TEMP\platform-tools.zip"
    
    try {
        Invoke-WebRequest -Uri $adbUrl -OutFile $zipPath
        Expand-Archive -Path $zipPath -DestinationPath "$env:TEMP\platform-tools\" -Force
        $env:PATH += ";$env:TEMP\platform-tools\platform-tools"
        
        Write-Host "✅ ADB已安装" -ForegroundColor Green
    } catch {
        Write-Host "❌ 下载ADB失败: $_" -ForegroundColor Red
        Write-Host "请手动安装ADB: https://developer.android.com/studio/releases/platform-tools" -ForegroundColor Yellow
        exit 1
    }
}

# 检查手机连接
Write-Host "🔍 检查手机连接..." -ForegroundColor Yellow
$devices = & adb devices 2>$null

if ($devices -match "device$") {
    Write-Host "✅ 手机已连接" -ForegroundColor Green
    & adb devices
    Write-Host ""
} else {
    Write-Host "❌ 未检测到手机连接" -ForegroundColor Red
    Write-Host "请确保:" -ForegroundColor Yellow
    Write-Host "  1. 手机通过USB连接到电脑" -ForegroundColor Gray
    Write-Host "  2. 在手机上启用'USB调试'" -ForegroundColor Gray
    Write-Host "  3. 在手机上允许此电脑的调试" -ForegroundColor Gray
    exit 1
}

# 从GitHub Actions下载最新APK
Write-Host "📥 正在下载最新APK..." -ForegroundColor Yellow

$repo = "zengzhancheng/starlove-videochat"
$apkPath = ".\starlove.apk"

try {
    # 获取最新的构建
    $url = "https://api.github.com/repos/$repo/actions/runs?per_page=1&branch=main"
    $response = Invoke-RestMethod -Uri $url
    
    if ($response.workflow_runs.Count -gt 0) {
        $run = $response.workflow_runs[0]
        Write-Host "构建ID: $($run.id)" -ForegroundColor Gray
        Write-Host "状态: $($run.status)" -ForegroundColor Gray
        
        if ($run.status -ne "completed" -or $run.conclusion -ne "success") {
            Write-Host "⚠️  最新构建未完成或失败" -ForegroundColor Yellow
            Write-Host "请访问: $($run.html_url)" -ForegroundColor Blue
            exit 1
        }
        
        # 下载Artifact
        Write-Host "📦 正在下载APK artifact..." -ForegroundColor Yellow
        
        # 由于GitHub API限制，提示用户手动下载
        Write-Host ""
        Write-Host "由于GitHub API限制，请手动下载APK:" -ForegroundColor Yellow
        Write-Host "🔗 $($run.html_url)" -ForegroundColor Blue
        Write-Host ""
        
        $manualApk = Read-Host "请输入APK文件路径（或按Enter使用./starlove.apk）"
        
        if ([string]::IsNullOrWhiteSpace($manualApk)) {
            $manualApk = ".\starlove.apk"
        }
        
        if (Test-Path $manualApk) {
            $apkPath = $manualApk
            Write-Host "✅ 使用APK: $apkPath" -ForegroundColor Green
        } else {
            Write-Host "❌ APK文件不存在: $manualApk" -ForegroundColor Red
            Write-Host "请先从GitHub Actions下载APK" -ForegroundColor Yellow
            exit 1
        }
    }
} catch {
    Write-Host "❌ 下载失败: $_" -ForegroundColor Red
    Write-Host "将使用本地APK文件" -ForegroundColor Yellow
    
    if (-not (Test-Path $apkPath)) {
        Write-Host "❌ 未找到本地APK文件" -ForegroundColor Red
        exit 1
    }
}

# 安装APK到手机
Write-Host ""
Write-Host "📱 正在安装APK到手机..." -ForegroundColor Yellow

try {
    & adb install -r $apkPath
    
    Write-Host ""
    Write-Host "✅ APK安装成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "🎉 可以开始测试应用了！" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "如需卸载，运行:" -ForegroundColor Gray
    Write-Host "  adb uninstall com.starlove" -ForegroundColor White
} catch {
    Write-Host "❌ 安装失败: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "请检查:" -ForegroundColor Yellow
    Write-Host "  1. 手机是否允许安装未知来源应用" -ForegroundColor Gray
    Write-Host "  2. 手机调试模式是否正常" -ForegroundColor Gray
    Write-Host "  3. USB连接是否稳定" -ForegroundColor Gray
}

Write-Host ""

