# Repo Mirror Switcher (luci-app-repomirror)

一个为 OpenWrt 25.12+ 系统设计的轻量级软件源（换源）管理插件，采用全新 JavaScript-LuCI 框架编写。

由于 OpenWrt 25.12 彻底将包管理器从 `opkg` 升级为了 `apk`，传统的换源插件已无法兼容。本插件针对新版的 `apk` 包管理器和仓库配置文件路径进行了深度适配。

---

## 🌟 主要功能

- **新版系统完美兼容**：适配 OpenWrt 25.12+ 及 `apk` 包管理器。
- **自动匹配 CPU 架构**：采用域名替换法，自动继承您路由器当前的 CPU 架构和系统版本，无需手动选择。
- **无感安全滚动发布**：每次提交代码或手动触发编译，Actions 会自动更新 Release 供他人下载。
- **防呆自愈机制**：首次启用换源时会自动备份您的原始仓库配置。在禁用插件或镜像源配置异常时，支持一键恢复初始源，防止软件源永久性损毁。
- **智能架构重构**：若系统原始的 `/etc/apk/repositories.d/distfeeds.list` 损坏或丢失，插件将自动读取系统的芯片环境信息并全新重写。
- **无感多国语言**：原生适配 OpenWrt 系统语言，系统语言为中文时自动显示中文，系统为英文时自动回退。
- **低资源消耗**：基于客户端 JavaScript 渲染，无后台守护进程，零内存开销。

---

## 🚀 支持的镜像源

插件目前支持一键切换至以下国内主流高带宽镜像站：
- 🇨🇳 **清华大学开源软件镜像站 (TUNA)**
- 🇨🇳 **中国科学技术大学开源镜像站 (USTC)**
- 🇨🇳 **阿里云开源镜像站**
- 🇨🇳 **腾讯云开源镜像站**

---

## 📦 安装方法

本插件包含主程序与中文包，架构为 `all` 通用架构，可运行于 x86_64、ARM、MIPS、RISC-V 等所有 CPU 上。

### 1. 下载安装包
在本项目主页右侧的 **Releases**（或 Actions 运行历史的 Artifacts）中，下载以下两个 `.apk` 文件：
* `luci-app-repomirror_x.x.x-x_all.apk`
* `luci-i18n-repomirror-zh-cn_x.x.x-x_all.apk`

### 2. 通过 SSH 安装
将下载的文件上传到路由器的 `/tmp` 目录中，在 SSH 终端中执行以下命令（新系统需使用 `apk` 指令）：

```bash
# 安装插件及中文包（由于为本地未签名包，需添加 --allow-untrusted 允许安装）
apk add --allow-untrusted /tmp/luci-app-repomirror*.apk /tmp/luci-i18n-repomirror-zh-cn*.apk

# 清理 LuCI 后台缓存，强制重新读取菜单
rm -rf /tmp/luci-indexcache
