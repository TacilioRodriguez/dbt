# Projeto de ETL com dbt e Databricks

Este projeto utiliza o dbt (Data Build Tool) para realizar a modelagem de dados na plataforma Databricks, seguindo a arquitetura Medalhão (Bronze, Silver, Gold).

## 🏗️ Arquitetura

A modelagem dos dados está organizada da seguinte forma:

- **Bronze 🥉**: Tabelas com dados brutos, ingeridos diretamente das fontes originais (arquivos CSV) sem transformação. O objetivo é manter uma cópia fiel e histórica dos dados.
- **Silver 🥈**: Tabelas intermediárias onde os dados da camada Bronze são limpos, padronizados, tipados e enriquecidos. Esta camada serve como uma fonte única de verdade para análises.
- **Gold 🥇**: Tabelas finais, agregadas e prontas para o consumo. Contêm métricas de negócio e são otimizadas para serem usadas por ferramentas de BI, dashboards e análises de negócio.

## ✅ Pré-requisitos

Antes de começar, garanta que você tenha os seguintes pré-requisitos instalados e configurados:

- [Python](https://www.python.org/downloads/) (versão 3.8 ou superior)
- [Git](https://git-scm.com/downloads/)
- Acesso a um workspace do Databricks com o Unity Catalog ativado.
- Permissões para criar e usar um SQL Warehouse no Databricks.

## 1. Configuração do Ambiente Local

### a. Clone o Repositório

```bash
git clone <URL_DO_SEU_REPOSITORIO>
cd <NOME_DO_DIRETORIO_DO_PROJETO>
```

### b. Crie e Ative um Ambiente Virtual

Para evitar conflitos de dependências, é altamente recomendado usar um ambiente virtual.

```bash
# Crie o ambiente virtual
python3 -m venv venv

# Ative o ambiente virtual (macOS/Linux)
source venv/bin/activate

# Para Windows, use:
# venv\Scripts\activate
```

### c. Instale as Dependências

Este projeto utiliza um arquivo `requirements.txt` com o seguinte conteúdo:

```plaintext
dbt-core
dbt-databricks
```

Com o ambiente virtual ativo, instale as dependências:

```bash
pip install -r requirements.txt
```

## 2. Configuração da Conexão (dbt Profile)

O dbt precisa de credenciais para se conectar ao seu workspace do Databricks.

### a. Localize ou Crie o Arquivo `profiles.yml`

O dbt procura esse arquivo no diretório `~/.dbt/`. Se a pasta não existir, crie-a.

### b. Adicione as Credenciais do Databricks

```yaml
# ~/.dbt/profiles.yml

etl:
  target: dev
  outputs:
    dev:
      type: databricks
      catalog: "<SEU_CATALOGO>"         # Ex: dbt_dev
      schema: "silver"                 # Schema padrão para desenvolvimento e materialização dos modelos
      host: "<SEU_DATABRICKS_HOST>"    # Encontrado no seu SQL Warehouse em "Connection details"
      http_path: "<SEU_HTTP_PATH>"     # Encontrado no seu SQL Warehouse em "Connection details"
      token: "<SEU_TOKEN_DE_ACESSO>"   # Seu Personal Access Token gerado no Databricks
```

**Onde encontrar essas informações:**

- `host` e `http_path`: vá em *SQL Warehouses* → selecione seu warehouse → *Connection details*.
- `token`: vá em *User Settings* → *Developer* → gere um *Personal Access Token*.

## 3. Comandos Essenciais do Projeto

### a. Testar a Conexão

```bash
dbt debug
```

Se tudo estiver correto, a saída será: `All checks passed!`.

### b. Executar os Modelos

```bash
dbt run
```

### c. Executar um Modelo Específico

```bash
dbt run --select <nome_do_modelo>

# Exemplo:
dbt run --select stg_vendas
```

### d. Executar Testes de Dados

```bash
dbt test
```
