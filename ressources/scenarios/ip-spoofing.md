<!--
SPDX-FileCopyrightText: 2022 Bassam-Khaled Thiab <inf3891@hs-worms.de>
SPDX-FileCopyrightText: 2022 Dominic Meyer <inf3644@hs-worms.de>
SPDX-FileCopyrightText: 2022 Felix Rheinheimer <felix.rheinheimer@hs-worms.de>
SPDX-FileCopyrightText: 2022 Jean-Arole Fotsing <inf3608@hs-worms.de>
SPDX-FileCopyrightText: 2022 Katrin Vollhardt <inf3493@hs-worms.de>
SPDX-FileCopyrightText: 2022 Steve Landry Tchamabe <infXXXX@hs-worms.de>
SPDX-FileCopyrightText: 2022 Syed Saad-Ullah <inf3664@hs-worms.de>
SPDX-FileCopyrightText: 2022 Thierry-Junior Djeutchou-Njieyong <inf3494@hs-worms.de>

SPDX-License-Identifier: GPL-3.0-or-later
-->

Angriffsszenarien  

Szenario 1: IP-Spoofing 

Der Angreifer schickt eine oder mehrere Anfragen (Denial of Service) an einen Server. Als source-IP spooft er seine IP-Adresse und gibt die Ip-Adresse seines Opfers an.
-	Für diesen Angriff brauchen wir das Tool „Hping3“ << sudo apt install hping3 – y >>
-	Topologie: 3Container (1Container für den Angreifer, 1Container für den Opfer, 1Container für den Server) 
-	Für diesen Angriff benutzen Alpine Linux als Image aufgrund seiner Leistung und seines Gewichts.
 
Kommando: sudo hping3 -1 --flood -V -p 80 -a XXX.XXX.XXX XXX.XXX.XXX(target_ip)
	-a: für die gespoofte IP-Adresse
-1: Pakettyp (ICMP), für SYN-Pakete braucht man eher -S
--flood: schickt so viele Anfragen wie möglich (mehr als 1000 Pakete pro Sekunde)
-V: verbose
-p: Port
