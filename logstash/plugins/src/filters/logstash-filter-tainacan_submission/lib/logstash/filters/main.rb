require_relative "SubmissionQueue"
require_relative "Submission"

class Main
    def initialize
        @submissionQueue = SubmissionQueue.instance
        @@ID = 1
    end

    def dispatch_task(url, collection_id, metadata, item)
        submission = @submissionQueue.add_submission(url, collection_id, metadata, item)
        return submission
    end
end

main = Main.new()

x = Thread.new {
    puts "iniciando task 1"
    
    url = "url 1"
    collection_id = "collection_id 1"
    metadata = "metadata 1"
    item = {"title"=>"hello", "description"=>'cumprimento em inglês'}
    
    task = main.dispatch_task(url, collection_id, metadata, item)
    puts "finalizando task 1: #{task}"
}


y = Thread.new {
    puts "iniciando task 2"
    
    url = "url 2"
    collection_id = "collection_id 2"
    metadata = "metadata 2"
    item = {"title"=>"Hola", "description"=>'cumprimento em espanhol'}
    
    task = main.dispatch_task(url, collection_id, metadata, item)
    puts "finalizando task 2: #{task}"
}

z = Thread.new {
    puts "iniciando task 3"
    
    url = "url 3"
    collection_id = "collection_id 3"
    metadata = "metadata 3"
    item = {"title"=>"Salut", "description"=>'cumprimento em francês'}

    task = main.dispatch_task(url, collection_id, metadata, item)
    puts "finalizando task 3: #{task}"
}

z.join
x.join
y.join