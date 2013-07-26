/*
 * name: checkAvailable
 * @return alert if not requirements are allowed
 * @author PICCORO Lenz McKAY <mckaygerhard@gmail.com>
 */


function getIExplosion()
{
	var rv = -1;
	var ua = navigator.userAgent;
	if (navigator.appName == 'Microsoft Internet Explorer')
	{
		var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null)
		rv = parseFloat( RegExp.$1 );
	}
	else if (navigator.appName != 'Microsoft Internet Explorer')
	{
		rv = navigator.userAgent; // TODO nav dec
	}
	return rv;
}
function checkAvailable()
{
	var msg = "Error: download: IceWeasel , Chrome/chromium, Safari or Opera";
	var ver = getIExplosion();
	if ( ver > -1 )
	{
		if ( ver >= 9.0 )
			msg = "Usted esta usando un navegador ineficiente, en un sistema operativo no seguro. Actualize a chromium o Iceweasel."
		alert( msg );
	}
}

