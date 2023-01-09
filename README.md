![Logo of the project](https://github.com/OriginalOrangeXD/gentooBridge/blob/main/penguin.png)

# Bridge Setup 
> My experence with setting up a bridged network on gentoo 

## Pre-req 

Basic things to have installed, and things to remove
```shell
sudo emerge --ask bridge-utils
sudo rc-update delete net.enp5s0
sudo rm /etc/init.d/net.enp5s0
```

1. The emerge will give you the tools you need to make things easier
2. rc-update and the rm command should ensure the interface can't be given an ip
    if still given ip address disable dhcpcd
        ```shell 
        sudo rc-service dhcpcd stop
        sudo rc-update del dhcpcd
        ```


### Initial Configuration

Modify /etc/conf.d/net with the configuration file provided
This file is responsible for the the initial network setup so after configuration
reboot the network with 
```shell
sudo rc-service net.br0 restart
```
NOTE: net.br0 must be located in /etc/init.d

## Application to Ubuntu VM

When install a Ubuntu VM the network will not work by default however these simple commands should fix it
```shell
sudo ip addr add 192.168.2.200/24 dev enp1s0
sudo ip link set dev enp1s0 up
sudo ip route add default via 192.168.2.1
```
This will:
1. Give the virtual ethernet card an ip address
2. Set the card as UP (activate)
3. Set routing info for packets
This should allow you to ping ip addresses and if that is all you need you should be able to stop here

### Ubuntu VM DNS configuration
The way I decided to configue my Virtual machine was to have a static ip address, I did this by creating a config file
/etc/netplan/99_config.yaml

The file is pretty straightforward setting an ip address, routing info, and the most important thing ....  NAMESERVERS
The config file is located in the netplan_config.yaml

After applying changes run 
```shell
sudo netplan apply
```

## Features

BOOM now you have got an awesome network where you can
* Use your computer to host multiple servers accessable by the host any any other machine on the network
* Seperate different parts of a web service and have them all be able to talk
* If you want to go crazy, you can setup a ROS bridge where different vms running different programs communicate aswell as different microcontrollers



## Links

A lot of the information given would not be possible if it weren't for the 
fantastic gentoo community forums, chatGPT and the Ubuntu pages

- Gentoo Bridged Network: https://wiki.gentoo.org/wiki/Network_bridge
- Gentoo DHCPCD: https://wiki.gentoo.org/wiki/Network_management_using_DHCPCD 
- Ubuntu network setup: https://ubuntu.com/server/docs/network-configuration 
- ChatGPT: https://chat.openai.com 
