##
## basic-default-configuration-to-execute-after-reset
## author: Great D Dilla
## https://github.com/dillagr/mikrotik-ansible
##
## NOTES: tested on Mirktok RB750Gr3 (hEX) and Mikrotik RBD52uG (hAP AC^2)

## delay.. to ensure Mikrotik has booted
## without this, it's hit or miss (more miss)
/delay delay-time=15s


## time, is important
/system clock set time-zone-name=Asia/Manila
/ip cloud set ddns-enabled=yes ddns-update-interval=1h


## bridge-interfaces
/interface bridge add add-dhcp-option82=yes admin-mac=00:0C:29:1E:FF:52 auto-mac=no comment=defconf \
    dhcp-snooping=yes name=bridge
/interface bridge add comment=router-id disabled=yes name=lo1
## add-physical-interfaces, scripted since we don't know how many ethernet ports the device has
:foreach id in=[/interface ethernet find] do={ 
    :local iface [/interface ethernet get $id name]; 
    if ( "$iface" != "ether1" ) do={ /interface bridge port add bridge=bridge interface=$iface }
    }



## WAN interface, ether1
/ip dhcp-client add comment=defconf interface=[ /interface ethernet find default-name=ether1 ] 
/ip address add disabled=yes address=192.168.1.11/24 comment=LAN \
    interface=[ /interface ethernet find default-name=ether1 ] network=192.168.1.0


## DNS
/ip dns set allow-remote-requests=yes cache-max-ttl=1h cache-size=4096KiB \
    max-concurrent-queries=512 max-concurrent-tcp-sessions=512 servers=8.8.4.4,1.1.1.1


## WAN
/ip address add address=10.11.1.1/24 comment=bridge interface=bridge network=10.11.1.0


## dhcp-server, on bridge-interface
/ip dhcp-server config set store-leases-disk=never
/ip dhcp-server network add address=10.11.1.0/24 comment=10-DOT-11 \
    dns-server=10.11.1.1,1.0.0.1,1.1.1.1 gateway=10.11.1.1 netmask=24

/ip pool add comment=DOT11 name=DOT11 ranges=10.11.1.11-10.11.1.49
/ip dhcp-server add add-arp=yes address-pool=DOT11 always-broadcast=yes disabled=no interface=bridge \
    lease-time=2h name=DHCP11