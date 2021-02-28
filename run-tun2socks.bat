@echo off
@setlocal EnableDelayedExpansion
cd /d "%~dp0"

::--- need config ---
:: to check interface index run> netsh int ipv4 show interfaces "Wi-Fi"
:: or change Wi-Fi to your interface name
set gwIP=XXX.XXX.XXX.XXX
set gwIndex=X
set proxyIp=XXX.XXX.XXX.XXX
set tapName=tap4socks

::--- set ip to text ---
(
    echo 0.0.0.0/1
    echo 128.0.0.0/1
)>"4-subnet.txt"

::--- TAP setup ---
netsh interface ip set address %tapName% static 10.0.0.2 255.255.255.0
netsh int ipv4 set dns name=%tapName% static 127.0.0.1 primary validate=no
set tapIp=10.0.0.1

::--- run tun2sock ---
:: if use old driver > --tundev "tap0901:tap4socks:..."
start /min cmd /c "tun2socks --tundev "root\tap0901:tap4socks:10.0.0.2:10.0.0.0:255.255.255.0" --netif-ipaddr 10.0.0.1 --netif-netmask 255.255.255.0 --socks-server-addr 127.0.0.1:1080 --socks5-udp --udp-relay-addr 127.0.0.1:1080 --loglevel none"
timeout /t 2 > nul

::--- run config ---
for /F "tokens=*" %%a in ('type 4-subnet.txt') do ( netsh interface ipv4 add route %%a nexthop=%tapIp% interface=%tapName% metric=0 store=active )
netsh interface ipv4 add route %proxyIp%/32 nexthop=%gwIp% interface="%gwIndex%" metric=0 store=active

cls
echo [--running--]
echo Press any key to stop and remove config
pause

:::--- stop tun2sock ---
taskkill /IM "tun2socks.exe" /F

::--- del config ---
for /F "tokens=*" %%a in ('type 4-subnet.txt') do ( netsh interface ipv4 delete route %%a interface=%tapName% )
route delete %proxyIp%

::pause
