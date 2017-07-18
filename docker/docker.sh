
#IMAGE="novasmidias/vod-cms-agentes-django-packer"
#CONTAINER="vod01"
#DOMAIN="agentes01.cms.vod.globosat.globoi.com"

PHALANX_CONTAINER="phalanx.com.br"

SELF=$(basename $0)

function docker-ip() {
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

function run() {
    local phalanx_ip=$(docker-ip $PHALANX_CONTAINE)

    if [ "$#" == 1 ] && [ "$1" == "--ignore" ]; then
        phalanx_ip="1"
    fi

    if [ "$phalanx_ip" == "" ]; then
        echo "Precisa levantar o os containers do banco e do redis primeiro."
        exit 1
    fi

    docker rm -f $CONTAINER 2> /dev/null
    docker run -d --name $CONTAINER \
        -v $PWD:/home/app \
        --add-host $DOMAIN:127.0.0.1 \
        -h $DOMAIN \
        --link $PHALANX_CONTAINER:phalanx.com.br \
        -e "ENV=DEVELOPMENT" \
        $IMAGE

    egrep -v "$DOMAIN" /etc/hosts > /tmp/hosts
    echo "$(docker-ip $CONTAINER)    $DOMAIN" >> /tmp/hosts
    sudo mv /tmp/hosts /etc/
    echo "Criado container $CONTAINER. Acesse http://$DOMAIN/admin"
}

function log() {
    docker exec $CONTAINER cat /var/log/gunicorn.log
    echo "-----"
    echo "Fim do log do gunicorn."
}

function enter() {
    docker exec -it $CONTAINER bash
}

function dump() {
    local file=$1
    if [ "$file" == "" ]; then
        echo "O arquivo sql de dump precisa estar dentro do diretorio do projeto."
        echo "Usage: ./$(basename $0) dump tabelas.sql";
        exit 1
    fi
    docker exec $CONTAINER mysql -u vod_cms_agentes -pjkL09818jkairTq -D vod_cms_agentes_django -e "source /www/vod/vod-cms-agentes-django/app/$file"
    echo "Dump feito."
}

function reload() {
    docker exec $CONTAINER bash /root/restart.sh
    echo "gunicorn reiniciado."
}

function route() {
    echo "Definindo rota para acessar os containers pelo ip..."
    sudo route -n add 172.17.0.0/16 $(boot2docker ip)
}

function help() {
    echo "Usage: $SELF run|log|ssh|ip|dump|reload"
}

case "$1" in
    'run') run $2 ;;
    'log') log ;;
    'ssh') enter ;;
    'ip') docker-ip $CONTAINER ;;
    'dump') dump $2 ;;
    'reload') reload ;;
    'route') route ;;
    *) help; exit 1 ;;
esac