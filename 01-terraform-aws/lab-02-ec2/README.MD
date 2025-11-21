# Lab 02 - EC2 Básico na AWS

Este laboratório demonstra como provisionar uma instância EC2 simples utilizando Terraform, seguindo a mesma estrutura do lab anterior (S3). Ele é pensado para iniciantes e foca apenas nos recursos essenciais.

## Pré-requisitos
- Conta AWS com credenciais configuradas localmente (CLI ou variáveis de ambiente).
- Terraform 1.0+ instalado.
- Acesso à internet para baixar o provider AWS.

## Estrutura do diretório
```
lab-02-ec2/
├── manifestos/
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── README.md
```

No diretório `manifestos/` estão todos os arquivos necessários para o Terraform. É nele que você deve executar os comandos.

## Variáveis principais (`variables.tf`)
- `aws_region`: região onde os recursos serão criados (padrão `us-east-1`).
- `environment`: etiqueta para identificar o ambiente (`dev`, `staging`, etc.).
- `instance_name`: tag Name aplicada à instância.
- `instance_type`: tipo da EC2, padrão `t3.micro` (elegível ao free tier).
- `allowed_ssh_cidr`: bloco CIDR liberado para acesso SSH (atenção ao usar `0.0.0.0/0`).
- `key_pair_name`: nome de uma key pair existente na conta (pode ser `null` para não associar).
- `root_volume_size`: tamanho do disco root em GB (padrão 30 GB).
- `tags`: mapa com tags adicionais.

As variáveis já possuem valores de exemplo em `terraform.tfvars`. Ajuste conforme necessidade (principalmente `key_pair_name` para conseguir acessar via SSH).

## Passo a passo
1. **Inicializar o Terraform**
   ```bash
   cd 01-terraform-aws/lab-02-ec2/manifestos
   terraform init
   ```
   Este comando baixa o provider AWS e prepara o diretório para uso.

2. **Visualizar o plano de execução**
   ```bash
   terraform plan
   ```
   Verifique se os recursos que serão criados fazem sentido. Devem aparecer apenas um Security Group e uma EC2.

3. **Aplicar o plano**
   ```bash
   terraform apply -auto-approve
   ```
   Aguarde a criação da instância. Ao final, o Terraform mostrará os outputs com ID, IP público/privado e DNS.

4. **Validar a instância**
   - Consulte a AWS Console ou use `aws ec2 describe-instances` para confirmar o estado.
   - Se configurou `key_pair_name`, conecte via SSH usando o IP público retornado.

5. **Destruir recursos ao finalizar o lab**
   ```bash
   terraform destroy -auto-approve
   ```
   Isso remove a instância e o security group, evitando custos.

## Dicas
- Utilize workspaces ou perfis AWS diferentes se estiver alternando entre labs.
- Se o `terraform destroy` travar ao remover o Security Group, verifique se ainda há instâncias anexadas e tente novamente.
- Mantenha o arquivo `.terraform.lock.hcl` versionado junto com os manifestos.

Bom estudo!
