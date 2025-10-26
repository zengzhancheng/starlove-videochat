@echo off
echo 🌟 创建 Sparkle 应用图标...
echo.

REM 创建 assets 目录
if not exist "assets" mkdir assets

REM 创建简单的图标文件说明
echo 正在创建图标文件说明...

echo # Sparkle 应用图标文件说明 > assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ## 需要的图标文件 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ### 主图标 >> assets\ICON_README.md
echo - sparkle-icon.png (1024x1024px) - 主应用图标 >> assets\ICON_README.md
echo - sparkle-adaptive-icon.png (1024x1024px) - Android自适应图标 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ### 启动画面 >> assets\ICON_README.md
echo - sparkle-splash.png (1242x2436px) - 启动画面 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ### 网页图标 >> assets\ICON_README.md
echo - sparkle-favicon.png (32x32px) - 网页图标 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ## 设计规范 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ### 主图标设计 >> assets\ICON_README.md
echo - 中心: 立体心形，红色到粉色渐变 >> assets\ICON_README.md
echo - 外围: 闪烁的星火粒子围绕心形 >> assets\ICON_README.md
echo - 背景: 深色渐变背景 (#2C3E50 到 #8E44AD) >> assets\ICON_README.md
echo - 效果: 3D立体，带有发光效果 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ### 色彩方案 >> assets\ICON_README.md
echo - 心形: #FF6B6B 到 #FFB6C1 渐变 >> assets\ICON_README.md
echo - 星火: #FFE66D (金黄色) >> assets\ICON_README.md
echo - 背景: #2C3E50 到 #8E44AD 渐变 >> assets\ICON_README.md
echo - 发光: rgba(255, 107, 107, 0.3) >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ## 制作工具推荐 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo 1. **Adobe Illustrator** - 矢量图标设计 >> assets\ICON_README.md
echo 2. **Figma** - 在线协作设计 >> assets\ICON_README.md
echo 3. **Sketch** - Mac平台设计工具 >> assets\ICON_README.md
echo 4. **Canva** - 简单易用的在线设计 >> assets\ICON_README.md
echo 5. **GIMP** - 免费开源图像编辑 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ## 快速制作步骤 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo 1. 使用设计工具创建 1024x1024px 画布 >> assets\ICON_README.md
echo 2. 添加深色渐变背景 >> assets\ICON_README.md
echo 3. 绘制立体心形，应用红色到粉色渐变 >> assets\ICON_README.md
echo 4. 添加星火粒子效果 >> assets\ICON_README.md
echo 5. 应用发光和阴影效果 >> assets\ICON_README.md
echo 6. 导出为 PNG 格式 >> assets\ICON_README.md
echo 7. 使用在线工具生成多尺寸版本 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo ## 在线图标生成工具 >> assets\ICON_README.md
echo. >> assets\ICON_README.md
echo - **App Icon Generator**: https://appicon.co >> assets\ICON_README.md
echo - **Icon Kitchen**: https://icon.kitchen >> assets\ICON_README.md
echo - **MakeAppIcon**: https://makeappicon.com >> assets\ICON_README.md
echo - **Icon Generator**: https://icon-generator.net >> assets\ICON_README.md

echo.
echo ✅ 图标文件说明已创建: assets\ICON_README.md
echo.
echo 📋 接下来需要:
echo 1. 使用设计工具制作主图标 (1024x1024px)
echo 2. 使用在线工具生成多尺寸版本
echo 3. 将图标文件放入 assets 目录
echo.
echo 🎨 推荐使用 Figma 或 Canva 进行图标设计
echo 🌐 推荐使用 App Icon Generator 生成多尺寸版本
echo.
pause
