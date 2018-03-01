#! /bin/bash
# vim: set tabstop=4 shiftwidth=4 expandtab condent:
 
readonly ORGANISATION="shanyuan"
readonly DOMAIN="17shanyuan.com"
readonly BASE_DN="17shanyuan.com"
readonly ADMIN_PASSWORD="admin"
readonly REPLICATION="true"
readonly CN = "admin"
readonly DC1="17shanyuan"
readonly DC2="com" 

docker run --hostname ldap.example.org \
--name ldap-service \
-v /data/ldap/data:/var/lib/ldap \
-v /data/ldap/sldap:/etc/ldap/slapd.d \
-p 389:389 \
-p 636:636 \
--env LDAP_ORGANISATION=${ORGANISATION} \
--env LDAP_DOMAIN=${DOMAIN} \
--env LDAP_ADMIN_PASSWORD=${ADMIN_PASSWORD} \
--env LDAP_BASE_DN=${BASE_DN} \
--env LDAP_REPLICATION=${REPLICATION} \
--detach \
osixia/openldap:latest
LDAP_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ldap-service)
 
#Create the second ldap server, save the container id in LDAP2_CID and get its IP:
docker run --hostname ldap2.example.org \
--name ldap-service2 \
-v /data/ldap2/data:/var/lib/ldap \
-v /data/ldap2/sldap:/etc/ldap/slapd.d \
--env LDAP_ORGANISATION=${ORGANISATION}  \
--env LDAP_DOMAIN=${DOMAIN} \
--env LDAP_ADMIN_PASSWORD=${ADMIN_PASSWORD} \
--env LDAP_BASE_DN=${BASE_DN} \
--env LDAP_REPLICATION=${REPLICATION} \
--detach \
osixia/openldap:latest
LDAP2_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ldap-service2)
 
#Add the pair "ip hostname" to /etc/hosts on each containers,
#because ldap.example.org and ldap2.example.org are fake hostnames
sleep 2
docker start ldap-service
docker start ldap-service2
 
LDAP_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ldap-service)
LDAP2_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ldap-service2)
docker exec ldap-service bash -c "echo $LDAP2_IP ldap2.example.org >> /etc/hosts"
docker exec ldap-service2 bash -c "echo $LDAP_IP ldap.example.org >> /etc/hosts"
 
docker run --name phpldapadmin-service \
--hostname phpldapadmin-service \
--link ldap-service:ldap-host \
--env PHPLDAPADMIN_LDAP_HOSTS="#PYTHON2BASH:[{'ldap.example.org': [{'server': [{'tls': True}]},{'login': [{'bind_id': 'cn=${CN},dc=${DC1},dc=${DC2}'}]}]},]" \
-p 7443:443 \
-p 780:80 \
--detach \
osixia/phpldapadmin:0.7.1