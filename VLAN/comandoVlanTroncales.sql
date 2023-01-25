VLAN 5 - PERSONAL		-	172.16.5.0/24   puertos 3-10
VLAN 6 - GERENCIA		-	172.16.6.0/24   puertos 11-15
VLAN 7 -  INFORMATICA	-	172.16.7.0/24   
VLAN 8 - SERVIDORES		-	172.16.8.0/24
VLAN 9 - GESTION		-	172.16.9.0/24
VLAN 10 - TEMPORAL		-	172.16.10.0/24  puertos 2, 16-24 gi 0/1 gi 0/2



enable
configure terminal
no ip domain-lookup
hostname N1-SW
vlan 5
name personal
vlan 6
name gerencia
vlan 7
name informatica
vlan 8
name servidores
vlan 9
name gestion
vlan 10
name temporal

interface fast 0/1
description enlace troncal fast 0/1 hacia fast 0/1 N2-SW
switchport trunk encapsulation dot1q
switchport mode trunk

interface fast 0/2
description enlace troncal fast 0/2 hacia fast 0/1 N1-SW
switchport trunk encapsulation dot1q
switchport mode trunk


do show interface trunk

interface vlan 9
description IP de gestion de Switch de datacenter
ip address 172.16.9.2 255.255.255.0
do write
no shutdown
ip default-gateway 172.16.9.1
do write 
no shutdown




*******************************
enable
configure terminal
no ip domain-lookup
hostname N1-SW
vlan 5
name personal
vlan 6
name gerencia
vlan 7
name informatica
vlan 8
name servidores
vlan 9
name gestion
vlan 10
name temporal

interface fast 0/1
description enlace troncal fast 0/1 hacia fast 0/2 DATACENTER
switchport mode trunk

do show interface trunk

interface vlan 9
description IP de gestion de Switch de Nivel 1
ip address 172.16.9.3 255.255.255.0
do write
no shutdown
ip default-gateway 172.16.9.1
do write 
no shutdown

*******************************
enable
configure terminal
no ip domain-lookup
hostname N2-SW
vlan 5
name personal
vlan 6
name gerencia
vlan 7
name informatica
vlan 8
name servidores
vlan 9
name gestion
vlan 10
name temporal

interface fast 0/1
description enlace troncal fast 0/1 hacia fast 0/1 DATACENTER
switchport mode trunk

do show interface trunk

interface vlan 9
description IP de gestion de Switch de Nivel 2
ip address 172.16.9.4 255.255.255.0
do write
no shutdown
ip default-gateway 172.16.9.1
do write 
no shutdown

--Se asignan puertos para vlan

interface range fast 0/3-10
switchport mode access
switchport access vlan 5
description pc de personal
do write

interface range fast 0/11-15
switchport mode access
switchport access vlan 6
description pc de personal
do write

--Los puertos que no se usan se apagan

interface range fast 0/2, fast 0/16-24, gi 0/1-2
switchport mode access
switchport access vlan 10
description cambio a vlan temporal
do write
shutdown