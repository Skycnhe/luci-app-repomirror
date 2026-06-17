#!/bin/sh

ENABLED=$(uci -q get repomirror.config.enabled)
MIRROR=$(uci -q get repomirror.config.mirror)

DISTFEEDS="/etc/apk/repositories.d/distfeeds.list"
BACKUP="/etc/apk/repositories.d/distfeeds.list.bak"

case "$MIRROR" in
    tsinghua) DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/openwrt" ;;
    ustc)     DOMAIN="https://mirrors.ustc.edu.cn/openwrt" ;;
    aliyun)   DOMAIN="https://mirrors.aliyun.com/openwrt" ;;
    tencent)  DOMAIN="https://mirrors.cloud.tencent.com/openwrt" ;;
    *)        DOMAIN="https://downloads.openwrt.org" ;;
esac

if [ -f "$BACKUP" ] || [ -f "$DISTFEEDS" ]; then
    if [ ! -f "$BACKUP" ]; then
        cp "$DISTFEEDS" "$BACKUP"
    fi

    if [ "$ENABLED" = "1" ]; then
        sed -E "s|https?://downloads.openwrt.org|$DOMAIN|g" "$BACKUP" > "$DISTFEEDS"
    else
        cp "$BACKUP" "$DISTFEEDS"
    fi
    exit 0
fi

if [ "$ENABLED" = "1" ] && [ -f "/etc/openwrt_release" ]; then
    . /etc/openwrt_release

    if [ -n "$DISTRIB_RELEASE" ] && [ -n "$DISTRIB_TARGET" ] && [ -n "$DISTRIB_ARCH" ]; then
        cat <<_EOF_ > "$DISTFEEDS"
# Rebuilt automatically by repomirror for $DISTRIB_ARCH ($DISTRIB_TARGET)
$DOMAIN/releases/$DISTRIB_RELEASE/targets/$DISTRIB_TARGET/packages/packages.adb
$DOMAIN/releases/$DISTRIB_RELEASE/packages/$DISTRIB_ARCH/base/packages.adb
$DOMAIN/releases/$DISTRIB_RELEASE/packages/$DISTRIB_ARCH/luci/packages.adb
$DOMAIN/releases/$DISTRIB_RELEASE/packages/$DISTRIB_ARCH/packages/packages.adb
$DOMAIN/releases/$DISTRIB_RELEASE/packages/$DISTRIB_ARCH/routing/packages.adb
$DOMAIN/releases/$DISTRIB_RELEASE/packages/$DISTRIB_ARCH/telephony/packages.adb
_EOF_
    fi
fi
