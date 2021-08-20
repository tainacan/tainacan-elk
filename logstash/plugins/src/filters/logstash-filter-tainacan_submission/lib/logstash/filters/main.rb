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
    
    url = "http://localhost/"
    collection_id = "5"
    metadata = {
        36=>"id",
        7=>"resumo-descritivo",
        8=>"titulo",
        32=>"numero-registro",
        31=>"outros-numeros",
        29=>"situacao",
        30=>"denominacao",
        28=>"autor",
        24=>"dimensoes",
        25=>"dimensoes-altura",
        26=>"classificacao",
        23=>"dimensoes-largura",
        20=>"dimensoes-espessura",
        21=>"dimensoes-profundidade-comprimento",
        22=>"dimensoes-diametro",
        18=>"dimensoes-peso",
        19=>"material-tecnica",
        14=>"data-producao",
        16=>"local-producao",
        17=>"estado-conservacao",
        15=>"condicoes-reproducao",
        13=>"midias-relacionadas",
        39=>"instalacao",
        34=>"fingerprint",
        35=>"url",
        '_thumbnail'=>"thumbnail-url"
    }
    item = {
        "thumbnail-url" => "https://museudoouro.acervos.museus.gov.br/wp-content/uploads/2021/04/cropped-MO729-scaled-1.jpg",
        "denominacao"=>"Cadeira de Sola",
        "outros-numeros"=>"MO 61 | Tombo nº 1941.03.01",
        "titulo"=>"",
        "material-tecnica"=>["Couro lavrado", "madeira", "marcenaria", "metal"],
        "local-producao"=>"Brasil | Minas Gerais",
        "url"=>"https://museudoouro.acervos.museus.gov.br/acervo/cadeira-de-sola/",
        "resumo-descritivo"=>"Cadeira de espaldar alto, reclinado, com recortes curvo superior e inferior; revestimento em couro decorado com o brasão das Armas de Portugal, com inscrição circundante, coroado e delimitado por frisos curvos, volutas, guirlandas de flores e acantos sinuosos, com dois putos inferiores a maneira de atlantes; contorno em friso de lingüeta, com palmeta superior; tacheado miúdo na frente e laterais; com arremate de pináculos nas quinas; assento de formato trapezoidal, mas de desenho curvo, revestido por couro, com decoração em volutas, acantos sinuosos, conchas e palmetas, guirlanda de flores e dois leões alados; contorno em friso de lingüeta, com a borda moldurada; pernas dianteiras com joelhos de saída, contornadas por frisos; pernas traseiras recurvadas e cilíndricas; amarração em “H” sinuoso, com travessas emolduradas; a traseira cilíndrica; pés cônicos, torneados.",
        "id"=>5227,
        "autor"=>"Não identificado",
        "classificacao"=>["05 interiores", "05.5 peça de mobiliário"],
        "dimensoes"=>"altura (cm): 134,0 largura (cm): 57,0 comprimento (cm): profundidade (cm): 5,08 diâmetro (cm): peso (g): circunferência (cm):",
        "condicoes-reproducao"=>"Domínio público, ver http://museudoouro.acervos.museus.gov.br/reproducao-de-imagens-do-acervo/",
        "midias-relacionadas"=>"",
        "fingerprint"=>"122c69cbcffb3e4eff500fd7b9a66f28",
        "data-producao"=>"Século XVIII",
        "numero-registro"=>"61",
        "instalacao"=>"Museu do Ouro"
    }

    task = main.dispatch_task(url, collection_id, metadata, item)
    puts "finalizando task 1: #{task}"
}


y = Thread.new {
    puts "iniciando task 2"
    
    url = "http://localhost/"
    collection_id = "5"
    #metadata = {10105 => "Title", 10103 => "Description", 299867 => "Material/Técnica", 299910 => "Classificação"}
    #item = {"Title"=>"Teste taxonomia vinicius 2", "Description"=>'verificando se deu certo', "Material/Técnica" => ['madeira', 'aço'], "Classificação" => ['Fortalezaaaaaa']}
    metadata = {
        36=>"id",
        7=>"resumo-descritivo",
        8=>"titulo",
        32=>"numero-registro",
        31=>"outros-numeros",
        29=>"situacao",
        30=>"denominacao",
        28=>"autor",
        24=>"dimensoes",
        25=>"dimensoes-altura",
        26=>"classificacao",
        23=>"dimensoes-largura",
        20=>"dimensoes-espessura",
        21=>"dimensoes-profundidade-comprimento",
        22=>"dimensoes-diametro",
        18=>"dimensoes-peso",
        19=>"material-tecnica",
        14=>"data-producao",
        16=>"local-producao",
        17=>"estado-conservacao",
        15=>"condicoes-reproducao",
        13=>"midias-relacionadas",
        39=>"instalacao",
        34=>"fingerprint",
        35=>"url",
        '_thumbnail'=>"thumbnail-url"
    }
    item = {
        "thumbnail-url"=>"https://museudoouro.acervos.museus.gov.br/wp-content/uploads/2019/04/MO-679-1.jpg",
        "denominacao"=>"Barra de ouro",
        "outros-numeros"=>"MO 1  |  Tombo nº 1942.21.01",
        "titulo"=>"",
        "material-tecnica"=>["Ouro fundido"],
        "local-producao"=>"Mato Grosso",
        "url"=>"https://museudoouro.acervos.museus.gov.br/acervo/barra-de-ouro/",
        "resumo-descritivo"=>"Barra retangular irregular e grossa. Em uma face apresenta as Armas da Coroa, o no da Barra (659), a data (1816), a marca do ourives ensaiador (IDRF ou IDBF), a marca do toque e do quilate (23), a marca de um grão (a flor), e o peso 6-5-3-54 (seis marcos, cinco onças, três oitavas e cinqüenta e quatro grãos). Na outra face, a Esfera Armilar.", 
        "id"=>5207,
        "autor"=>"Casa de Fundição de Mato Grosso",
        "classificacao"=>["03 objetos pecuniários"],
        "dimensoes"=>"altura (cm): largura (cm): 2,8 comprimento (cm): 22,0 profundidade (cm): 1,4 diâmetro (cm): peso (g): + de 1500,0 circunferência (cm):",
        "condicoes-reproducao"=>"Domínio público, ver http://museudoouro.acervos.museus.gov.br/reproducao-de-imagens-do-acervo/",
        "midias-relacionadas"=>"",
        "fingerprint"=>"862664808497a5bc01d7308eff4e20f7",
        "data-producao"=>"1816 | Século XIX",
        "numero-registro"=>"1",
        "instalacao"=>"Museu do Ouro"
    }
    
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
x.join
y.join