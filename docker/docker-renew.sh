cd /kobo-docker/letsencrypt/

#manual
docker run --rm -it --name certbot \
-v /docker-volumes-stage/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes-stage/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /root/kobo-docker/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v /docker-volumes-stage/var/log/letsencrypt:/var/log/letsencrypt \
certbot/certbot 
renew --webroot 
-w /data/letsencrypt --quiet && docker kill 
--signal=HUP production-nginx-container


#cronjob
sudo crontab -e
0 23 * * * \
docker run --rm -it --name certbot \
-v /docker-volumes-stage/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes-stage/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /root/kobo-docker/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v /docker-volumes-stage/var/log/letsencrypt:/var/log/letsencrypt \
certbot/certbot 
renew --webroot 
-w /data/letsencrypt --quiet && docker kill 
--signal=HUP production-nginx-container
