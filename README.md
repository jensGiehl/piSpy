# Pi Spy [GER]
## Was finde ich hier?
Mit meinem Raspberry Pi 3 möchte ich von diversen Webseiten regelmäßg einen Screenshot erstellen.
Sobald eine Änderung festgestellt wird, möchte ich per E-Mail informiert werden.

## Notwendige Software
### PhantomJS
Zunächst muss *phantomJs* installiert werden. Da das offizielle Release nicht für ARM Prozessoren 
funktioniert, muss man wie folgt vorgehen:
1. `git clone https://github.com/piksel/phantomjs-raspberrypi.git`
2. `sudo ln -s /home/pi/phantomjs-raspberrypi/bin/phantomjs /bin/phantomjs`

### ImageMagick
Um Bilder vergleichen zu können, verwende ich *ImageMagick*, was sich wie folgt installieren lässt:
`sudo apt-get install imagemagick`


## Verwenden
Zunächst muss eine Datei angelegt werden, in dem folgende Informationen getrennt mit einem `;` enthalten sind:
1. Name (wird als Ordnername verwendet)
2. URL die aufgerufen werden soll

Das Skript `takeScreenshots.sh` muss mit zwei Parametern aufgerufen werden:
1. Datei die gelesen werden soll (hier stehen die URLs drin)
2. Pfad in dem die Screenshots gespeichert werden sollen


### Beispiel
#### urls.csv
```
GitHub;https://github.com/
Heise;https://www.heise.de/
```

#### Aufruf
```./takeScreenshots.sh urls.csv /home/pi/screenshots```



## WLAN Tipp
Sollte das WLAN nicht stabil sein, dann versucht es mal mit einem Firmware Update: `sudo rpi-update`


## Tipp um fehlerhafte Bilder zu löschen
Manchmal (wenn z.B. keine Internetverbindung besteht) wird ein schwarzer Screenshot erstellt. Diese Dateien
kann man mit folgendem Befehl löschen:
```
sudo find .  -type f -name "*.png" -size 8151c -delete
```


## Tipp um Bilder zu zählen
Du möchtest deine erstellten Screenshots zählen, dann nutze folgenden Befehl:
```
find . -name "*.png" | grep -v "diff" |wc -l
```
