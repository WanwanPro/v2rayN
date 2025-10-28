# 移除推广菜单的修改脚本

# 此脚本用于从V2rayN中移除推广菜单相关代码

# 1. 移除WPF版本中的推广菜单
# 文件: v2rayN/v2rayN/Views/MenuWindow.xaml
# 删除或注释掉包含"menuPromotion"的菜单项

# 2. 移除Desktop版本中的推广菜单
# 文件: v2rayN/v2rayN.Desktop/Pages/SettingsPage.axaml
# 删除或注释掉包含"menuPromotion"的菜单项

# 3. 可选：修改程序名称
# 文件: v2rayN/ServiceLib/Global.cs
# 修改以下行：
# public const string AppName = "v2rayN"; -> public const string AppName = "您的程序名";
# public const string AutoRunName = "v2rayNAutoRun"; -> public const string AutoRunName = "您的程序名AutoRun";

# 4. 可选：修改项目文件中的程序集名称
# 文件: v2rayN/v2rayN/v2rayN.csproj
# 添加或修改：<AssemblyName>您的程序名</AssemblyName>

# 5. 可选：修改Directory.Build.props中的作者信息
# 文件: Directory.Build.props
# 修改以下行：
# <Author>2dust</Author> -> <Author>您的名字</Author>

# 注意：这些修改需要重新编译程序才能生效