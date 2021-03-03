# tun2socks-cmd
cmd script to use tun2socks with shadowsocks.<br/>
this script for use with `dnscrypt-proxy` in tcp mode.
- install TAP driver by Device Manager > Add legacy hardware.
- remane TAP interface to `tap4socks` or what you want.
- edit gateway data and proxy ip in script.
- paste `*.bat` same directory as `tun2socks.exe`.
- run `Shadowsocks.exe`
- run `*.bat` as admin.

## other resource
__tun2socks__<br/>
https://github.com/ambrop72/badvpn<br/>
or `*.exe` from other folk.<br/>

__tap-windows__<br/>
https://github.com/OpenVPN/tap-windows6<br/>
or<br/>
https://build.openvpn.net/downloads/releases/<br/>

__Shadowsocks__<br/>
https://github.com/shadowsocks/shadowsocks-windows<br/>


## Outline Client
Client software running like my script.<br/>
but they send back telemetry data by sentry.io<br/>
and always connect to s3.amazonaws.com now sure why<br/>
it's always connection fail for me, no luck.<br/>
https://github.com/Jigsaw-Code/outline-client

## Why TAP not wintun driver ?
Please read > https://github.com/lessload/wireguard-windows--------------Big-Problem
