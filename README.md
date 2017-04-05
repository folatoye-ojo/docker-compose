Setup Docker
------------------
1. Install VirtualBox and the [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)

1. Make sure your Homebrew formulae are up-to-date: `brew update`

1. Install [dinghy](https://github.com/codekitchen/dinghy) and create the VM. Make sure to create your VM with extra
storage using this command during the dinghy setup:
    ```
    dinghy create --provider virtualbox -d 40960
    ```

1. You will have installed `docker` and `docker-machine` in the previous step. Install `docker-compose` using Homebrew:
    ```
    brew install docker-compose
    ```

1. Add the following line to your `.bashrc` or `.zshrc`. Make sure to source your session or open a new terminal session
    ```
    eval "$(docker-machine env dinghy)"
    ```

1. Add host file entries for the dinghy VM. Use the output of
    ```
    docker-machine ip dinghy
    ```
and create an entry for `elasticsearch` and `tracking_web` in your `/etc/hosts` file.

    ```
    xxx.xxx.xxx.xxx	elasticsearch
    xxx.xxx.xxx.xxx	tracking_web
    ```

1. Prepare dinghy VM for elasticsearch:
    ```
    dinghy ssh
    sudo sysctl -w vm.max_map_count=262144
    ```

1. Create data volume containers:
    ```
    docker create -v /usr/local/bundle --name ue-bundle ruby:2.2.3 /bin/true
    docker create -v /usr/local/bundle --name analytics-bundle ruby:2.2.3 /bin/true
    docker create -v /usr/local/bundle --name list-bundle ruby:2.2.3 /bin/true
    docker create -v /usr/local/bundle --name tracking-bundle ruby:2.2.3 /bin/true
    docker create -v /usr/share/elasticsearch/data --name elasticsearch-data docker.elastic.co/elasticsearch/elasticsearch:5.3.0 /bin/true
    docker create -v /var/lib/postgresql/data --name postgres-data postgres:9.6.1 /bin/true
    docker create -v /ue/node_modules --name assets-bundle node:7.5.0 /bin/true
    ```

1. If you would like to have the docker services accessible locally, you need to create a port mapping from the VM to
your host for each service. The first mapping is required for the grid images to show properly:
    ```
    VBoxManage controlvm dinghy natpf1 "localhost,tcp,127.0.0.1,3000,,3000"
    VBoxManage controlvm dinghy natpf1 "postgres,tcp,127.0.0.1,5432,,5432"
    VBoxManage controlvm dinghy natpf1 "redis,tcp,127.0.0.1,6379,,6379"
    VBoxManage controlvm dinghy natpf1 "elasticsearch,tcp,127.0.0.1,9200,,9200"
    VBoxManage controlvm dinghy natpf1 "asset-tools,tcp,127.0.0.1,3080,,3080"
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
