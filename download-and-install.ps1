# Download and install latest APK to phone

Write-Host "=== Download and Install Starlove APK ===" -ForegroundColor Cyan
Write-Host ""

# Check phone connection
Write-Host "[1/3] Checking phone..." -ForegroundColor Yellow
$devices = adb devices 2>&1

if ($devices -match "device") {
    Write-Host "Phone connected: OK" -ForegroundColor Green
} else {
    Write-Host "No phone detected!" -ForegroundColor Red
    Write-Host "Please connect your phone via USB and enable USB debugging" -ForegroundColor Yellow
    exit 1
}

# Download APK from GitHub Actions
Write-Host ""
Write-Host "[2/3] Downloading APK from GitHub..." -ForegroundColor Yellow

$runUrl = "https://github.com/zengzhancheng/starlove-videochat/actions/runs/18817377072"
Write-Host "Latest build: $runUrl" -ForegroundColor Gray

# Try to download artifact
Write-Host "Please download APK manually from:" -ForegroundColor Yellow
Write-Host "$runUrl" -ForegroundColor Blue
Write-Host ""
Write-Host "Or enter APK file path:" -ForegroundColor Yellow
$apkPath = Read-Host

if (-not (Test-Path $apkPath)) {
    # Try default download location
    $defaultPath = "$env:USERPROFILE\Downloads\starlove-apk.zip"
    if (Test-Path $defaultPath) {
        Write-Host "Found APK in Downloads..." -ForegroundColor Yellow
        Expand-Archive -Path $defaultPath -DestinationPath . -Force
        $apkPath = ".\starlove.apk"
    } else {
        Write-Host "APK not found" -ForegroundColor Red
        exit 1
    }
}

# Install APK
Write-Host ""
Write-Host "[3/3] Installing APK to phone..." -ForegroundColor Yellow

try {
    adb install -r $apkPath
    Write-Host ""
    Write-Host "SUCCESS! APK installed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "The app '星恋' is now on your phone!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To launch the app:" -ForegroundColor Yellow
    Write-Host "adb shell monkey -p com.starlove -c android.intent.category.LAUNCHER 1" -ForegroundColor Gray
} catch {
    Write-Host "Install failed: $_" -ForegroundColor Red
}

Write-Host ""
