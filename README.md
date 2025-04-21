# N8N com Evolution API para Estudo e Integração WhatsApp

Um ambiente integrado que combina o poder do n8n, uma plataforma de automação de fluxos de trabalho, com a Evolution API, uma interface para automação de WhatsApp, tudo em containers Docker.

## Objetivo

Este projeto permite criar e gerenciar facilmente automações e integrações entre diferentes plataformas, com foco especial no estudo das possibilidades do n8n utilizando o WhatsApp como canal de comunicação.

## Tecnologias

- **N8N**: Ferramenta de automação de fluxos de trabalho com interface visual
- **Evolution API**: API para integração com WhatsApp
- **PostgreSQL**: Banco de dados
- **Redis**: Cache

## Requisitos

- Docker
- Docker Compose
- Git

## Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/RenantDev/n8n_ads.git && cd n8n_ads
   ```

2. Configure os arquivos de ambiente:
   ```bash
   ./setup.sh
   ```
   Este script criará automaticamente o arquivo `.env.example` e copiará para `.env` se não existir.

3. (Opcional) Ajuste as variáveis de ambiente no arquivo `.env` conforme necessário:
   - `POSTGRES_DB`: Nome do banco de dados PostgreSQL
   - `POSTGRES_USER`: Usuário do PostgreSQL
   - `POSTGRES_PASSWORD`: Senha do PostgreSQL
   - `EVOLUTION_DB`: Nome do banco de dados para a Evolution API
   - `AUTHENTICATION_API_KEY`: Chave para autenticação na Evolution API

4. Inicie os serviços:
   ```bash
   docker compose up -d
   ```

5. Acesse as interfaces:
   - **N8N**: http://localhost:5678
   - **Evolution API**: http://localhost:8080

## Estrutura de Diretórios

- `data/`: Arquivos persistentes dos containers
- `docker-compose.yml`: Configuração dos serviços Docker
- `setup.sh`: Script para configurar o ambiente

## Resolução de Problemas

Se você encontrar problemas durante a inicialização:

1. Verifique se o arquivo `.env` existe e contém todas as variáveis necessárias
2. Verifique os logs com `docker compose logs`
3. Certifique-se de que as portas necessárias (5678, 8080, 5432, 6379) estão disponíveis

## Contribuição

Sinta-se à vontade para contribuir com este projeto enviando pull requests ou abrindo issues para reportar problemas e sugestões.
