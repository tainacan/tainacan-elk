class PollProcess
    def initialize
        @processLocked = false
    end

    def process_is_locked
        @processLocked
    end

    def locked_process
        @processLocked = true
    end

    def unlocked_process
        @processLocked = false
    end

    def exec
        time = rand(10)
        puts "process sleep for #{time} seconds"
        sleep(time)
    end
end
