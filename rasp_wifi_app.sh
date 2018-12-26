#!/bin/bash
#create 30/06/2018
#run in raspian 
#https://frillip.com/using-your-raspberry-pi-3-as-a-wifi-access-point-with-hostapd/

#mantein commented if you using NOOB
#sudo raspi-config  
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install dnsmasq hostapd

wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/dhcpcd.conf
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/interfaces
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/hostapd.conf
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/hostapd
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/hostapd1
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/dnsmasq.conf
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/sysctl.conf
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/rc.local
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/rasp_wifi_revert.sh

mkdir bkp
cp rasp_wifi_revert.sh bkp
sudo cp /etc/dhcpcd.conf bkp
sudo cp /etc/network/interfaces bkp
sudo cp /etc/hostapd/hostapd.conf bkp
sudo cp /etc/default/hostapd bkp
sudo cp /etc/init.d/hostapd bkp
sudo cp /etc/dnsmasq.conf bkp
sudo cp /etc/sysctl.conf bkp
sudo cp /etc/rc.local bkp

sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE  
sudo iptables -A FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT  
sudo iptables -A FORWARD -i wlan1 -o wlan0 -j ACCEPT  
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

sudo cp dhcpcd.conf /etc/dhcpcd.conf
sudo cp interfaces /etc/network/interfaces
sudo cp hostapd.conf /etc/hostapd/hostapd.conf
sudo cp hostapd /etc/default/hostapd
sudo cp hostapd1 /etc/init.d/hostapd
sudo cp dnsmasq.conf /etc/dnsmasq.conf
sudo cp sysctl.conf /etc/sysctl.conf
sudo cp rc.local /etc/rc.local

sudo apt-get install iptables-persistent
sudo systemctl enable netfilter-persistent

sudo shutdown -r 00
