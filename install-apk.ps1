# Auto install APK to phone (English only to avoid encoding issues)

Write-Host "=== Starlove APK Auto Install ===" -ForegroundColor Cyan
Write-Host ""

# Check ADB
$adbPath = Get-Command adb -ErrorAction SilentlyContinue
if (-not $adbPath) {
    Write-Host "ADB not found" -ForegroundColor Red
    Write-Host "Please install Android SDK Platform Tools" -ForegroundColor Yellow
    Write-Host "Download: https://developer.android.com/studio/releases/platform-tools" -ForegroundColor Blue
    exit 1
}

Write-Host "Checking phone connection..." -ForegroundColor Yellow
$devices = adb devices

if ($devices -match "device") {
    Write-Host "Phone connected" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "No phone detected" -ForegroundColor Red
    Write-Host "Please:" -ForegroundColor Yellow
    Write-Host "  1. Connect phone via USB" -ForegroundColor Gray
    Write-Host "  2. Enable USB debugging" -ForegroundColor Gray
    Write-Host "  3. Allow this computer to debug" -ForegroundColor Gray
    exit 1
}

# Check if APK exists
$apkPath = ".\starlove.apk"

if (-not (Test-Path $apkPath)) {
    Write-Host "APK file not found: $apkPath" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please download APK from:" -ForegroundColor Yellow
    Write-Host "https://github.com/zengzhancheng/starlove-videochat/actions" -ForegroundColor Blue
    Write-Host ""
    
    $manualApk = Read-Host "Enter APK file path (or press Enter to exit)"
    
    if ([string]::IsNullOrWhiteSpace($manualApk)) {
        exit 0
    }
    
    if (Test-Path $manualApk) {
        $apkPath = $manualApk
    } else {
        Write-Host "APK not found: $manualApk" -ForegroundColor Red
        exit 1
    }
}

# Install APK
Write-Host ""
Write-Host "Installing APK..." -ForegroundColor Yellow

try {
    adb install -r $apkPath
    
    Write-Host ""
    Write-Host "SUCCESS! APK installed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "You can now test the app on your phone!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To uninstall, run:" -ForegroundColor Gray
    Write-Host "  adb uninstall com.starlove" -ForegroundColor White
} catch {
    Write-Host "Failed to install: $_" -ForegroundColor Red
}

Write-Host ""

