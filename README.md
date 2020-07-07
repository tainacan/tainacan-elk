# Tainacan Elastic Stack Integration
## requisitos:
[docker](https://docs.docker.com/get-docker)

[docker-composer](https://docs.docker.com/compose/install)
### descrição:
   o arquivo `docker-compose.yml` descreve os serviços que serão inicializados, nele descrevemos o serviço para 4 containers:
  
1. elasticsearch:
   serviço do ElasticSearch(ES) responsável por armazenar os dados integrados.
2. logstash:
   serviço de pipelines para tratamentos dos dados.
3. filebeat:
   serviço de coletor de dados das instalações
4. kibana:
   serviço de dashboard (não incluído ainda)


### principais comandos
#### iniciar os serviços:
```
docker-composer up -d
```

#### finalizar os serviços:
```
docker-composer down -d
```

#### finalizar apenas um serviço:
```
docker-composer stop filebeat
docker-composer stop logstash
docker-composer stop elasticsearch
```

#### inicializar apenas um serviço:
```
docker-composer start filebeat
docker-composer start logstash
docker-composer start elasticsearch
```
#### Arquivos de configuração da integração:

1. config/beats/filebeat/inputs.d/  -> arquivos configurações dos coletores
2. config/logstash/pipeline/ -> configuração do pipeline do logstash
