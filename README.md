### Публікація бази
```bash
mkdir /var/www/test
```
```bash
/opt/BAF/x86_64/8.3.19.1529/webinst -apache24 -wsdir test -dir /var/www/test -connstr "Srvr=localhost;Ref=test;" -confPath /etc/apache2/apache2.conf
```
#### Замінити вміст файлу
```bash
nano /var/www/test/default.vrd
```
```xml
<?xml version="1.0" encoding="UTF-8"?>
<point xmlns="http://v8.1c.ru/8.2/virtual-resource-system"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		base="/test"
		ib="Srvr=&quot;localhost&quot;;Ref=&quot;test&quot;;"
		enable="false">
	<debug enable="true"
			protocol="tcp"
			url=""/>
	<httpServices publishExtensionsByDefault="true">
		<service name="WAF_HTTP_SRVC"
				rootUrl="waf"
				enable="true"
				reuseSessions="dontuse"
				sessionMaxAge="20"
				poolSize="10"
				poolTimeout="5"/>
	</httpServices>
	<standardOdata enable="false"
			reuseSessions="autouse"
			sessionMaxAge="20"
			poolSize="10"
			poolTimeout="5"/>
	<analytics enable="false"/>
</point>
```
#### Перезапустити Apache
```bash
/etc/init.d/apache2 restart
```
