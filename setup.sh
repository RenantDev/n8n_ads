#!/bin/bash

# Cores para mensagens
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Verificar se o Docker está instalado
check_docker() {
    echo "Verificando se o Docker está instalado..."
    if command -v docker &> /dev/null; then
        echo -e "${GREEN}✓ Docker está instalado!${NC}"
        # Verificar se o serviço Docker está em execução
        if systemctl is-active --quiet docker || docker info &> /dev/null; then
            echo -e "${GREEN}✓ Serviço Docker está em execução!${NC}"
            return 0
        else
            echo -e "${RED}✗ Serviço Docker não está em execução. Inicie-o com 'sudo systemctl start docker' ou equivalente.${NC}"
            return 1
        fi
    else
        echo -e "${RED}✗ Docker não está instalado. Visite https://docs.docker.com/get-docker/ para instruções de instalação.${NC}"
        return 1
    fi
}

# Verificar se o Docker Compose está instalado
check_docker_compose() {
    echo "Verificando se o Docker Compose está instalado..."
    if docker compose version &> /dev/null; then
        echo -e "${GREEN}✓ Docker Compose está instalado!${NC}"
        return 0
    else
        echo -e "${RED}✗ Docker Compose não está instalado ou não é o plugin compose V2.${NC}"
        echo -e "${YELLOW}Consulte: https://docs.docker.com/compose/install/linux/#{NC}"
        return 1
    fi
}

# Verificar se as portas estão disponíveis
check_ports() {
    local ports=("5678" "8080" "5432" "6379" "27017")
    local services=("n8n" "Evolution API" "PostgreSQL" "Redis" "MongoDB")
    local all_clear=true
    
    echo "Verificando portas necessárias..."
    
    for i in "${!ports[@]}"; do
        local port="${ports[$i]}"
        local service="${services[$i]}"
        
        # Verificar se a porta está em uso (compatível com mais sistemas)
        if command -v netstat &>/dev/null; then
            if netstat -tuln | grep -q ":$port "; then
                echo -e "${RED}✗ Porta $port (${service}) já está em uso!${NC}"
                all_clear=false
            else
                echo -e "${GREEN}✓ Porta $port (${service}) está disponível!${NC}"
            fi
        elif command -v ss &>/dev/null; then
            if ss -tuln | grep -q ":$port "; then
                echo -e "${RED}✗ Porta $port (${service}) já está em uso!${NC}"
                all_clear=false
            else
                echo -e "${GREEN}✓ Porta $port (${service}) está disponível!${NC}"
            fi
        elif command -v lsof &>/dev/null; then
            if lsof -i :$port -sTCP:LISTEN &>/dev/null; then
                echo -e "${RED}✗ Porta $port (${service}) já está em uso!${NC}"
                all_clear=false
            else
                echo -e "${GREEN}✓ Porta $port (${service}) está disponível!${NC}"
            fi
        else
            # Se nenhuma ferramenta de verificação de porta estiver disponível
            echo -e "${YELLOW}? Não foi possível verificar se a porta $port (${service}) está disponível. Verifique manualmente.${NC}"
        fi
    done
    
    if [ "$all_clear" = true ]; then
        echo -e "${GREEN}Todas as portas necessárias estão disponíveis!${NC}"
        return 0
    else
        echo -e "${YELLOW}Algumas portas necessárias estão em uso. Libere-as antes de continuar.${NC}"
        return 1
    fi
}

# Função para gerar uma hash aleatória
generate_hash() {
    openssl rand -hex 16
}

# Executar verificações
docker_ok=false
compose_ok=false
ports_ok=false

check_docker && docker_ok=true
check_docker_compose && compose_ok=true
check_ports && ports_ok=true

if [ "$docker_ok" = false ] || [ "$compose_ok" = false ]; then
    echo -e "${RED}Requisitos de sistema não atendidos. Resolva os problemas acima antes de continuar.${NC}"
    exit 1
fi

if [ "$ports_ok" = false ]; then
    echo -e "${YELLOW}Aviso: Algumas portas necessárias estão em uso.${NC}"
    read -p "Deseja continuar mesmo assim? (s/N): " choice
    case "$choice" in
        s|S|sim|Sim|SIM )
            echo "Continuando a configuração..."
            ;;
        * )
            echo "Configuração cancelada."
            exit 1
            ;;
    esac
fi

# Gera uma hash para AUTHENTICATION_API_KEY
API_KEY_HASH=$(generate_hash)

# Cria o arquivo .env.example se não existir
if [ ! -f .env.example ]; then
    cat > .env.example << EOF
# PostgreSQL Configuration (para n8n)
POSTGRES_DB=n8n
POSTGRES_USER=n8n
POSTGRES_PASSWORD=n8npw
EVOLUTION_DB=evolution

# Evolution API v1.8.7 - Authentication
AUTHENTICATION_API_KEY=${API_KEY_HASH}

# Evolution API - Database Save Options
DATABASE_SAVE_DATA_INSTANCE=true
DATABASE_SAVE_DATA_NEW_MESSAGE=true
DATABASE_SAVE_MESSAGE_UPDATE=true
DATABASE_SAVE_DATA_CONTACTS=true
DATABASE_SAVE_DATA_CHATS=true
DATABASE_SAVE_DATA_LABELS=true
DATABASE_SAVE_DATA_HISTORIC=true

# Evolution API - Instance Management
DEL_INSTANCE=false

# Evolution API - Logs
LOG_LEVEL=ERROR,WARN,DEBUG,INFO,LOG,VERBOSE,DARK,WEBHOOKS
LOG_COLOR=true
EOF
    echo -e "${GREEN}Arquivo .env.example criado com sucesso!${NC}"
fi

# Copia .env.example para .env se .env não existir
if [ ! -f .env ]; then
    cp .env.example .env
    echo -e "${GREEN}Arquivo .env criado com sucesso!${NC}"
else
    # Se o arquivo .env já existe, apenas atualiza a AUTHENTICATION_API_KEY
    if grep -q "AUTHENTICATION_API_KEY=suachaveapi" .env; then
        sed -i "s/AUTHENTICATION_API_KEY=suachaveapi/AUTHENTICATION_API_KEY=${API_KEY_HASH}/" .env
        echo -e "${GREEN}AUTHENTICATION_API_KEY atualizada com uma nova hash!${NC}"
    fi
    echo -e "${GREEN}Arquivo .env já existe. Verificação de chave API concluída.${NC}"
fi

echo -e "${GREEN}Configuração concluída. Você pode executar 'docker compose up' agora.${NC}"
echo -e "${YELLOW}Hash gerada para AUTHENTICATION_API_KEY:${NC} ${API_KEY_HASH}"

# Perguntar se o usuário deseja iniciar os serviços Docker
echo ""
read -p "Deseja iniciar os serviços Docker agora? (s/N): " start_docker
case "$start_docker" in
    s|S|sim|Sim|SIM )
        echo -e "${GREEN}Iniciando serviços Docker...${NC}"
        docker compose up -d
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Serviços iniciados com sucesso!${NC}"
            echo ""
            echo -e "${GREEN}=== Acesso aos Serviços ===${NC}"
            echo -e "  - n8n: ${YELLOW}http://localhost:5678${NC}"
            echo -e "  - Evolution API: ${YELLOW}http://localhost:8080${NC}"
            echo -e "  - Evolution Manager: ${YELLOW}http://localhost:8080/manager${NC}"
            echo -e "  - Evolution Swagger: ${YELLOW}http://localhost:8080/docs${NC}"
            echo ""
            echo -e "${GREEN}=== Informações da Stack ===${NC}"
            echo -e "  - Evolution API: ${YELLOW}v1.8.7${NC}"
            echo -e "  - MongoDB: ${YELLOW}v6${NC} (porta 27017)"
            echo -e "  - PostgreSQL: ${YELLOW}v17${NC} (porta 5432 - para n8n)"
            echo -e "  - Redis: ${YELLOW}Alpine${NC} (porta 6379)"
            echo ""
            echo -e "${GREEN}=== Chave de Autenticação ===${NC}"
            echo -e "  API Key: ${YELLOW}${API_KEY_HASH}${NC}"
        else
            echo -e "${RED}✗ Houve um erro ao iniciar os serviços. Verifique o log acima.${NC}"
        fi
        ;;
    * )
        echo -e "${YELLOW}Para iniciar os serviços posteriormente, execute:${NC} docker compose up -d"
        ;;
esac 