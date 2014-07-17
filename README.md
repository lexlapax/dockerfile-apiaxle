dockerfile-apiaxle
==================

docker containerized api-axle w nodejs, redis
api-axle is available at http://apiaxle.com/

This image is an all in one redis, nodejs, apiaxle image, all run by supervisord. Also includes sshd run via supervisord

This images should be available at the public docker index as lapax/apiaxle.

run with 

```docker run -d --name somename lapax/apiaxle```

you should be able to login via ssh using root and the password in the dockerfile

If running docker in an SELinux enabled system, logging into sshd will be denied by SELinux - for now, disabling selinux will work, putting it in permissive mode will not .. see https://bugzilla.redhat.com/show_bug.cgi?id=1085081 

If you are running in an SELINUX enabled system, one alternative is to run the container in an interactive shell and manually run supervisord (in daemon mode)

```shell
docker run -t -i --name apigateway lapax/apiaxle /bin/bash
# once in the shell run
supervisord
```

which will start the redis service and the api-proxy service and get you back to the command line.

To quickly test if the supervisord runs the services, you can always run superisord with a -n flag which will run it in foreground mode 


Once logged in and the services are started, you can start playing around with it as documented by the apiaxle folks at http://apiaxle.com/docs/try-it-now/ 


This image is for development purposes.. For production purposes, the services can be split out and a front-end load-balancer added, all running via linked docker containers.. 
