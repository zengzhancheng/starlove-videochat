# Download and install latest APK automatically

Write-Host "=== Download and Install Starlove APK ===" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check ADB connection
Write-Host "[1/3] Checking phone connection..." -ForegroundColor Yellow
$devices = adb devices 2>&1

if ($devices -match "device") {
    Write-Host "Phone connected" -ForegroundColor Green
} else {
    Write-Host "No phone detected!" -ForegroundColor Red
    exit 1
}

# Step 2: Download APK from GitHub Actions
Write-Host ""
Write-Host "[2/3] Downloading APK..." -ForegroundColor Yellow

$repo = "zengzhancheng/starlove-videochat"
$runUrl = "https://github.com/$repo/actions/runs/18817209141"

Write-Host "Please download APK from GitHub Actions:" -ForegroundColor Yellow
Write-Host "$runUrl" -ForegroundColor Blue
Write-Host ""
Write-Host "Instructions:" -ForegroundColor Yellow
Write-Host "1. Open the link above" -ForegroundColor Gray
Write-Host "2. Scroll down to 'Artifacts' section" -ForegroundColor Gray
Write-Host "3. Click 'starlove-apk' to download" -ForegroundColor Gray
Write-Host "4. Save it in the current directory as 'starlove.apk'" -ForegroundColor Gray
Write-Host ""
Write-Host "Press any key after downloading..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Step 3: Install APK
Write-Host ""
Write-Host "[3/3] Installing APK..." -ForegroundColor Yellow

if (Test-Path ".\starlove.apk") {
    adb install -r ".\starlove.apk"
    
    Write-Host ""
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host "The app is now installed on your phone!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Test it:" -ForegroundColor Yellow
    Write-Host "adb shell am start -n com.starlove/.MainActivity" -ForegroundColor Gray
} else {
    Write-Host "APK file not found" -ForegroundColor Red
    Write-Host "Please make sure you downloaded the file as 'starlove.apk'" -ForegroundColor Yellow
}

Write-Host ""

