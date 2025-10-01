# Decisões: Integração do Ollama

## Seleção de Modelos

Após análise das opções disponíveis, decidimos utilizar os seguintes modelos:

1. **llama3** - Modelo base para interações gerais, bom equilíbrio entre tamanho e qualidade
2. **nomic-embed-text** - Modelo específico para geração de embeddings de texto

Justificativa: Estes modelos representam um bom equilíbrio entre desempenho e requisitos de recursos, sendo adequados para um ambiente de teste e desenvolvimento.

## Arquitetura de Integração

Decidimos adicionar o Ollama como um serviço independente no docker-compose, com as seguintes características:

- Container separado para melhor gerenciamento de recursos
- Volume dedicado para persistência dos modelos
- Comunicação direta com o N8N através da rede interna do Docker
- Exposição da porta 11434 para acesso externo durante desenvolvimento
- Inicialização prioritária antes do N8N para garantir disponibilidade

## Configuração de Recursos

Para garantir o bom funcionamento, definimos as seguintes configurações de recursos:

- Sem limite específico de memória, utilizando o que estiver disponível
- Sem configuração específica de GPU nesta fase inicial
- Volume persistente para os modelos baixados

## Estratégia para Testes

A abordagem de testes escolhida é:

1. Verificar inicialização e disponibilidade do serviço
2. Testar download dos modelos selecionados
3. Criar um workflow básico de conversa no N8N
4. Testar integração com a Evolution API

## Decisões Pendentes

Algumas decisões que ainda precisam ser tomadas:

- Configuração de recursos para ambientes de produção
- Estratégia de atualização dos modelos
- Padrões de prompts para diferentes casos de uso
- Mecanismos de fallback em caso de falha do Ollama 