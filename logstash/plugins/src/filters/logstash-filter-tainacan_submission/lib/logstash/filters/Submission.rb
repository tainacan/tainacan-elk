require "uri"
require "net/http"
require "json"
require "logger"
require_relative "PollProcess"

class Submission < PollProcess

    def initialize(url, collectionId, metadata, item)
        super()
        @url=url
        @collectionId=collectionId
        @metadata=metadata
        @item = item
    end

    def submission(item)
        if @url && @collectionId
          uriadress = "#{@url}/wp-json/tainacan/v2/collection/#{@collectionId}/items/submission"
          uri = URI.parse(uriadress)
          header = {'Content-Type': 'text/json'}
            
          if @metadata
            metadata_values = []
            @metadata.each do |id, field|
              item_metadata = {
                metadatum_id: id,
                value: item[field] #logstash
              }
              metadata_values.push(item_metadata)
            end
            body = {
              collectionId: @collectionId,
              metadata: metadata_values
            }
            http = Net::HTTP.new(uri.host, uri.port)
            request = Net::HTTP::Post.new(uri.request_uri, header)
            request.body = body.to_json
            response = http.request(request)
            response_obj = JSON.parse(response.body)
            
            if response.is_a?(Net::HTTPSuccess)
              response_obj = JSON.parse(response.body)
              uri = URI.parse(@url + '/wp-json/tainacan/v2/collection/' + @collectionId + '/items/submission/' + response_obj['id'].to_s + '/finish')
              http = Net::HTTP.new(uri.host, uri.port)
              request = Net::HTTP::Post.new(uri.request_uri, header)
              request.body = {}.to_json
              response = http.request(request)
              if response.is_a?(Net::HTTPSuccess)
                response_obj = JSON.parse(response.body)
                @id = response_obj['id']
                return response_obj
              end
            end
          end
        end
    end

    def exec
        self.submission(@item)
    end

    def to_s
        "ID: #{@id}\nURL: #{@url}\nCollectionId: #{@collectionId}\nMetadata: #{@metadata}\nItem: #{@item}"
    end

    def get_id
        @id 
    end
end
