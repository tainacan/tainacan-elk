require_relative "Submission"

class SubmissionQueue
    def initialize
        @queue = Queue.new
        @pool_size = 1
        self.create_poll
    end

    def create_poll
        threads = []
        @pool_size.times do
            threads << Thread.new do
              loop do
                queue_item = @queue.pop
                queue_item.exec
                queue_item.unlocked_process
              end
            end
        end
    end

    @instance = SubmissionQueue.new
    private_class_method :new

    def self.instance
        @instance
    end

    def process(submission)
        submission.locked_process
        @queue.push submission
        sleep(0.1) until (!submission.process_is_locked)
        return submission
    end

    def add_submission(url, collection_id, metadata, item)
        submission = Submission.new(url, collection_id, metadata, item)
        return self.process(submission)
    end
end
