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

#git clone https://github.com/kiddin9/luci-app-dnsfilter package/luic-app-dnsfilter
#git clone https://github.com/sirpdboy/luci-app-parentcontrol package/luci-app-parentcontrol
#git clone https://github.com/4IceG/luci-app-timecontrol package/luci-app-timecontrol

#git clone https://github.com/xiaoxiao29/luci-app-adguardhome package/luci-app-adguardhome
#git clone https://github.com/TanZhiwen2001/luci-app-adguardhome package/luci-app-adguardhome

# git clone https://github.com/sbwml/luci-app-filemanager package/luci-app-filemanager

##git clone https://github.com/brvphoenix/luci-app-wrtbwmon package/luci-app-wrtbwmon

git clone https://github.com/gSpotx2f/luci-app-cpu-status package/luci-app-cpu-status
git clone https://github.com/gSpotx2f/luci-app-cpu-perf package/luci-app-cpu-perf
git clone https://github.com/gSpotx2f/luci-app-interfaces-statistics package/luci-app-interfaces-statistics
git clone https://github.com/gSpotx2f/luci-app-temp-status package/luci-app-temp-status
git clone https://github.com/muink/luci-app-tn-netports package/luci-app-tn-netports
#git clone https://github.com/muink/luci-app-tinyfilemanager package/luci-app-tinyfilemanager

# 移除 openwrt feeds 自带的核心包
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome

#rm -rf feeds/luci/applications/luci-app-dae
#rm -rf feeds/luci/applications/luci-app-daed
rm -rf feeds/luci/applications/luci-app-homeproxy
#rm -rf feeds/packages/net/{dae,daed}

git clone https://github.com/OneNAS-space/luci-app-adguardhome package/luci-app-adguardhome

git clone https://github.com/gaobin89/luci-app-timecontrol package/luci-app-timecontrol
#git clone https://github.com/w9315273/luci-app-adguardhome package/luci-app-adguardhome

#git clone https://github.com/immortalwrt/homeproxy package/luci-app-homeproxy
#git clone https://github.com/QiuSimons/vmlinux-btf package/vmlinux-btf

#git clone https://github.com/zow2023/luci-app-dae package/dae
#git clone https://github.com/QiuSimons/luci-app-dae -b kix package/dae

git clone https://github.com/zow2023/InfinityDuck package/new/InfinityDuck
git clone https://github.com/zow2023/openwrt_helloworld package/helloworld
rm -rf package/helloworld/luci-app-dae
rm -rf package/helloworld/luci-app-daed
rm -rf package/helloworld/dae
#rm -rf package/helloworld/shadowsocksr-libev

# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

#rm -rf feeds/packages/net/smartdns
#rm -rf feeds/luci/applications/luci-app-smartdns  
#git clone https://github.com/zow2023/openwrt-smartdns feeds/packages/net/smartdns
#git clone https://github.com/pymumu/openwrt-smartdns feeds/packages/net/smartdns
#git clone https://github.com/pymumu/luci-app-smartdns feeds/luci/applications/luci-app-smartdns 

#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-theme-argon-config
# git clone https://github.com/muink/openwrt-einat-ebpf.git package/einat-ebpf
# git clone https://github.com/muink/luci-app-einat.git package/luci-app-einat

rm -rf feeds/packages/lang/node
#git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt -b packages-23.05 feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt -b packages-24.10 feeds/packages/lang/node

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

# Modify default IP
sed -i 's/192.168.15.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/E8450/g' package/base-files/files/bin/config_generate
