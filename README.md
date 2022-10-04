# VPN_redirect
redirect traffic based on geoIP

## Requirment

**iproute2**
**iptables**
**xtables-addons**

 ## How it's Work

 
1. Connect to any vpn and use vpn as a default gateway
2. create a new routing table with iproute2 
3. use your actual gateway (ip that connected directly to router) as a default gateway in new routing table 
4. add new ip rule with forward mark like (ip rule add from all fwmark 0x10000/0xff0000 lookup <<name of your new routing table>>)
5. now install xtables-addons for iptables-geoip module
6. create IR.iv4 and IR.iv6 with xtables-addones or just download these files at this repo and copy it at /user/share/xt_geoip/LE (based on your hardware LE can change to BE. on openwrt you just forget about BE and LE and cope these files on /user/share/xt_geoip).
7. We use iptables to mark packets that are destined for Iran. iptables -t mangle -A PREROUTING -m geoip --destination-country IR  -j MARK --set-xmark 0x10000/0xff0000 && iptables -t nat -A PREROUTING -m geoip --destination-country IR  -j MARK --set-xmark 0x10000/0xff0000 (for some unknow resounse I should mark them in mangle and nat in openwrt but I think mangle is enough)

after doing above steps, your network seperates based on destination ip and your IR traffic going directly from your main gateway and not vpn.