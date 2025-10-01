# Contexto Técnico: Integração do Ollama

## O que é o Ollama

O Ollama é uma ferramenta que permite executar grandes modelos de linguagem (LLMs) localmente, sem necessidade de API externa ou conexão permanente com a internet. Ele oferece uma maneira simplificada de baixar, executar e gerenciar modelos de IA em máquinas locais.

## Especificações Técnicas

- **Imagem Docker**: `ollama/ollama`
- **Porta padrão**: 11434
- **API REST**: Disponível via HTTP na porta configurada
- **Modelos populares**: llama3, llama3.1, gemma, mistral, mixtral, phi, entre outros
- **Repositório Oficial**: [https://github.com/ollama/ollama](https://github.com/ollama/ollama)
- **Documentação**: [https://ollama.com/docs](https://ollama.com/docs)

## Uso da API do Ollama

O Ollama expõe uma API REST que pode ser acessada via HTTP. Abaixo estão os principais endpoints:

- `GET /api/tags` - Lista todos os modelos disponíveis localmente
- `POST /api/pull` - Baixa um modelo do repositório do Ollama
- `POST /api/generate` - Gera texto a partir de um prompt
- `POST /api/chat` - Mantém uma conversa com histórico
- `POST /api/embeddings` - Gera embeddings de texto

## Requisitos de Sistema

- **RAM**: Mínimo recomendado de 8GB, ideal 16GB+
- **Armazenamento**: 10GB+ por modelo
- **CPU**: Multi-core recomendado
- **GPU**: Opcional, mas recomendado para melhor performance

## Integração com N8N

O N8N possui integração nativa com o Ollama através dos nós:
- **Ollama Chat Model**: Para interações conversacionais
- **Ollama Model**: Para geração de texto e embeddings

A comunicação entre o N8N e o Ollama é feita via API REST, o que significa que o N8N precisa ter acesso à porta do serviço do Ollama.

## Implementação no Docker Compose

A implementação do Ollama no ambiente Docker existente foi realizada através das seguintes configurações no `docker-compose.yml`:

```yaml
ollama:
  image: ollama/ollama:latest
  container_name: ollama
  restart: always
  ports:
    - "11434:11434"
  environment:
    - OLLAMA_HOST=0.0.0.0
    - OLLAMA_MODELS=/root/.ollama/models
  volumes:
    - ollama_data:/root/.ollama
  networks:
    - n8n_network
  healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost:11434"]
    interval: 10s
    timeout: 5s
    retries: 5
  command: >
    sh -c "ollama serve &
          sleep 10 &&
          ollama pull llama3 &&
          ollama pull nomic-embed-text &&
          wait"
```

### Detalhes da Configuração

- Utiliza a imagem oficial `ollama/ollama:latest`
- Expõe a porta 11434 para acesso à API REST
- Configura o host para escutar em todas as interfaces (`0.0.0.0`)
- Cria um volume persistente `ollama_data` para armazenar os modelos
- Define um healthcheck para verificar disponibilidade do serviço
- Executa comando personalizado para:
  - Iniciar o servidor Ollama
  - Aguardar 10 segundos para inicialização
  - Baixar o modelo llama3 para uso geral
  - Baixar o modelo nomic-embed-text para embeddings

### Integrações com Outros Serviços

1. Adiciona dependência no serviço n8n para garantir que o Ollama esteja disponível
2. Configura entrada extra_hosts para facilitar comunicação direta
3. Adiciona Ollama à mesma rede (n8n_network) para comunicação interna
4. Configura volume persistente para manter os modelos entre reinicializações

## Referências de Workflows N8N + Ollama

1. Chat com LLMs locais usando N8N e Ollama
2. Assistente IA Self-Hosted com Ollama
3. Router de LLM dinâmico para Ollama
4. Detecção de alucinações usando modelo Ollama especializado 