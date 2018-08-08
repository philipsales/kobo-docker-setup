
cd /root/kobo-docker/letsencrypt

#run the nginx container
docker-compose up -d

#run the nginx container letsencrypt staging
sudo docker run -it --rm \
-v /docker-volumes-stage/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes-stage/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /root/kobo-docker/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v /docker-volumes-stage/var/log/letsencrypt:/var/log/letsencrypt \
certbot/certbot \
certonly --webroot \
--register-unsafely-without-email --agree-tos \
--webroot-path=/data/letsencrypt \
--staging \
-d aqm.space -d www.aqm.space -d ee.aqm.space -d kc.aqm.space -d kpi.aqm.space
