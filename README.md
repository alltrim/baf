### Публікація бази
```bash
mkdir /var/www/test
```
```bash
/opt/BAF/x86_64/8.3.19.1529/webinst -apache24 -wsdir test -dir /var/www/test -connstr "Srvr=localhost;Ref=test;" -confPath /etc/apache2/apache2.conf
```
