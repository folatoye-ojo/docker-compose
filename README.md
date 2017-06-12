Setup Docker
------------------
1. Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

1. In [Docker for Mac's advanced preferences](https://docs.docker.com/docker-for-mac/#advanced), increase the runtime memory from 2GB to at least 4GB.

1. Add host file entries for `elasticsearch` and `tracking_web` in your `/etc/hosts` file.

    ```
    127.0.0.1	elasticsearch
    127.0.0.1	tracking_web
    127.0.0.1	mockserver
    ```

1. Create an account on Docker Hub, and request access to the G2 Crowd organization from one of your team members.

1. Login to Docker Hub from the command line:

    ```
    docker login
    Username:
    Password:
    Email:
    WARNING: login credentials saved in ~/.docker/config.json
    Login Succeeded
    ```

1. Download the elasticsearch tarball from our Slack #product channel's pinned items. From your docker-compose directory run:
    
    ```
    ./script/elasticsearch-backup-restore.sh elasticsearch-2017-06-06-backup.tar.gz
    ```
    This will run a script to unzip and restore your elasticsearch container with index data
