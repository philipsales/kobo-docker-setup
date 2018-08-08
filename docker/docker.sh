#clean the staging artificsts
sudo rm -rf /docker-volumes/

#check the certificates
sudo docker run -it --rm \
-v /docker-volumes-stage/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes-stage/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /root/kobo-docker/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v /docker-volumes-stage/var/log/letsencrypt:/var/log/letsencrypt \
certbot/certbot \
-- staging \
certificates

#run the production
sudo docker run -it --rm \
-v /docker-volumes-stage/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes-stage/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /root/kobo-docker/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v /docker-volumes-stage/var/log/letsencrypt:/var/log/letsencrypt \
certbot/certbot \
certonly --webroot \
--email philip@alliedworld.healthcare --agree-tos --no-eff-email \
--webroot-path=/data/letsencrypt \
-d aqm.space -d www.aqm.space -d ee.aqm.space -d kc.aqm.space -d kpi.aqm.space

#close container
docker-compose down

#use the generated certificates to run in the production
