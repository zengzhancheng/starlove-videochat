# 修复PowerShell中文乱码问题

Write-Host "🔧 正在修复PowerShell编码..." -ForegroundColor Cyan

# 设置控制台代码页为UTF-8
chcp 65001 | Out-Null

# 设置PowerShell输出编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8

# 设置环境变量
$env:PYTHONIOENCODING = "utf-8"
$env:LANG = "en_US.UTF-8"

Write-Host "✅ 编码已设置为UTF-8" -ForegroundColor Green
Write-Host "当前代码页: $(chcp.com)" -ForegroundColor Gray
Write-Host ""
Write-Host "测试中文显示：星恋 - 让每一颗心都找到属于自己的星星" -ForegroundColor Yellow

