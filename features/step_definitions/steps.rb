def fazer_post_autenticado
	type = 'application/json'
	authorization = '03d42053-268e-4751-b25c-884f9672cb24'
	@last_response = HTTParty.post('https://stage-ipr.youse.io/events/publishers',
	 :headers => {'Content-Type' => type, 'Authorization' => authorization},
	 :body => {
  		"topic" => "SatStatusTracker",
 		"content" => {
          "apolice"=> "5003110002064",
          "status"=> "Instalou",
          "chassi"=> "9C2JA04108R026045"
        }
     }.to_json,
	 :timeOut => 'max')
	puts @last_response.body.to_s
	return @last_response
end

def validar_response_code(codigo)
	puts @last_response.code.to_s
	@last_response.code.to_s.should == codigo
end

def validar_schema_json(schemaName)
	body = JSON.parse(@last_response.body)
  	expect(body).to match_response_schema(schemaName.to_s)
end

def validar_path_json(path, valor)
	body = JSON.parse(@last_response.body)
	atributo = JsonPath.on(body, path)
	puts atributo.to_s
	expect(atributo).not_to be_empty
	expect(atributo.to_s).to include(valor.to_s)
end

Dado(/^que faça um post para instalar o rastreador$/) do
  fazer_post_autenticado
end

Entao(/^o código da resposta deve ser "([^"]*)"$/) do |codigo|
  validar_response_code(codigo.to_s)
end

Entao(/^o json deve estar no formato do schema$/) do
  validar_schema_json("rastreador")
end

Entao(/^a resposta deve ter o campo topic com o valor "([^"]*)"$/) do |topic|
  validar_path_json("$..topic", topic.to_s)
end



Dado(/^que mandemos o post para a sat$/) do
  fazer_post_autenticado
end

Então(/^o codigo deve ser "([^"]*)"$/) do |codigo|
  validar_response_code(codigo.to_s)
end

Então(/^json deve estar no formato correto$/) do
  validar_schema_json("rastreador")
end

Então(/^o campo apolice deve conter a apolice "([^"]*)"$/) do |apolice|
  validar_path_json('$..apolice', apolice.to_s)
end
