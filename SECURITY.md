# Política de Segurança

## Versões Suportadas

Este projeto usa as seguintes versões de componentes:

| Componente | Versão | Suportado |
| ---------- | ------ | --------- |
| N8N | Latest | ✅ |
| Evolution API | v1.8.7 | ✅ |
| PostgreSQL | 17 | ✅ |
| MongoDB | 6 | ✅ |
| Redis | Latest | ✅ |

## Reportando uma Vulnerabilidade

A segurança deste projeto é levada a sério. Se você descobriu uma vulnerabilidade de segurança, por favor siga estas diretrizes:

### Como Reportar

1. **NÃO** crie uma issue pública para vulnerabilidades de segurança
2. Envie um e-mail para os mantenedores do projeto através das issues privadas do GitHub
3. Inclua o máximo de informações possível:
   - Descrição da vulnerabilidade
   - Passos para reproduzir
   - Potencial impacto
   - Sugestões de correção (se houver)

### O que esperar

- Confirmação de recebimento em até 48 horas
- Avaliação inicial da vulnerabilidade em até 7 dias
- Comunicação regular sobre o progresso da correção
- Crédito público (se desejado) quando a vulnerabilidade for corrigida

## Boas Práticas de Segurança

Ao usar este projeto, siga estas práticas recomendadas:

### Configuração

- **Altere todas as senhas padrão** no arquivo `.env`
- **Use senhas fortes** para PostgreSQL, MongoDB e outras credenciais
- **Nunca commite o arquivo `.env`** para o repositório
- **Gere uma API Key forte** para a Evolution API
- **Mantenha os containers atualizados** regularmente

### Ambiente de Produção

- **Use HTTPS/SSL** para todas as comunicações
- **Configure um firewall** adequado
- **Limite o acesso** às portas apenas para IPs confiáveis
- **Faça backups regulares** dos dados
- **Monitore os logs** para atividades suspeitas
- **Use variáveis de ambiente** para informações sensíveis
- **Mantenha o Docker** e **Docker Compose** atualizados

### Arquivos Sensíveis

Os seguintes arquivos/diretórios contêm informações sensíveis e devem ser protegidos:

- `.env` - Variáveis de ambiente e credenciais
- `postgres_data/` - Dados do PostgreSQL
- `mongodb_data/` - Dados do MongoDB
- `redis_data/` - Dados do Redis
- `n8n_data/` - Workflows e credenciais do N8N
- `evolution_instances/` - Sessões do WhatsApp

Certifique-se de que esses arquivos estão no `.gitignore` e têm permissões apropriadas.

## Atualizações de Segurança

Atualizações de segurança serão comunicadas através de:

- Releases do GitHub
- Issues marcadas com `security`
- Atualizações no README.md

## Recursos Adicionais

- [Docker Security Best Practices](https://docs.docker.com/engine/security/)
- [N8N Security Guide](https://docs.n8n.io/hosting/security/)
- [PostgreSQL Security](https://www.postgresql.org/docs/current/security.html)
- [MongoDB Security](https://www.mongodb.com/docs/manual/security/)
