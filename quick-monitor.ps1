# 快速监控构建状态（每5秒检查一次）
$repo = "zengzhancheng/starlove-videochat"
$checkInterval = 5
$maxChecks = 200

Write-Host "=== 星恋APK构建监控 ===" -ForegroundColor Cyan
Write-Host "仓库: $repo" -ForegroundColor Gray
Write-Host "检查间隔: $checkInterval 秒" -ForegroundColor Gray
Write-Host "最大检查次数: $maxChecks" -ForegroundColor Gray
Write-Host ""

$checkCount = 0

while ($checkCount -lt $maxChecks) {
    $checkCount++
    $timestamp = Get-Date -Format "HH:mm:ss"
    
    try {
        Write-Host "[$checkCount] $timestamp - 检查构建状态..." -ForegroundColor Yellow
        
        $url = "https://api.github.com/repos/$repo/actions/runs?per_page=1&branch=main"
        $response = Invoke-RestMethod -Uri $url -Method Get
        
        if ($response.workflow_runs.Count -gt 0) {
            $run = $response.workflow_runs[0]
            
            Write-Host "  状态: $($run.status)" -ForegroundColor $(if ($run.status -eq "completed") { "Green" } else { "Yellow" })
            Write-Host "  结果: $($run.conclusion)" -ForegroundColor $(if ($run.conclusion -eq "success") { "Green" } elseif ($run.conclusion -eq "failure") { "Red" } else { "Gray" })
            Write-Host "  标题: $($run.display_title)" -ForegroundColor White
            
            if ($run.status -eq "completed") {
                Write-Host ""
                if ($run.conclusion -eq "success") {
                    Write-Host "✅ 构建成功！" -ForegroundColor Green
                    Write-Host "🔗 https://github.com/$repo/actions/runs/$($run.id)" -ForegroundColor Blue
                    break
                } elseif ($run.conclusion -eq "failure") {
                    Write-Host "❌ 构建失败！" -ForegroundColor Red
                    Write-Host "🔗 https://github.com/$repo/actions/runs/$($run.id)" -ForegroundColor Blue
                    break
                }
            } elseif ($run.status -eq "queued") {
                Write-Host "  等待构建队列..." -ForegroundColor Gray
            } elseif ($run.status -eq "in_progress") {
                Write-Host "  构建进行中..." -ForegroundColor Cyan
            }
        }
    } catch {
        Write-Host "  检查出错: $_" -ForegroundColor Red
    }
    
    Start-Sleep -Seconds $checkInterval
    Write-Host ""
}

if ($checkCount -ge $maxChecks) {
    Write-Host "达到最大检查次数" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "查看详情: https://github.com/$repo/actions" -ForegroundColor Cyan

