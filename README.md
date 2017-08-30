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
Beispiel:
```phantomjs takeScreenshot.js https://www.github.com /home/pi/screenshots/github/home DESKTOP```
bzw.:
```phantomjs takeScreenshot.js https://www.github.com /home/pi/screenshots/github/home MOBILE```



## WLAN Tipp
Sollte das WLAN nicht stabil sein, dann versucht es mal mit einem Firmware Update: `sudo rpi-update`
