# 星恋 - 完全自动化Git安装和构建流程
Write-Host "💫 星恋 - 完全自动化Git安装和构建流程" -ForegroundColor Magenta
Write-Host ""

# 检查管理员权限
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "⚠️  需要管理员权限来安装Git" -ForegroundColor Yellow
    Write-Host "🔄 正在请求管理员权限..." -ForegroundColor Cyan
    
    # 重新以管理员身份运行
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "✅ 管理员权限已获取" -ForegroundColor Green
Write-Host ""

# 检查Git是否已安装
Write-Host "🔍 检查Git安装状态..." -ForegroundColor Cyan
try {
    $gitVersion = git --version 2>$null
    if ($gitVersion) {
        Write-Host "✅ Git已经安装: $gitVersion" -ForegroundColor Green
        $gitInstalled = $true
    }
} catch {
    Write-Host "📥 Git未安装，开始自动安装..." -ForegroundColor Yellow
    $gitInstalled = $false
}

if (-not $gitInstalled) {
    Write-Host "📥 正在下载Git安装程序..." -ForegroundColor Cyan
    
    $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe"
    $gitInstaller = "GitInstaller.exe"
    
    try {
        Invoke-WebRequest -Uri $gitUrl -OutFile $gitInstaller -UseBasicParsing
        Write-Host "✅ Git安装程序下载完成" -ForegroundColor Green
    } catch {
        Write-Host "❌ Git下载失败: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "📋 请手动安装Git: https://git-scm.com/download/win" -ForegroundColor Yellow
        Read-Host "按回车键退出"
        exit 1
    }
    
    Write-Host "🚀 正在安装Git..." -ForegroundColor Cyan
    Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-", "/CLOSEAPPLICATIONS", "/RESTARTAPPLICATIONS" -Wait
    
    Write-Host "⏳ 等待Git安装完成..." -ForegroundColor Yellow
    Start-Sleep -Seconds 30
    
    # 添加到PATH
    Write-Host "🔧 配置Git环境变量..." -ForegroundColor Cyan
    $gitPath = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd"
    $currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
    if ($currentPath -notlike "*$gitPath*") {
        [Environment]::SetEnvironmentVariable("PATH", "$currentPath;$gitPath", "Machine")
    }
    
    # 刷新环境变量
    $env:PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine")
    
    # 验证安装
    try {
        $gitVersion = & "C:\Program Files\Git\bin\git.exe" --version
        Write-Host "✅ Git安装成功: $gitVersion" -ForegroundColor Green
    } catch {
        Write-Host "❌ Git安装验证失败" -ForegroundColor Red
        Write-Host "🔄 请重新打开命令行窗口" -ForegroundColor Yellow
        Read-Host "按回车键退出"
        exit 1
    }
    
    # 清理安装文件
    Remove-Item $gitInstaller -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "🎉 Git安装完成！开始设置GitHub Actions..." -ForegroundColor Green
Write-Host ""

# 检查Git配置
Write-Host "🔍 检查Git用户配置..." -ForegroundColor Cyan
try {
    $gitUserName = git config --global user.name
    $gitUserEmail = git config --global user.email
    if (-not $gitUserName -or -not $gitUserEmail) {
        Write-Host "⚠️  Git用户信息未配置" -ForegroundColor Yellow
        $username = Read-Host "请输入GitHub用户名"
        $email = Read-Host "请输入GitHub邮箱"
        git config --global user.name $username
        git config --global user.email $email
        Write-Host "✅ Git用户信息已配置" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Git配置失败" -ForegroundColor Red
}

Write-Host ""
Write-Host "📝 创建GitHub仓库..." -ForegroundColor Cyan
Write-Host ""
Write-Host "🌐 请按照以下步骤创建GitHub仓库:" -ForegroundColor Yellow
Write-Host "1. 访问: https://github.com/new" -ForegroundColor White
Write-Host "2. 仓库名称: starlove-videochat" -ForegroundColor White
Write-Host "3. 设置为公开仓库" -ForegroundColor White
Write-Host "4. 不要初始化README、.gitignore或license" -ForegroundColor White
Write-Host "5. 点击'Create repository'" -ForegroundColor White
Write-Host ""

$githubUrl = Read-Host "请输入GitHub仓库URL (例如: https://github.com/username/starlove-videochat.git)"

if (-not $githubUrl) {
    Write-Host "❌ 未提供GitHub仓库URL" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host ""
Write-Host "🚀 开始推送代码到GitHub..." -ForegroundColor Cyan

try {
    # 初始化Git仓库
    Write-Host "📝 初始化Git仓库..." -ForegroundColor Yellow
    git init
    
    # 添加所有文件
    Write-Host "📁 添加项目文件..." -ForegroundColor Yellow
    git add .
    
    # 提交代码
    Write-Host "💾 提交代码..." -ForegroundColor Yellow
    git commit -m "Initial commit: 星恋应用 - 视频聊天社交"
    
    # 设置主分支
    Write-Host "🌿 设置主分支..." -ForegroundColor Yellow
    git branch -M main
    
    # 添加远程仓库
    Write-Host "🔗 添加远程仓库..." -ForegroundColor Yellow
    git remote add origin $githubUrl
    
    # 推送代码
    Write-Host "📤 推送代码到GitHub..." -ForegroundColor Yellow
    git push -u origin main
    
    Write-Host "✅ 代码推送成功！" -ForegroundColor Green
} catch {
    Write-Host "❌ 代码推送失败: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "💡 请检查GitHub仓库URL和网络连接" -ForegroundColor Yellow
    Read-Host "按回车键退出"
    exit 1
}

Write-Host ""
Write-Host "🎯 设置Expo Token..." -ForegroundColor Cyan
Write-Host ""
Write-Host "🌐 请按照以下步骤设置Expo Token:" -ForegroundColor Yellow
Write-Host "1. 访问: https://expo.dev/settings/access-tokens" -ForegroundColor White
Write-Host "2. 创建新的Access Token" -ForegroundColor White
Write-Host "3. 复制Token" -ForegroundColor White
Write-Host "4. 在GitHub仓库的Settings → Secrets → Actions中添加EXPO_TOKEN" -ForegroundColor White
Write-Host ""

$expoToken = Read-Host "请输入Expo Token (可选，稍后可在GitHub中设置)"

if ($expoToken) {
    Write-Host "🔧 配置Expo Token..." -ForegroundColor Yellow
    "EXPO_TOKEN=$expoToken" | Out-File -FilePath ".env.local" -Encoding UTF8
    Write-Host "✅ Expo Token已配置" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎉 GitHub Actions设置完成！" -ForegroundColor Green
Write-Host ""
Write-Host "📋 接下来GitHub Actions将自动:" -ForegroundColor Cyan
Write-Host "1. 检测到代码推送" -ForegroundColor White
Write-Host "2. 开始云端构建APK" -ForegroundColor White
Write-Host "3. 构建完成后在Actions页面提供下载" -ForegroundColor White
Write-Host ""
Write-Host "🌐 查看构建状态: $githubUrl/actions" -ForegroundColor Yellow
Write-Host ""
Write-Host "⏳ 首次构建通常需要5-10分钟" -ForegroundColor Yellow
Write-Host "💡 构建完成后，在Actions页面的Artifacts部分下载APK" -ForegroundColor Cyan
Write-Host ""
Read-Host "按回车键退出"
