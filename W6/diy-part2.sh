#!/bin/bash
#

FILE="target/linux/mediatek/filogic/base-files/etc/hotplug.d/ieee80211/11_fix_wifi_mac"
if [ -f "$FILE" ]; then
    sed -i 's/mmc_get_mac_ascii u-boot-env 2gMAC/mmc_get_mac_ascii u-boot-env U2gMAC/' "$FILE"
    echo ">>> Predator W6: fixed 2.4G MAC variable 2gMAC -> U2gMAC"
else
    echo ">>> ERROR: $FILE not found!"
    exit 1
fi

git clone https://github.com/VizzleTF/luci-theme-footstrap package/luci-theme-footstrap
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}

rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome
git clone https://github.com/zow2023/luci-app-adguardhome package/luci-app-adguardhome
rm -rf package/luci-app-adguardhome/patches

git clone https://github.com/zow2023/InfinityDuck package/new/InfinityDuck
git clone https://github.com/zow2023/luci-app-honk package/honk
git clone https://github.com/zow2023/luci-app-meow package/meow

git clone https://github.com/zow2023/openwrt_helloworld package/helloworld
rm -rf package/helloworld/luci-app-dae
rm -rf package/helloworld/luci-app-daed
rm -rf package/helloworld/mihomo-alpha
rm -rf package/helloworld/luci-app-ssr-plus

rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node -b packages-25.12 feeds/packages/lang/node

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 27.x feeds/packages/lang/golang

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/W6-WRT/g' package/base-files/files/bin/config_generate

echo "CONFIG_DEVEL=y" >> .config
echo "CONFIG_CCACHE=y" >> .config
