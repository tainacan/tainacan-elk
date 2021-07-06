# encoding: utf-8
require "logstash/filters/base"
require_relative "SubmissionQueue"

class LogStash::Filters::TainacanSubmission < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  config_name "tainacan_submission"

  config :url, :validate => :string, :default => "<url>"
  config :collection_id, :validate => :string, :default => nil
  config :metadata, :validate => :hash

  public
  def register
    # Add instance variables
    @submission_queue = SubmissionQueue.instance
  end # def register

  public
  def filter(event)
    if @url && @collection_id && @metadata

      url = @url
      metadata = @metadata
      item = event.to_hash()
      collection_id = @collection_id
      submission = @submission_queue.add_submission(url, collection_id, metadata, item)
      event.set("id_agretation", submission.get_id)
      puts "submission ID response: #{submission.get_id}"
    end
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::tainacan_submission
