# V2rayN 自动化构建与自定义

本项目提供了自动化流程，用于同步上游V2rayN仓库、应用自定义修改（如移除推广菜单）、构建多平台版本，并通过飞书机器人发送通知。

## 功能特点

- 🔁 **自动同步**：定期检查上游仓库更新并自动合并
- 🚫 **移除推广**：自动移除推广菜单相关代码
- 🏗️ **多平台构建**：支持Windows x64和ARM64架构
- 🤖 **飞书通知**：构建完成后自动发送通知到飞书群聊
- 📦 **自动发布**：支持创建GitHub Release

## 快速开始

### 1. 配置飞书机器人

参考 [FEISHU_SETUP.md](./FEISHU_SETUP.md) 创建飞书机器人并获取Webhook URL。

### 2. 设置GitHub Secrets

在GitHub仓库中添加以下Secret：
- `FEISHU_WEBHOOK_URL`: 飞书机器人的Webhook URL

### 3. 启用工作流

将 `sync-modify-build.yml` 文件放置在 `.github/workflows/` 目录下，工作流将自动启动。

## 工作流程

1. **自动同步**（每日UTC 08:00）：
   - 检查上游仓库是否有新提交
   - 如果有新提交，则自动合并到您的仓库

2. **应用修改**：
   - 移除WPF和Desktop版本中的推广菜单
   - 可选：修改程序名称（需要自定义脚本）

3. **构建和发布**：
   - 构建Windows x64和ARM64版本
   - 创建自包含可执行文件
   - 上传构建产物到GitHub Artifacts

4. **飞书通知**：
   - 发送构建结果通知
   - 包含下载链接和版本信息

## 手动操作

### 手动触发构建

1. 进入GitHub仓库的"Actions"页面
2. 选择"Sync, Modify and Build"工作流
3. 点击"Run workflow"
4. 可选参数：
   - `force_sync`: 强制同步（即使没有新提交）
   - `release_tag`: 创建发布版本标签

### 手动应用修改

参考 [MODIFY_GUIDE.md](./MODIFY_GUIDE.md) 了解如何手动应用修改。

## 自定义程序名称

如果您想修改程序名称，有两种方法：

### 方法1：修改工作流文件（推荐）

1. 编辑 `.github/workflows/sync-modify-build.yml` 文件
2. 找到 `env` 部分，修改 `CUSTOM_APP_NAME` 变量：
   ```yaml
   env:
     # ...其他变量...
     # 自定义程序名称（留空则使用官方名称）
     CUSTOM_APP_NAME: "您的程序名"
   ```
3. 提交更改，之后的每次自动构建都会使用您的自定义名称

### 方法2：手动修改代码

1. 修改 `v2rayN/ServiceLib/Global.cs` 中的 `AppName` 和 `AutoRunName` 常量
2. 可选：修改项目文件中的程序集名称
3. 可选：修改作者信息和其他元数据

**注意**：方法2的修改会在下次自动同步时被覆盖，除非同时修改工作流文件。

## 下载构建产物

### GitHub Artifacts（30天内有效）

1. 进入Actions页面
2. 点击完成的构建任务
3. 在"Artifacts"部分下载"v2rayN-windows"

### GitHub Release（如果提供了release_tag）

1. 进入仓库的"Releases"页面
2. 找到对应的版本标签
3. 下载ZIP压缩包

## 注意事项

1. 确保您的仓库是公开的，或者您有足够的权限
2. 飞书机器人URL不要泄露，避免被滥用
3. 首次运行可能需要较长时间
4. 如果构建失败，检查Actions日志获取错误信息
5. 自定义修改部分可能需要根据上游代码更新进行调整

## 故障排除

### 构建失败

1. 检查Actions日志中的错误信息
2. 确认上游仓库是否有重大更改
3. 检查自定义修改是否与最新代码兼容

### 飞书通知失败

1. 验证`FEISHU_WEBHOOK_URL`是否正确
2. 检查飞书机器人是否被禁用
3. 确认网络连接是否正常

### 同步失败

1. 检查上游仓库URL是否正确
2. 确认是否有合并冲突
3. 尝试手动解决冲突或使用`force_sync`参数

## 贡献

欢迎提交Issue和Pull Request来改进这个自动化流程！