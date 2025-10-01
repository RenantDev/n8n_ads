# Descrição do Projeto N8N com Evolution API e Ollama

Este projeto consiste em um ambiente integrado que combina o poder do n8n, uma plataforma de automação de fluxos de trabalho, com a Evolution API, uma interface para automação de WhatsApp, e o Ollama, uma ferramenta para executar modelos de linguagem (LLMs) localmente.

## Visão Geral

O projeto é estruturado em containers Docker, proporcionando um ambiente isolado e facilmente replicável. Ele inclui:

- **N8N**: Ferramenta de automação de fluxos de trabalho com interface visual
- **Evolution API**: API para integração com WhatsApp
- **PostgreSQL**: Banco de dados
- **Redis**: Cache
- **Ollama**: (a ser implementado) Ferramenta para executar modelos de linguagem localmente

## Objetivo

Este ambiente permite criar e gerenciar facilmente automações e integrações entre diferentes plataformas, com foco especial no estudo das possibilidades do n8n utilizando o WhatsApp como canal de comunicação e o Ollama para adicionar capacidades de IA local sem dependência de APIs externas.

## Funcionalidades Planejadas

- Automação de respostas no WhatsApp
- Processamento de linguagem natural com modelos locais
- Integração entre diferentes sistemas e plataformas
- Fluxos de trabalho personalizáveis com interface visual
- Análise de sentimentos e categorização de mensagens
- Geração de conteúdo assistida por IA 