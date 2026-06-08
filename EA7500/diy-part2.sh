#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#


#git clone https://github.com/4IceG/luci-app-timecontrol package/luci-app-timecontrol

# git clone https://github.com/sbwml/luci-app-filemanager package/luci-app-filemanager

#git clone https://github.com/muink/luci-app-tinyfilemanager package/luci-app-tinyfilemanager

# 移除 openwrt feeds 自带的核心包
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,v2ray-plugin,xray-plugin,geoview,shadow-tls}
rm -rf feeds/luci/applications/luci-app-passwall

#git clone https://github.com/OneNAS-space/luci-app-adguardhome package/luci-app-adguardhome

git clone https://github.com/gaobin89/luci-app-timecontrol package/luci-app-timecontrol
#git clone https://github.com/w9315273/luci-app-adguardhome package/luci-app-adguardhome

git clone https://github.com/zow2023/openwrt_helloworld package/helloworld

# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns  
git clone https://github.com/pymumu/openwrt-smartdns feeds/packages/net/smartdns
git clone https://github.com/pymumu/luci-app-smartdns feeds/luci/applications/luci-app-smartdns 

#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-theme-argon-config

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

# Modify default IP
sed -i 's/192.168.6.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/W6-WRT/g' package/base-files/files/bin/config_generate
