require 'net/http'
require 'json'

uri = URI.parse('http://rcteste.tainacan.org/wp-json/tainacan/v2/collection/91136/items/submission')
header = {'Content-Type': 'text/json'}
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
body = {
	collection_id: '91136',
	metadata: [{metadatum_id:"91219",value:[""]},{metadatum_id:"91151",value:[""]},{metadatum_id:"91183",value:["Villa-lobos ao piano, tocando agogo ladeado por seu \"camisão\""]},{metadatum_id:"91137",value:["1980.16.123.02"]},{metadatum_id:"91139",value:["80.16.123"]},{metadatum_id:"91141",value:["Localizado"]},{metadatum_id:"91181",value:["Fotografia"]},{metadatum_id:"91147",value:["Não identificado"]},{metadatum_id:"91149",value:["10 comunicação > 10.1 documento"]},{metadatum_id:"91153",value:[""]},{metadatum_id:"91167",value:["Fotografia em preto e branco; papel"]},{metadatum_id:"91173",value:["05/03/1957"]},{metadatum_id:"91171",value:[""]},{metadatum_id:"91169",value:["Bom"]},{metadatum_id:"91175",value:[""]},{metadatum_id:"91222",value:["RC-TESTE"]}]
}
request.body = body.to_json
# Send the request
response = http.request(request)
if response.is_a?(Net::HTTPSuccess)
	response_obj = JSON.parse(response.body)
	uri = URI.parse('http://rcteste.tainacan.org/wp-json/tainacan/v2/collection/91136/items/submission/' + response_obj['id'].to_s + '/finish')
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Post.new(uri.request_uri, header)
	request.body = {}.to_json
	response = http.request(request)
	puts "finish RESPONSE:"
	puts response.body
end


