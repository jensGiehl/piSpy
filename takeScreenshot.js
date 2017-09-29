var page = require('webpage').create();
var system = require('system');

var d = new Date();
var now = d.getFullYear() + "-" + ("0"+(d.getMonth()+1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2) + "_" + ("0" + d.getHours()).slice(-2) + ("0" + d.getMinutes()).slice(-2); 

if (system.args.length != 4) {
	console.log('Invalid arguments!  1. argument = URL, 2. argument = Filename for PNG, 3. argument=MOBILE/DESKTOP');
	phantom.exit();
} else {
	url = system.args[1];
	imgFile = system.args[2];
	agent = system.args[3];

	if (agent == 'MOBILE') {
		page.settings.userAgent = 'Mozilla/5.0 (Android; Mobile; rv:14.0) Gecko/14.0 Firefox/14.0';
	} else {
		page.settings.userAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
		page.viewportSize = {
			width: 1920,
			height: 1080
		}
	}

	console.log('Open URL: ' , url);

	page.open(url, function() {
		filename = imgFile +  now + '.png';
		page.render(filename);
		console.log('Screenshot taken: ' + filename);
		phantom.exit();
	});
}
