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


## Verwenden
Beispiel:
```phantomjs takeScreenshot.js https://www.github.com /home/pi/screenshots/github/home DESKTOP```
bzw.:
```phantomjs takeScreenshot.js https://www.github.com /home/pi/screenshots/github/home MOBILE```
