# 禁用不需要的工作流文件

如果您只需要Windows构建，可以按照以下步骤禁用或删除不需要的工作流文件：

## 方法1：重命名文件（推荐）

将不需要的工作流文件重命名，添加`.disabled`后缀，这样GitHub Actions将不会执行它们：

```bash
# 在本地仓库中执行
cd .github/workflows/
mv build-linux.yml build-linux.yml.disabled
mv build-osx.yml build-osx.yml.disabled
mv build-windows-desktop.yml build-windows-desktop.yml.disabled
mv build-all.yml build-all.yml.disabled
```

## 方法2：删除文件

直接删除不需要的工作流文件：

```bash
# 在本地仓库中执行
cd .github/workflows/
rm build-linux.yml
rm build-osx.yml
rm build-windows-desktop.yml
rm build-all.yml
```

## 方法3：修改工作流文件

在每个不需要的工作流文件开头添加以下内容，禁用它们：

```yaml
# 此工作流已禁用
name: Disabled Workflow

on:
  push:
    branches:
      - disabled

jobs:
  disabled:
    runs-on: ubuntu-latest
    steps:
      - name: Disabled
        run: echo "This workflow is disabled"
```

## 推荐方案

1. 保留以下文件：
   - `sync-modify-build.yml` - 您的自定义同步和构建工作流
   - `build-windows.yml` - 原始的Windows构建工作流（可选）
   - `winget-publish.yml` - 如果需要发布到Winget

2. 禁用或删除以下文件：
   - `build-linux.yml` - Linux构建
   - `build-osx.yml` - macOS构建
   - `build-windows-desktop.yml` - Windows桌面版（Avalonia UI）
   - `build-all.yml` - 全平台构建触发器

## 注意事项

1. 修改后记得提交更改到您的仓库
2. 如果您使用`sync-modify-build.yml`，可以禁用`build-windows.yml`，因为前者已经包含了Windows构建功能
3. 修改后，当前正在运行的工作流仍会继续执行，但新的触发将不会启动它们