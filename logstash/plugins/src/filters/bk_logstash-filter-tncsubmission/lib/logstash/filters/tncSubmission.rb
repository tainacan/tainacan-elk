# encoding: utf-8
require "logstash/filters/base"

# This  filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
# https://www.elastic.co/guide/en/logstash/current/filter-new-plugin.html
class LogStash::Filters::Tncsubmission < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #    {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "tncSubmission"

  # Replace the message with this value.
  # config :message, :validate => :string, :default => "Hello World!"
  config :url, :validate => :string, :default => "<url>"
  config :collection_id, :validate => :string, :default => nil
  config :metadata, :validate => :hash


  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)
    if @url && @collection_id
      # uri = URI.parse('http://rcteste.tainacan.org/wp-json/tainacan/v2/collection/91136/items/submission')
      uri = URI.parse(@url + '/wp-json/tainacan/v2/collection/' + @collection_id + '/items/submission')
      header = {'Content-Type': 'text/json'}
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, header)

      if @metadata
        metadata_values = []
        @metadata.each do |id, field|
          #puts id
          #puts event.get(field)
          item_metadata = {
            metadatum_id: id,
            value: [event.get(field)]
          }
          metadata_values.push(item_metadata)
        end
        body = {
          collection_id: @collection_id,
          metadata: metadata_values
        }
        request.body = body.to_json
        response = http.request(request)
        if response.is_a?(Net::HTTPSuccess)
          response_obj = JSON.parse(response.body)
          #uri = URI.parse('http://rcteste.tainacan.org/wp-json/tainacan/v2/collection/91136/items/submission/' + response_obj['id'].to_s + '/finish')
          uri = URI.parse(@url + '/wp-json/tainacan/v2/collection/' + @collection_id + '/items/submission/' + response_obj['id'].to_s + '/finish')
          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Post.new(uri.request_uri, header)
          request.body = {}.to_json
          response = http.request(request)
          if response.is_a?(Net::HTTPSuccess)
            response_obj = JSON.parse(response.body)
            event.set("id_agretation", response_obj['id'])
          end
          #puts "finish RESPONSE:"
          #puts response.body
        end
      end

    end

    # if @message
    #   # Replace the event message with our message as configured in the
    #   # config file.
    #   event.set("message", @message)
    # end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Tncsubmission
