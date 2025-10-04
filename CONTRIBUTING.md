# Contribuindo para o N8N com Evolution API

Obrigado por considerar contribuir para este projeto! Toda contribuição é bem-vinda.

## Como Contribuir

### Reportando Bugs

Se você encontrou um bug, por favor abra uma [issue](https://github.com/RenantDev/n8n_ads/issues) incluindo:

- Descrição clara do problema
- Passos para reproduzir
- Comportamento esperado vs comportamento atual
- Versões do Docker e Docker Compose
- Logs relevantes (use `docker compose logs`)

### Sugerindo Melhorias

Sugestões de melhorias são sempre bem-vindas! Abra uma [issue](https://github.com/RenantDev/n8n_ads/issues) com:

- Descrição clara da melhoria
- Justificativa (por que seria útil)
- Exemplos de uso, se aplicável

### Pull Requests

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Faça commit das suas alterações (`git commit -m 'Adiciona MinhaFeature'`)
4. Faça push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

#### Diretrizes para Pull Requests

- Mantenha as alterações focadas e específicas
- Atualize a documentação se necessário
- Teste suas alterações antes de submeter
- Siga as convenções de código existentes
- Descreva claramente o que sua PR faz e por quê

## Desenvolvimento

### Configurando o Ambiente de Desenvolvimento

1. Clone o repositório:
   ```bash
   git clone https://github.com/RenantDev/n8n_ads.git
   cd n8n_ads
   ```

2. Execute o script de setup:
   ```bash
   ./setup.sh
   ```

3. Inicie os serviços:
   ```bash
   docker compose up -d
   ```

### Estrutura do Projeto

- `docker-compose.yml`: Configuração dos serviços
- `Dockerfile.evolution`: Build customizado da Evolution API
- `setup.sh`: Script de configuração inicial
- `.env.example`: Template de variáveis de ambiente

### Testando

Antes de submeter um PR, certifique-se de que:

- Os containers iniciam corretamente
- Não há erros nos logs
- As funcionalidades existentes continuam funcionando
- Sua alteração funciona conforme esperado

## Código de Conduta

Este projeto adere a um Código de Conduta. Ao participar, você deve respeitar este código.

## Dúvidas?

Se você tiver dúvidas, sinta-se à vontade para abrir uma [issue](https://github.com/RenantDev/n8n_ads/issues) com a tag `question`.
