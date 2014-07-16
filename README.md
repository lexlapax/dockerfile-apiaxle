dockerfile-apiaxle
==================

docker containerized api-axle w nodejs, redis
api-axle is available at http://apiaxle.com/

This image is an all in one redis, nodejs, apiaxle image, all run by supervisord. Also includes sshd run via supervisord

This images should be available at the public docker index as lapax/apiaxle.

run with 
```docker run -d --name somename lapax/apiaxle```

you should be able to login via ssh using root and the password in the dockerfile

If running docker in an SELinux enabled system, logging into sshd will be denied by SELinux - for now, disabling selinux will work, putting it in permissive mode will not .. 
