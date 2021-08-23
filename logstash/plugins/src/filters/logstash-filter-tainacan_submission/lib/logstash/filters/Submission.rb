require "uri"
require 'open-uri'
require 'mini_magick'
require 'securerandom'
require 'tmpdir'
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

    def download_url_to(url, base_path)
      uri = URI(url)
      filename = uri.path.split("/").last
      new_file = File.join(base_path, SecureRandom.uuid + '_integracao_files_' + filename )

      image = MiniMagick::Image.open(url)
      image.resize "300x300"
      image.write(new_file)

      return new_file
    end
    
    def delete_file(path_to_file)
      File.delete(path_to_file) if File.exist?(path_to_file)
    end

    def submission(item)
      self.writeLog
      begin
        if @url && @collectionId
          uriadress = "#{@url}/wp-json/tainacan/v2/collection/#{@collectionId}/items/submission"
          uri = URI.parse(uriadress)
          header = {'Content-Type': 'text/json'}
            
          if @metadata
            metadata_values = []
            thumbnail_url = false;
            @metadata.each do |id, field|
              if(field == 'classificacao')
                item_metadata = {
                  metadatum_id: id,
                  value: item[field][-1] #logstash
                }
              else
                item_metadata = {
                  metadatum_id: id,
                  value: item[field] #logstash
                }
              end
              if( id != '_thumbnail' )
                metadata_values.push(item_metadata)
              else
                thumbnail_url = item[field]
              end
            end
            body = {
              collectionId: @collectionId,
              metadata: metadata_values
            }
            http = Net::HTTP.new(uri.host, uri.port)
            request = Net::HTTP::Post.new(uri.request_uri, header)
            request.body = body.to_json
            response = http.request(request) 

            if response.is_a?(Net::HTTPSuccess)
                response_obj = JSON.parse(response.body)

                uri = URI(@url + '/wp-json/tainacan/v2/collection/' + @collectionId + '/items/submission/' + response_obj['id'].to_s + '/finish')
                request = Net::HTTP::Post.new(uri)

                if(thumbnail_url != false)
                  temp = Dir.tmpdir()
                  file_thumbnail_path = download_url_to(thumbnail_url, temp)
                  file_thumbnail = File.open(file_thumbnail_path)
                  request.set_form([['thumbnail', file_thumbnail]], 'multipart/form-data')
                end
                response = Net::HTTP.start(uri.hostname, uri.port) do |http|
                  http.request(request)
                end
                delete_file(file_thumbnail_path)

                case response
                  when Net::HTTPSuccess, Net::HTTPRedirection
                    response_obj = JSON.parse(response.body)
                    @id = response_obj['id']
                    return response_obj
                  else
                    response_obj = JSON.parse(response.body)
                    @id = false
                    @error = response_obj['error_message']
                end
            else
              response_obj = JSON.parse(response.body)
              $log.error "#{response_obj['error_message']}#{response_obj}"
              @id = false
              @error = response_obj['error_message']
              return response_obj
            end
          end
        end
      rescue Exception => e
        $log.error "Houve um erro!: #{e}"
        return
      end
    end
    
    def writeLog
       $log = Logger.new('writeLog.log', 'monthly')
       $log.level = Logger::INFO
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

    def get_error
      @error
    end
end
