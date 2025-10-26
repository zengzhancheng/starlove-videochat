# Simple build status checker (English to avoid encoding issues)

$repo = "zengzhancheng/starlove-videochat"

Write-Host "=== StarLove Build Status Checker ===" -ForegroundColor Cyan
Write-Host ""

try {
    $url = "https://api.github.com/repos/$repo/actions/runs?per_page=1&branch=main"
    $response = Invoke-RestMethod -Uri $url -Method Get
    
    if ($response.workflow_runs.Count -gt 0) {
        $run = $response.workflow_runs[0]
        
        Write-Host "Build Status: $($run.status)" -ForegroundColor Yellow
        Write-Host "Conclusion: $($run.conclusion)" -ForegroundColor $(if ($run.conclusion -eq "success") { "Green" } elseif ($run.conclusion -eq "failure") { "Red" } else { "Yellow" })
        Write-Host "Title: $($run.display_title)" -ForegroundColor White
        Write-Host ""
        Write-Host "View Details: $($run.html_url)" -ForegroundColor Blue
        
        if ($run.status -eq "completed") {
            if ($run.conclusion -eq "success") {
                Write-Host ""
                Write-Host "SUCCESS! APK is ready for download." -ForegroundColor Green
            } elseif ($run.conclusion -eq "failure") {
                Write-Host ""
                Write-Host "FAILED! Please check the build logs." -ForegroundColor Red
            }
        }
    }
} catch {
    Write-Host "Error checking build status: $_" -ForegroundColor Red
}

Write-Host ""

