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

git clone https://github.com/gSpotx2f/luci-app-cpu-status package/luci-app-cpu-status
git clone https://github.com/gSpotx2f/luci-app-cpu-perf package/luci-app-cpu-perf
git clone https://github.com/gSpotx2f/luci-app-interfaces-statistics package/luci-app-interfaces-statistics
git clone https://github.com/gSpotx2f/luci-app-temp-status package/luci-app-temp-status
git clone https://github.com/muink/luci-app-tn-netports package/luci-app-tn-netports

rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome

git clone https://github.com/OneNAS-space/luci-app-adguardhome package/luci-app-adguardhome

git clone https://github.com/zow2023/InfinityDuck package/new/InfinityDuck
git clone https://github.com/zow2023/openwrt_helloworld package/helloworld
rm -rf package/helloworld/dae

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
sed -i 's/OpenWrt/W6-WRT/g' package/base-files/files/bin/config_generate
