include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for switching repo mirrors (APK)
LUCI_DEPENDS:=
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-repomirror
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
