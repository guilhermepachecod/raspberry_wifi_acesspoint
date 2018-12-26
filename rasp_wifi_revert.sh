#!/bin/bash
#create 30/06/2018
#run in raspian 
#https://frillip.com/using-your-raspberry-pi-3-as-a-wifi-access-point-with-hostapd/

#mantein commented if you using NOOB
#sudo raspi-config  
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install dnsmasq hostapd

cd bkp

sudo cp dhcpcd.conf /etc/dhcpcd.conf
sudo cp interfaces /etc/network/interfaces
sudo cp hostapd.conf /etc/hostapd/hostapd.conf
sudo cp hostapd /etc/default/hostapd
sudo cp dnsmasq.conf /etc/dnsmasq.conf
sudo cp sysctl.conf /etc/sysctl.conf
sudo cp rc.local /etc/rc.local


cd ..
rm -R bkp
rm rasp_wifi_app.sh
wget https://github.com/guilhermepachecod/raspberry_wifi_acesspoint/rasp_wifi_app.sh

sudo shutdown -r 00
