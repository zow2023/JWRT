# 移除 openwrt feeds 自带的核心包
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome
#git clone https://github.com/kenzok78/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/OneNAS-space/luci-app-adguardhome package/luci-app-adguardhome
#git clone https://github.com/w9315273/luci-app-adguardhome package/luci-app-adguardhome

rm -rf feeds/luci/applications/luci-app-dae
rm -rf feeds/luci/applications/luci-app-daed
rm -rf feeds/luci/applications/luci-app-homeproxy
rm -rf feeds/packages/net/{dae,daed}

git clone https://github.com/gaobin89/luci-app-timecontrol package/luci-app-timecontrol

git clone https://github.com/zow2023/InfinityDuck package/new/InfinityDuck
git clone https://github.com/zow2023/openwrt_helloworld package/helloworld
rm -rf package/helloworld/luci-app-dae
#rm -rf package/helloworld/luci-app-daed
rm -rf package/helloworld/dae

rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node -b packages-25.12 feeds/packages/lang/node

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/E8450/g' package/base-files/files/bin/config_generate
