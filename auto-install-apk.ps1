# Auto download and install APK

Write-Host "=== Auto Install Starlove APK ===" -ForegroundColor Cyan

# Check phone
$devices = adb devices
if (-not ($devices -match "device")) {
    Write-Host "No phone connected" -ForegroundColor Red
    exit 1
}
Write-Host "Phone connected" -ForegroundColor Green

# Download APK location
Write-Host "Download APK from:" -ForegroundColor Yellow
Write-Host "https://github.com/zengzhancheng/starlove-videochat/actions/runs/18817377072" -ForegroundColor Blue
Write-Host ""
Write-Host "After downloading, place APK file in current directory as 'starlove.apk'" -ForegroundColor Yellow
Write-Host "Then press Enter..." -ForegroundColor Yellow
Read-Host

if (Test-Path ".\starlove.apk") {
    Write-Host "Installing..." -ForegroundColor Yellow
    adb install -r starlove.apk
    Write-Host "Done!" -ForegroundColor Green
} else {
    Write-Host "APK file not found" -ForegroundColor Red
}

