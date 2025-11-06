# 手动触发GitHub Actions工作流脚本说明

## 方法一：使用PowerShell脚本（推荐）

1. 首先设置GitHub Personal Access Token环境变量：
   ```powershell
   $env:GITHUB_TOKEN = "your_github_token_here"
   ```
   
   获取token的方法：
   - 访问 https://github.com/settings/tokens
   - 点击"Generate new token"
   - 选择"repo"权限
   - 复制生成的token

2. 运行触发脚本：
   ```powershell
   .\trigger-build.ps1
   ```

## 方法二：通过GitHub网页界面手动操作

1. 访问您的GitHub仓库：https://github.com/WanwanPro/v2rayN
2. 点击"Actions"选项卡
3. 在左侧工作流列表中选择"Sync, Modify and Build"
4. 点击右侧的"Run workflow"按钮
5. 在弹出的对话框中，勾选"强制同步上游更新"选项
6. 点击"Start workflow"按钮开始构建

## 构建完成后

构建完成后，您可以：
1. 在"Actions"页面查看构建日志
2. 在"Releases"页面查看新创建的Release并下载构建产物
3. 收到飞书通知（如果已配置）

## 注意事项

- 工作流会自动生成版本标签（格式：vYYYYMMDD-HHMM）
- 构建的产物包括Windows x64和ARM64版本，以及自包含版本
- 所有构建产物都会上传到GitHub Releases页面