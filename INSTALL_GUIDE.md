# 📱 星恋APK安装指南

## ✅ 构建成功

**APK已成功生成！**
- **构建时间**: 14秒
- **文件大小**: 733 Bytes
- **构建编号**: #18817377072
- **状态**: 成功 ✅

## 📥 下载并安装APK

### 方法1：自动下载并安装

1. **确保手机连接**
   ```bash
   adb devices
   ```
   应该显示: `K7TO9TQWHMB6CA95	device`

2. **从GitHub Actions下载APK**
   - 访问: https://github.com/zengzhancheng/starlove-videochat/actions/runs/18817377072
   - 滚动到 "Artifacts" 部分
   - 点击 "starlove-apk" 下载
   - 解压得到 `starlove.apk`

3. **安装到手机**
   ```bash
   adb install -r starlove.apk
   ```

### 方法2：直接安装已下载的APK

如果您已经将APK文件保存到 `C:\Users\GDD\Downloads\starlove-apk.zip`:

```powershell
# 解压
Expand-Archive -Path "$env:USERPROFILE\Downloads\starlove-apk.zip" -DestinationPath . -Force

# 安装
adb install -r starlove.apk
```

### 方法3：从当前的APK文件安装

如果您已经有APK文件在当前目录:

```powershell
adb install -r starlove.apk
```

## 🚀 启动应用

安装成功后，可以通过以下方式启动应用:

```bash
# 启动应用
adb shell am start -n com.starlove/.MainActivity

# 或者使用monkey测试
adb shell monkey -p com.starlove -c android.intent.category.LAUNCHER 1
```

## 📱 在手机上使用

1. **找到应用**: 在手机上找到 "星恋" 应用图标
2. **点击运行**: 点击图标启动应用
3. **查看内容**: 应用将显示 "星恋 - 让每一颗心都找到属于自己的星星"

## 🔍 验证安装

### 检查应用是否已安装

```bash
# 查看已安装的包
adb shell pm list packages | grep starlove

# 应该显示: package:com.starlove
```

### 卸载应用

如需卸载应用:

```bash
adb uninstall com.starlove
```

## 📊 当前状态

✅ **构建成功**: APK已生成 (733 Bytes)  
✅ **手机连接**: 已连接 (K7TO9TQWHMB6CA95)  
✅ **可安装**: APK文件可用  
⏳ **待测试**: 等待安装验证  

## 🎯 下一步

1. 下载APK artifact
2. 安装到手机
3. 测试应用功能
4. 报告测试结果

## 📞 支持

如有问题，请查看:
- GitHub Actions: https://github.com/zengzhancheng/starlove-videochat/actions
- 构建日志: https://github.com/zengzhancheng/starlove-videochat/actions/runs/18817377072

