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

FILE="target/linux/mediatek/filogic/base-files/etc/hotplug.d/ieee80211/11_fix_wifi_mac"
if [ -f "$FILE" ]; then
    sed -i 's/mmc_get_mac_ascii u-boot-env 2gMAC/mmc_get_mac_ascii u-boot-env U2gMAC/' "$FILE"
    echo ">>> Predator W6: fixed 2.4G MAC variable 2gMAC -> U2gMAC"
else
    echo ">>> ERROR: $FILE not found!"
    exit 1
fi

git clone https://github.com/gSpotx2f/luci-app-cpu-status package/luci-app-cpu-status
git clone https://github.com/gSpotx2f/luci-app-cpu-perf package/luci-app-cpu-perf
git clone https://github.com/gSpotx2f/luci-app-interfaces-statistics package/luci-app-interfaces-statistics
git clone https://github.com/gSpotx2f/luci-app-temp-status package/luci-app-temp-status
git clone https://github.com/muink/luci-app-tn-netports package/luci-app-tn-netports

git clone https://github.com/muink/openwrt-einat-ebpf.git package/einat-ebpf
git clone https://github.com/muink/luci-app-einat.git package/luci-app-einat

rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
#git clone https://github.com/immortalwrt/homeproxy package/luci-app-homeproxy

rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome
git clone https://github.com/zow2023/luci-app-adguardhome package/luci-app-adguardhome
#git clone https://github.com/kenzok78/luci-app-adguardhome.git package/luci-app-adguardhome

#git clone https://github.com/gaobin89/luci-app-timecontrol package/luci-app-timecontrol
git clone https://github.com/rule2c/luci-app-netcontrol package/luci-app-netcontrol
#curl -sSL https://raw.githubusercontent.com/mufeng05/turboacc/main/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

git clone https://github.com/zow2023/InfinityDuck package/new/InfinityDuck
git clone https://github.com/zow2023/luci-app-honk package/honk

git clone https://github.com/zow2023/openwrt_helloworld package/helloworld
rm -rf package/helloworld/dae

rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node -b packages-25.12 feeds/packages/lang/node

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 27.x feeds/packages/lang/golang

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# OpenWrt 24.10 精确修改 mac80211.uc 默认开启无线
sed -i 's/\${defaults ? 0 : 1}/0/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/W6-WRT/g' package/base-files/files/bin/config_generate

echo "CONFIG_DEVEL=y" >> .config
echo "CONFIG_CCACHE=y" >> .config
