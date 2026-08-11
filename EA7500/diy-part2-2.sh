#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
git clone  https://github.com/zow2023/openwrt_helloworld package/helloworld

# Modify default IP 
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修正 MIPS 下 Sing-Box 的编译环境变量
# 强制让编译工具链使用更稳定的指令集对齐
#!/bin/bash

# -----------------強制給予 uci-defaults 腳本執行權限，防止雲端編譯權限丟失-------------------------
chmod +x files/etc/uci-defaults/99-physical-sovereignty

#------------------替换GoLang-----------------------
echo '替换golang到1.26x'
rm -rf feeds/packages/lang/golang
git clone -b 26.x --single-branch https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
echo '=========Replace golang OK!========='


# 1. 强制重写全局编译参数，针对 MT7621 (MIPS 1004Kc/74kc) 深度优化
sed -i 's/-O2/-O3 -march=mipsel -mtune=74kc -mdsp -mno-mips16 -fno-caller-saves/g' include/target.mk

# 2. 优化特定的编译器标志，减少延迟
sed -i 's/TARGET_CFLAGS:=/TARGET_CFLAGS:=-O3 -march=mipsel -mtune=74kc -mdsp -mno-mips16 -falign-functions=32 -fno-caller-saves -fomit-frame-pointer -pipe /g' include/target.mk

# =========================================================
# 强制关闭 sing-box 及 Go 编译器的 CGO (解决 MIPS 汇编报错)
# =========================================================

# 1. 自动查找所有 sing-box 的 Makefile 并强制关闭 CGO
find feeds/ package/ -type f -path "*/sing-box/Makefile" 2>/dev/null | while read -r file; do
    echo "正在修复 sing-box Makefile: $file"
    # 将现有的 CGO 开关全部替换为 0
    sed -i 's/GO_PKG_CGO_ENABLED:=1/GO_PKG_CGO_ENABLED:=0/g' "$file"
    sed -i 's/GO_PKG_CGO_ENABLED:=true/GO_PKG_CGO_ENABLED:=false/g' "$file"
    sed -i 's/CGO_ENABLED=1/CGO_ENABLED=0/g' "$file"
    # 确保追加全局禁用变量
    sed -i '/include $(TOPDIR)\/rules.mk/a GO_PKG_CGO_ENABLED:=0' "$file"
done

# 2. 修改 OpenWrt 的 Golang 打包基类 (golang-package.mk)，彻底禁用默认 CGO
find feeds/ package/ -type f -name "golang-package.mk" 2>/dev/null | while read -r file; do
    echo "正在修复 Golang 全局配置: $file"
    sed -i 's/GO_PKG_CGO_ENABLED:=1/GO_PKG_CGO_ENABLED:=0/g' "$file"
done
