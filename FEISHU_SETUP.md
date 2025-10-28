# 飞书机器人配置指南

## 1. 创建飞书机器人

1. 在飞书中创建一个群聊（或使用现有群聊）
2. 在群聊中添加"自定义机器人"：
   - 点击群聊右上角"..."
   - 选择"设置" -> "群机器人" -> "添加机器人"
   - 选择"自定义机器人"
   - 设置机器人名称和头像
   - 选择安全设置（推荐使用"加签"验证）
   - 复制生成的Webhook URL

## 2. 配置GitHub Secrets

在您的GitHub仓库中设置以下Secrets：

1. 进入GitHub仓库页面
2. 点击"Settings" -> "Secrets and variables" -> "Actions"
3. 点击"New repository secret"
4. 添加以下Secret：

   - **名称**: `FEISHU_WEBHOOK_URL`
   - **值**: 您从飞书机器人获取的Webhook URL

## 3. 自动化工作流说明

创建的`sync-modify-build.yml`工作流将执行以下操作：

1. **自动同步**：
   - 每天UTC时间08:00（北京时间16:00）自动运行
   - 检查上游仓库是否有新提交
   - 如果有新提交，则自动合并到您的仓库

2. **应用自定义修改**：
   - 自动移除推广菜单（WPF和Desktop版本）
   - 可选：修改程序名称（需要取消注释相关代码并自定义名称）

3. **构建和发布**：
   - 构建Windows x64和ARM64版本
   - 构建自包含版本（不需要.NET运行时）
   - 如果提供了release_tag，则创建GitHub Release

4. **飞书通知**：
   - 构建完成后自动发送通知到飞书群聊
   - 包含版本信息、提交信息和下载链接

## 4. 手动触发构建

您也可以手动触发构建：

1. 进入GitHub仓库的"Actions"页面
2. 选择"Sync, Modify and Build"工作流
3. 点击"Run workflow"
4. 可选参数：
   - `force_sync`: 设置为`true`强制同步（即使没有新提交）
   - `release_tag`: 输入版本标签（如v7.15.6）来创建发布版本

## 5. 自定义程序名称（可选）

如果您想修改程序名称，需要：

1. 在工作流文件中取消注释以下行并自定义：
   ```yaml
   # sed -i 's/public const string AppName = "v2rayN";/public const string AppName = "您的程序名";/g' v2rayN/ServiceLib/Global.cs
   # sed -i 's/public const string AutoRunName = "v2rayNAutoRun";/public const string AutoRunName = "您的程序名AutoRun";/g' v2rayN/ServiceLib/Global.cs
   ```

2. 将"您的程序名"替换为您想要的程序名称

## 6. 下载构建产物

构建完成后，您可以通过以下方式下载：

1. **GitHub Artifacts**（30天内有效）：
   - 进入Actions页面
   - 点击完成的构建任务
   - 在"Artifacts"部分下载"v2rayN-windows"

2. **GitHub Release**（如果提供了release_tag）：
   - 进入仓库的"Releases"页面
   - 找到对应的版本标签
   - 下载ZIP压缩包

## 7. 注意事项

1. 确保您的仓库是公开的，或者您有足够的权限
2. 飞书机器人URL不要泄露，避免被滥用
3. 首次运行可能需要较长时间，因为需要构建所有平台
4. 如果构建失败，检查Actions日志获取错误信息
5. 自定义修改部分可能需要根据上游代码更新进行调整