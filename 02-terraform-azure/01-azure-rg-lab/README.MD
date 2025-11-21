# Lab Azure Resource Group - Azure

Este lab demonstra como criar e gerenciar um Resource Group no Microsoft Azure usando Terraform, com um fluxo simples e repetível de init → plan → apply → destroy.

## Recursos Criados

- Resource Group (grupo de recursos) com nome e região parametrizáveis

## Estrutura de Arquivos

```
01-azure-rg-lab/
├── versions.tf    # Versões mínimas do Terraform e provider azurerm
├── variables.tf   # Variáveis do lab (nome do RG e região)
├── main.tf        # Recurso azurerm_resource_group
├── outputs.tf     # Outputs do lab (ex.: ID do RG)
└── terraform.tfvars  # (opcional) Valores das variáveis
```

## Pré-requisitos

1. Terraform instalado (>= 1.12.2 conforme `versions.tf`)
2. Azure CLI instalado e autenticado
3. Uma assinatura do Azure com permissões para criar Resource Groups
   - `Microsoft.Resources/subscriptions/resourceGroups/*`

## Autenticar no Azure

Você pode autenticar com a CLI interativa ou com Service Principal.

```bash
# Opção 1: Login interativo (recomendado para testes)
az login

# (Opcional) Selecionar a assinatura certa
az account list --output table
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"

# Opção 2: Service Principal (CI/CD)
az login \
  --service-principal \
  --username <APP_ID> \
  --password <PASSWORD> \
  --tenant <TENANT_ID>
```

## Passos para Executar o Lab

### 1) Configurar Variáveis

Crie (ou edite) `terraform.tfvars` com os valores desejados:

```hcl
resource_group_name = "rg-lab-azure-terraform"
location            = "East US"   # Ex.: "East US", "Brazil South", "West Europe"
```

Dica: Liste regiões disponíveis com:

```bash
az account list-locations --query "[].{name:name, displayName:displayName}" -o table
```

### 2) Formatar Código

```bash
terraform fmt -recursive
```

### 3) Inicializar Terraform

```bash
terraform init
```

### 4) Validar Configuração

```bash
terraform validate
```

### 5) Gerar Plano de Execução

```bash
terraform plan -var-file="terraform.tfvars" -out=tfplan
```

### 6) Aplicar Mudanças

```bash
terraform apply "tfplan"
```

## Testar o Resource Group

### 1) Ver outputs do Terraform

```bash
terraform output
```

### 2) Conferir o RG no Azure via CLI

```bash
# Opção A: Usando o ID retornado pelo Terraform
az resource show --ids "$(terraform output -raw resource_group_id)" -o jsonc

# Opção B: Pelo nome definido em terraform.tfvars (substitua <NOME_DO_RG>)
az group show --name "<NOME_DO_RG>" --output table
```

Observação: O output `resource_group_id` retorna o ID completo do recurso. Para consultar pelo nome diretamente, use o nome configurado em `terraform.tfvars`.

## Limpar Recursos

```bash
terraform destroy -var-file="terraform.tfvars" -auto-approve
```

## Estimativa de Custos

- Resource Groups não possuem custo direto. Custos são gerados pelos recursos criados dentro deles (neste lab não criamos recursos adicionais).

## Próximos Passos (Sugeridos)

1. Adicionar tags organizacionais ao Resource Group (ex.: `environment`, `owner`, `cost-center`)
2. Padronizar nomenclatura com um módulo de naming
3. Integrar backend remoto para estado (Terraform Cloud/Storage Account)
4. Integrar em pipeline CI/CD (Service Principal e variáveis seguras)
5. Criar recursos dentro do RG (ex.: VNet, Storage Account) em labs subsequentes

## Troubleshooting

- Erro: "No subscription found" ou permissão negada
  - Execute `az login` e `az account set --subscription ...` para garantir a assinatura correta.
- Erro de versão do provider/terraform
  - Verifique `versions.tf` e atualize sua versão local de Terraform.
- Local/Região inválida
  - Use `az account list-locations` para confirmar o nome da região (ex.: "East US", "Brazil South").
- Conflito de nome
  - Garanta que o `resource_group_name` escolhido não conflita com políticas/nomeações internas.

## Referências

- Azure Resource Manager - Resource groups: https://learn.microsoft.com/azure/azure-resource-manager/management/manage-resource-groups-portal
- Terraform Provider azurerm (Resource Group): https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
- Azure CLI (az group): https://learn.microsoft.com/cli/azure/group
