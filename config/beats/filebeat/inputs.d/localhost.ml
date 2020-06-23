- type: httpjson
  http_method: GET
  interval: 3600s
  #interval: 10s 
  url: http://tainacan-dev/wp-json/tainacan/v2/collection/954/items?perpage=5&paged=1
  # json_objects_array: "items"
  pagination:
    enabled: true
    extra_body_content:
      perpage: 5
    id_field: next_page
    req_field: paged
    url: http://tainacan-dev/wp-json/tainacan/v2/collection/954/items
  #   #header:
    #  field_name: x-wp-totalpages
    #  regex_pattern: "{d}"
  processors:
  - decode_json_fields:
      fields: [message]
      target: json
  - convert:
      mode: "rename"
      fields:
        - {from: "json.title",                                        to: "payload.titulo"}
        - {from: "json.description",                                  to: "payload.descricao"}
        - {from: "json.collection_id",                                to: "payload.colecaoId"}
        - {from: "json.metadata.extra-metadata-4.value_as_string",    to: "payload.classificacao"}
        - {from: "json.metadata.numeric-type.value_as_string",        to: "payload.material"}
        - {from: "json.metadata.text-type.value_as_string",           to: "payload.numeroRegistro"}
      ignore_missing: true
      fail_on_error: false
  - drop_fields:
     fields: ["message", "json"]
  - add_fields:
      target: payload
      fields:
        instalacao: "localhost"

#x-wp-total #total de itens
    #x-wp-totalpages #total de pagina