# Pi Spy [GER]
## Was finde ich hier?
Mit meinem Raspberry Pi 3 möchte ich von diversen Webseiten regelmäßg einen Screenshot erstellen.
Sobald eine Änderung festgestellt wird, möchte ich per E-Mail informiert werden.

## Notwendige Software
Zunächst muss *phantomJs* installiert werden. Da das offizielle Release nicht für ARM Prozessoren 
funktioniert, muss man wie folgt vorgehen:
1. `git clone https://github.com/piksel/phantomjs-raspberrypi.git`
2. `sudo ln -s /home/pi/phantomjs-raspberrypi/bin/phantomjs /bin/phantomjs`

## Nützliche Einstellungen
Damit der Raspberry Pi in den Ruhezeiten nicht das WLAN abschaltet (Power management), muss man noch
in der Datei `/etc/network/interfaces` am Ende noch folgende Zeile hinzufügen:
```wireless-power off```

## WLAN automatisch neu verbinden
Wenn der Router mal neu startet oder sonst wie das WLAN gestört ist, muss neu verbunden werden.
Dies kann man mit folgendem Skript (ausführbar machen):
```
#!/bin/bash

# The IP for the server you wish to ping (8.8.8.8 is a public Google DNS server)
SERVER=8.8.8.8

# Only send two pings, sending output to /dev/null
ping -c2 ${SERVER} > /dev/null

# If the return code from ping ($?) is not 0 (meaning there was an error)
if [ $? != 0 ]
then
    # Restart the wireless interface
    ifdown --force wlan0
    ifup wlan0
fi
```

Dies dann über einen Cronjob regelmäßig starten lassen:
```
*/5 *   * * *   root    /home/pi/screenshots/wifi_rebooter.sh
```

Quelle: http://alexba.in/blog/2015/01/14/automatically-reconnecting-wifi-on-a-raspberrypi/


## Verwenden
Beispiel:
```phantomjs takeScreenshot.js https://www.github.com /home/pi/screenshots/github/home DESKTOP```
bzw.:
```phantomjs takeScreenshot.js https://www.github.com /home/pi/screenshots/github/home MOBILE```
