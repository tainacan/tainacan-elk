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

# x = Thread.new {
#     puts "iniciando task 1"
    
#     url = "http://rcteste.tainacan.or/"
#     collection_id = "10100"
#     metadata = {10105 => "name", 10103 => "description"}
#     item = {"name"=>"hello", "description"=>'cumprimento em inglês'}
    
#     task = main.dispatch_task(url, collection_id, metadata, item)
#     puts "finalizando task 1: #{task}"
# }


y = Thread.new {
    puts "iniciando task 2"
    
    url = "http://rcteste.tainacan.org/"
    collection_id = "10100"
    metadata = {10105 => "Title", 10103 => "Description", 299867 => "Material/Técnica", 299910 => "Classificação"}
    item = {"Title"=>"Teste taxonomia vinicius 2", "Description"=>'verificando se deu certo', "Material/Técnica" => ['madeira', 'aço'], "Classificação" => ['Fortalezaaaaaa']}
    
    task = main.dispatch_task(url, collection_id, metadata, item)
    puts "finalizando task 2: #{task}"
}

# z = Thread.new {
#     puts "iniciando task 3"
    
#     url = "http://rcteste.tainacan.org/"
#     collection_id = "10100"
#     metadata = {10105 => "name", 10103 => "description"}
#     item = {"name"=>"Salut", "description"=>'cumprimento em francês'}

#     task = main.dispatch_task(url, collection_id, metadata, item)
#     puts "finalizando task 3: #{task}"
# }

# z.join
# x.join
y.join