require_relative "PollProcess"

class Submission < PollProcess
    def initialize(url, collection_id, metadata, item)
        super()
        @url = url
        @collection_id = collection_id
        @metadata = metadata
        @item = item
    end

    def exec
        time = rand(10)
        puts "Submission sleep for #{time} seconds"
        sleep(time)
    end

    def to_s
        "#{@url}, #{@collection_id}, #{@metadata}, #{@item}"
    end

    def get_id
        rand(100)
    end
end
