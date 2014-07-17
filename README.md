dockerfile-apiaxle
==================

docker containerized api-axle w nodejs, redis

api-axle is available at http://apiaxle.com/

This image is an all in one redis, nodejs, apiaxle image, all run by supervisord. 

This images should be available at the public docker index as lapax/apiaxle.

run as daemon 
-------------

```docker run -d --name apigateway lapax/apiaxle```

Instead of looking for alternatives, my dev containers just used sshd to provide shell access.
ssh to a container was always a hack-job I thought, others think the same and have documented a more docker idiomatic way (see http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/)

This container now assumes you will use nsenter .. either compile your own nsenter or use jpetazzo's docker compiled nsenter (https://github.com/jpetazzo/nsenter)

and use nsenter to enter into the container 

```shell
# run on docker host
PID=$(docker inspect --format {{.State.Pid}} apigateway)
# use the pid to enter the namespace
sudo nsenter --target $PID --mount --uts --ipc --net --pid
```

run interactively 
-----------------

```shell
docker run -t -i --name apigateway lapax/apiaxle /bin/bash
# once in the shell run
supervisord
```

which will start the redis service and the api-proxy service and get you back to the command line.

To quickly test if the supervisord runs the services, you can always run superisord with a -n flag which will run it in foreground mode 

Once supervisord and the related services are running, you can detach from the container by issuing a ^p^q which will detach the tty from the container.

You can reattach to the container again with docker attach 'container id or name'


misc
----
Once logged in and the services are started, you can start playing around with it as documented by the apiaxle folks at http://apiaxle.com/docs/try-it-now/

Try  the apiaxle command

This image is for development purposes.. For production purposes, the services can be split out and a front-end load-balancer added, all running via linked docker containers.. 
