# Tainacan Elastic Stack Integration
## requisitos:
[docker](https://docs.docker.com/get-docker)

[docker-compose](https://docs.docker.com/compose/install)

### descrição:
   o arquivo `docker-compose.yml` descreve os serviços que serão inicializados, nele descrevemos o serviço para 4 containers:
  
1. elasticsearch:
   serviço do ElasticSearch(ES) responsável por armazenar os dados integrados.
2. logstash:
   serviço de pipelines para tratamentos dos dados.
3. filebeat:
   serviço de coletor de dados das instalações
4. kibana:
   serviço de dashboard
5. tainacan:
   instância do wordpress/tainacan
6. db:
   instância do banco de dados do mysql para o wordpress

### principais comandos
#### iniciar os serviços:
```
docker-compose up -d
```
#### finalizar os serviços:
```
docker-compose down
```
#### finalizar apenas um serviço:
```
docker-compose stop kibana
docker-compose stop filebeat
docker-compose stop logstash
docker-compose stop elasticsearch
```
#### inicializar apenas um serviço:
```
docker-compose start kibana
docker-compose start filebeat
docker-compose start logstash
docker-compose start elasticsearch
```
#### Acessar elasticsearch:
```
http://localhost:9200/
http://localhost:9200/_cat/indices
http://localhost:9200/<nome do index>/_search
```
#### Excluir index do elasticsearch
```
curl -XDELETE http://localhost:9200/<nome do index>
```
#### Excluir todos os itens do index do elasticsearch
```
POST <nome do index>/_delete_by_query?conflicts=proceed
{
 "query": {
 "match_all": {}
 }

```
#### Acessar kibana:
```
http://localhost:5601/
```
### Arquivos de configuração da integração:
#### filebeat:
```
1. filebeat/filebeat.yml -> configuração geral para o filebeat
1. filebeat/inputs.d/*  -> arquivos configurações dos coletores
```

#### logstash:
```
1. logstash -> diretório com os arquivos do logstash
2. logstash/pipeline/ -> configuração do pipeline do logstash
```

#### outros:
```
1. esdata -> diretório para persistencia do banco do elasticsearch
2. dbdata -> diretório para persistência do banco de dados do mysql
3. tainacan -> diretório para perisitência da instalação wordpress/tainacan
```

#### Configurar usuários e senhas - xpack
```
docker-compose exec elasticsearch bash
./bin/elasticsearch-setup-passwords interactive
ctrl+d

docker-compose exec kibana bash
./bin/kibana-keystore create
./bin/kibana-keystore add elasticsearch.username
./bin/kibana-keystore add elasticsearch.password
ctrl+d

docker-compose stop kibana
docker-compose start kibana
```

O usuário e senha de ingestão de dados deve ser configurada para o pipeline do logstash:
```
output {
   elasticsearch {
     hosts => "elasticsearch"
     document_id => "%{fingerprint}"
     index => "tainacan_integracao"
     user => "log_stash_user"
    password => "pass123456"
   }
}
```





