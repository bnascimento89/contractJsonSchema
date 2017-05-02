#encode: utf-8
#language: pt

Funcionalidade: Instalação de rastreador

Como usuário
Desejo enviar a confirmação de instalação do rastreador e garantir que o contrato esteja correto 

 @rastreador
Cenário: Post para instalar rastreador 
	Dado que faça um post para instalar o rastreador
	Entao o código da resposta deve ser "200"
	E o json deve estar no formato do schema
	E a resposta deve ter o campo topic com o valor "SatStatusTracker"

@exemplo
Cenario: Post rastreador
	Dado que mandemos o post para a sat
	Então o codigo deve ser "200"
	E json deve estar no formato correto
	Então o campo apolice deve conter a apolice "5003110002064"

