Setup Docker
------------------
1. Make sure your Homebrew formulae are up-to-date: `brew update`

1. Install [dinghy](https://github.com/codekitchen/dinghy) and create the VM.

1. You will have installed `docker` and `docker-machine` in the previous step. Install `docker-compose` using Homebrew:
    ```
    brew install docker-compose
    ```

1. Add the following line to your `.bashrc` or `.zshrc`. Make sure to source your session or open a new terminal session
    ```
    eval "$(docker-machine env dinghy)"
    ```

1. Add a hosts file entry for the dinghy VM. Use the output of
    ```
    docker-machine ip dinghy
    ```
and create an entry for `solr` in your `/etc/hosts` file.

1. Create data volume containers:
    ```
    docker create -v /usr/local/bundle --name ue-bundle ruby:2.2.3 /bin/true
    docker create -v /usr/local/bundle --name analytics-bundle ruby:2.2.3 /bin/true
    docker create -v /opt/solr/server/solr --name solr-data g2crowd/solr /bin/true
    docker create -v /var/lib/postgresql/data --name postgres-data postgres:9.3 /bin/true
    ```

1. If you would like to have the docker services accessible locally, you need to create a port mapping from the VM to
your host for each service. The first mapping is required for the grid images to show properly:
    ```
    VBoxManage controlvm dinghy natpf1 "localhost,tcp,127.0.0.1,3000,,3000"
    VBoxManage controlvm dinghy natpf1 "postgres,tcp,127.0.0.1,5432,,5432"
    VBoxManage controlvm dinghy natpf1 "redis,tcp,127.0.0.1,6379,,6379"
    VBoxManage controlvm dinghy natpf1 "solr,tcp,127.0.0.1,8983,,8983"
