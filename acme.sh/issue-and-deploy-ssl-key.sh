docker exec \
    -e DP_Id="your_id" \
    -e DP_Key="your_key"  \
    acme.sh --issue --dns dns_dp -d example.com -d *.example.com

docker exec \
    -e DEPLOY_DOCKER_CONTAINER_LABEL=sh.acme.autoload.domain=example.com \
    -e DEPLOY_DOCKER_CONTAINER_KEY_FILE="/etc/nginx/ssl/example.com.key" \
    -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="/etc/nginx/ssl/fullchain.cer" \
    -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="service nginx force-reload" \
    acme.sh --deploy -d example.com  --deploy-hook docker
