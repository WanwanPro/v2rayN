# 手动触发GitHub Actions工作流脚本
# 使用方法: ./trigger-build.ps1

# 仓库信息
$owner = "WanwanPro"
$repo = "v2rayN"
$workflow = "sync-modify-build.yml"

# 获取GitHub token (需要提前设置环境变量)
$token = $env:GITHUB_TOKEN
if (-not $token) {
    Write-Host "错误: 未设置GITHUB_TOKEN环境变量"
    Write-Host "请先设置GitHub Personal Access Token:"
    Write-Host "1. 访问 https://github.com/settings/tokens"
    Write-Host "2. 生成新的token (需要repo权限)"
    Write-Host "3. 设置环境变量: `$env:GITHUB_TOKEN = 'your_token_here'"
    exit 1
}

# 创建触发请求的URL
$url = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow/dispatches"

# 请求体
$body = @{
    ref = "master"
    inputs = @{
        force_sync = "true"
    }
} | ConvertTo-Json

# 发送请求
try {
    $response = Invoke-RestMethod -Uri $url -Method Post -Body $body -Headers @{
        "Authorization" = "token $token"
        "Accept" = "application/vnd.github.v3+json"
    }
    
    Write-Host "成功触发工作流!"
    Write-Host "请访问以下链接查看构建进度:"
    Write-Host "https://github.com/$owner/$repo/actions"
} catch {
    Write-Host "触发工作流失败: $_"
    Write-Host "请检查您的GitHub token是否有足够的权限"
}