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

git clone https://github.com/gSpotx2f/luci-app-cpu-status package/luci-app-cpu-status
git clone https://github.com/gSpotx2f/luci-app-interfaces-statistics package/luci-app-interfaces-statistics
git clone https://github.com/gSpotx2f/luci-app-temp-status package/luci-app-temp-status
git clone https://github.com/muink/luci-app-tn-netports package/luci-app-tn-netports
#git clone https://github.com/gSpotx2f/luci-app-cpu-perf package/luci-app-cpu-perf

rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome
git clone https://github.com/zow2023/luci-app-adguardhome.git package/luci-app-adguardhome
rm -rf package/luci-app-adguardhome/patches

git clone https://github.com/VizzleTF/luci-theme-footstrap package/luci-theme-footstrap
git clone https://github.com/zow2023/luci-app-meow package/meow
git clone https://github.com/zow2023/InfinityDuck package/new/InfinityDuck
git clone https://github.com/zow2023/luci-app-honk package/honk

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
sed -i 's/192.168.15.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# OpenWrt 24.10 精确修改 mac80211.uc 默认开启无线
sed -i 's/\${defaults ? 0 : 1}/0/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 解除 5G/6G 频宽 80MHz 硬性限制，允许 160MHz
FILE_WIFI="package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc"
if [ -f "$FILE_WIFI" ]; then
    # 删除强制 80MHz 截断的两行
    sed -i '/else if (width > 80)/,+1d' "$FILE_WIFI"
    echo ">>> Removed 80MHz width cap in mac80211.uc"
fi

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/W6-WRT/g' package/base-files/files/bin/config_generate

CFG=package/base-files/files/bin/config_generate
# 修改 timezone
sed -i "s/option timezone 'UTC'/option timezone 'CST-8'/g" $CFG
sed -i "s/set system.@system\[-1\]\.timezone='UTC'/set system.@system[-1].timezone='CST-8'/g" $CFG
# 添加 zonename（避免重复添加）
grep -q "zonename='Asia/Shanghai'" $CFG || \
sed -i "/set system.@system\[-1\]\.timezone='CST-8'/a\        set system.@system[-1].zonename='Asia/Shanghai'" $CFG

echo "CONFIG_DEVEL=y" >> .config
echo "CONFIG_CCACHE=y" >> .config

# Predator W6: 禁用 WED，修复 5GHz (mt798x-wmac) 无法获取 IP 问题
FILE_WED="target/linux/mediatek/dts/mt7986a-acer-w6-common.dtsi"
if [ -f "$FILE_WED" ]; then
    if ! grep -q 'diy-disable-wed' "$FILE_WED"; then
        cat >> "$FILE_WED" << 'EOF'

/* diy-disable-wed: disable WED, fix 5G DHCP issue */
&wed0 {
	status = "disabled";
};

&wed1 {
	status = "disabled";
};
EOF
        echo ">>> Predator W6: WED disabled (wed0/wed1 -> disabled)"
    else
        echo ">>> Predator W6: WED patch already applied, skip"
    fi
else
    echo ">>> ERROR: $FILE_WED not found!"
    exit 1
fi
