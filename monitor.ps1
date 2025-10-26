# Monitor build status (English only to avoid encoding issues)

param(
    [int]$Interval = 10,
    [int]$MaxChecks = 60
)

$repo = "zengzhancheng/starlove-videochat"
$checkCount = 0

Write-Host "=== StarLove Build Monitor ===" -ForegroundColor Cyan
Write-Host "Repository: $repo" -ForegroundColor Gray
Write-Host "Check interval: $Interval seconds" -ForegroundColor Gray
Write-Host "Max checks: $MaxChecks" -ForegroundColor Gray
Write-Host ""

while ($checkCount -lt $MaxChecks) {
    $checkCount++
    $timestamp = Get-Date -Format "HH:mm:ss"
    
    try {
        Write-Host "[$checkCount] $timestamp - Checking..." -ForegroundColor Yellow
        
        $url = "https://api.github.com/repos/$repo/actions/runs?per_page=1&branch=main"
        $response = Invoke-RestMethod -Uri $url -Method Get
        
        if ($response.workflow_runs.Count -gt 0) {
            $run = $response.workflow_runs[0]
            
            Write-Host "   Status: $($run.status)" -ForegroundColor $(if ($run.status -eq "completed") { "Green" } else { "Yellow" })
            Write-Host "   Conclusion: $($run.conclusion)" -ForegroundColor $(if ($run.conclusion -eq "success") { "Green" } elseif ($run.conclusion -eq "failure") { "Red" } else { "Gray" })
            
            if ($run.status -eq "completed") {
                Write-Host ""
                if ($run.conclusion -eq "success") {
                    Write-Host "SUCCESS! APK ready." -ForegroundColor Green
                    Write-Host "Download: $($run.html_url)" -ForegroundColor Blue
                    break
                } elseif ($run.conclusion -eq "failure") {
                    Write-Host "FAILED! Check logs." -ForegroundColor Red
                    Write-Host "Logs: $($run.html_url)" -ForegroundColor Blue
                    break
                }
            }
        }
    } catch {
        Write-Host "   Error: $_" -ForegroundColor Red
    }
    
    if ($checkCount -lt $MaxChecks) {
        Start-Sleep -Seconds $Interval
        Write-Host ""
    }
}

Write-Host ""
Write-Host "Monitor stopped." -ForegroundColor Gray

