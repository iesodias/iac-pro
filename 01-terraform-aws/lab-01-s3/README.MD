# Lab S3 Basic - AWS

## Setup Rápido do Ambiente

Antes de executar os comandos do Terraform, certifique-se de que seu terminal está autenticado na AWS. Configure suas credenciais:

```bash
aws configure
# Ou via variáveis de ambiente:
export AWS_ACCESS_KEY_ID="sua-access-key"
export AWS_SECRET_ACCESS_KEY="sua-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

Verifique se as credenciais estão válidas:

```bash
aws sts get-caller-identity
```

Se aparecer a ARN e o Account ID, pode prosseguir com o Terraform. Para detalhes adicionais veja a seção "Configurar Credenciais AWS" mais abaixo.

Este lab demonstra como criar e configurar um bucket S3 na AWS com boas práticas de segurança usando Terraform.

## Recursos Criados

- **S3 Bucket** com nome único
- **Versionamento** habilitado para histórico de objetos
- **Criptografia Server-Side (SSE-S3)** com AES256
- **Block Public Access** configurado (todas as opções bloqueadas)
- **Lifecycle Rules**:
  - Transição de versões antigas para STANDARD_IA após 30 dias
  - Transição para GLACIER após 90 dias
  - Exclusão de versões antigas após 180 dias
  - Limpeza de uploads incompletos após 7 dias

## Estrutura de Arquivos

```
lab-s3-basic/
├── providers.tf              # Configuração do provider AWS
├── variables.tf              # Variáveis do lab
├── main.tf                   # Recursos S3
├── outputs.tf                # Outputs do bucket
├── terraform.tfvars          # Valores das variáveis
└── terraform.tfvars.example  # Exemplo de configuração
```

## Pré-requisitos

1. **Terraform** instalado (>= 1.0.0)
2. **AWS CLI** configurado com credenciais válidas
3. **Permissões IAM** necessárias:
   - `s3:CreateBucket`
   - `s3:PutBucketVersioning`
   - `s3:PutEncryptionConfiguration`
   - `s3:PutBucketPublicAccessBlock`
   - `s3:PutLifecycleConfiguration`

## Configurar Credenciais AWS

```bash
# Opção 1: Configurar via AWS CLI
aws configure

# Opção 2: Exportar variáveis de ambiente
export AWS_ACCESS_KEY_ID="sua-access-key"
export AWS_SECRET_ACCESS_KEY="sua-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Passos para Executar o Lab

### 1. Configurar Variáveis

Edite o arquivo `terraform.tfvars` e altere o `bucket_name` para um nome **globalmente único**:

```hcl
bucket_name = "meu-bucket-terraform-2025-xyz"  # Altere aqui
```

> **IMPORTANTE**: Nomes de bucket S3 devem ser únicos globalmente na AWS.

### 2. Formatar Código

```bash
terraform fmt -recursive
```

### 3. Inicializar Terraform

```bash
terraform init
```

### 4. Validar Configuração

```bash
terraform validate
```

### 5. Gerar Plano de Execução

```bash
terraform plan -var-file="terraform.tfvars" -out=tfplan
```

### 6. Aplicar Mudanças

```bash
terraform apply "tfplan"
```

## Testar o Bucket

### 1. Listar Informações do Bucket

```bash
terraform output
```

### 2. Fazer Upload de um Arquivo de Teste

```bash
echo "Hello from Terraform Lab!" > test-file.txt
aws s3 cp test-file.txt s3://$(terraform output -raw bucket_id)/
```

### 3. Listar Objetos no Bucket

```bash
aws s3 ls s3://$(terraform output -raw bucket_id)/
```

### 4. Verificar Versionamento

```bash
aws s3api list-object-versions \
  --bucket $(terraform output -raw bucket_id) \
  --prefix test-file.txt
```

### 5. Verificar Configurações de Segurança

```bash
# Block Public Access
aws s3api get-public-access-block \
  --bucket $(terraform output -raw bucket_id)

# Encryption
aws s3api get-bucket-encryption \
  --bucket $(terraform output -raw bucket_id)

# Versioning
aws s3api get-bucket-versioning \
  --bucket $(terraform output -raw bucket_id)
```

## Limpar Recursos

```bash
terraform destroy -var-file="terraform.tfvars" -auto-approve
```

## Estimativa de Custos

- **S3 Standard Storage**: ~$0.023/GB/mês (primeiros 50TB)
- **Versionamento**: Armazena todas as versões (cada versão conta como objeto separado)
- **Requests**: GET $0.0004/1000 requests, PUT $0.005/1000 requests
- **Data Transfer**: Saída de dados para internet ~$0.09/GB

> Para este lab de testes com poucos objetos pequenos, o custo mensal será < $1.

## Boas Práticas Implementadas

✅ **Criptografia obrigatória** (SSE-S3 com AES256)  
✅ **Acesso público bloqueado** (previne exposição acidental)  
✅ **Versionamento habilitado** (proteção contra deleção/sobrescrita)  
✅ **Lifecycle rules** (otimização de custos com transição de classes)  
✅ **Tags organizacionais** (rastreamento de custos e recursos)  
✅ **Bucket key habilitado** (reduz custos de KMS requests)  
✅ **Limpeza automática** (uploads incompletos removidos após 7 dias)

## Próximos Passos

1. Adicionar **bucket policy** para controle de acesso granular
2. Configurar **logging** de acesso ao bucket
3. Implementar **replicação cross-region** (CRR)
4. Adicionar **object lock** para compliance WORM
5. Configurar **event notifications** com SNS/SQS/Lambda

## Troubleshooting

### Erro: "BucketAlreadyExists"
O nome do bucket já está em uso. Altere `bucket_name` em `terraform.tfvars`.

### Erro: "AccessDenied"
Verifique se suas credenciais AWS têm permissões suficientes para criar buckets S3.

### Erro: "InvalidBucketName"
Nomes de bucket devem:
- Ter entre 3-63 caracteres
- Conter apenas letras minúsculas, números, hífens e pontos
- Começar e terminar com letra ou número
- Não ter formatação de IP (ex: 192.168.1.1)

## Referências

- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [Terraform AWS Provider - S3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [S3 Best Practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/best-practices.html)
