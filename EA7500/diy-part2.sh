#git clone https://github.com/4IceG/luci-app-timecontrol package/luci-app-timecontrol

# git clone https://github.com/sbwml/luci-app-filemanager package/luci-app-filemanager
#git clone https://github.com/muink/luci-app-tinyfilemanager package/luci-app-tinyfilemanager

git clone https://github.com/gSpotx2f/luci-app-cpu-status package/luci-app-cpu-status
#git clone https://github.com/gSpotx2f/luci-app-cpu-perf package/luci-app-cpu-perf
git clone https://github.com/gSpotx2f/luci-app-interfaces-statistics package/luci-app-interfaces-statistics
#git clone https://github.com/gSpotx2f/luci-app-temp-status package/luci-app-temp-status
git clone https://github.com/muink/luci-app-tn-netports package/luci-app-tn-netports

# 移除 openwrt feeds 自带的核心包
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,v2ray-plugin,xray-plugin,geoview,shadow-tls}
rm -rf feeds/luci/applications/luci-app-passwall

#git clone https://github.com/OneNAS-space/luci-app-adguardhome package/luci-app-adguardhome

#git clone https://github.com/gaobin89/luci-app-timecontrol package/luci-app-timecontrol
#git clone https://github.com/w9315273/luci-app-adguardhome package/luci-app-adguardhome

git clone https://github.com/zow2023/openwrt_helloworld package/helloworld

# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt -b packages-24.10 feeds/packages/lang/node

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# OpenWrt 24.10 精确修改 mac80211.uc 默认开启无线
#sed -i 's/\${defaults ? 0 : 1}/0/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/W6-WRT/g' package/base-files/files/bin/config_generate
echo "CONFIG_CCACHE=y" >> .config
