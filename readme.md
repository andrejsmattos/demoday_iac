# IaC — DemoDay Frontend

Infraestrutura como Código para provisionar e configurar o ambiente de produção do [DemoDay Frontend](https://github.com/YagoMaia/demoday_frontend) na AWS, utilizando **Terraform** e **Ansible**.

## Tecnologias

- [Terraform](https://developer.hashicorp.com/terraform) — provisionamento da infraestrutura na AWS
- [Ansible](https://docs.ansible.com/) — configuração do servidor e deploy da aplicação
- [AWS EC2](https://aws.amazon.com/ec2/) — instância t2.micro com Amazon Linux 2023

## Arquitetura

```
GitHub (código)
      ↓
Terraform → provisiona EC2 na AWS
      ↓
Ansible → instala Node.js, pnpm, PM2 → clona repo → build → sobe app
      ↓
Aplicação disponível em http://IP_DA_EC2:3000
```

## Estrutura de Arquivos

```
iac/
├── .gitignore
├── README.md
│
├── terraform/
│   ├── provider.tf         # Provedor AWS e região (us-east-1)
│   ├── key_pair.tf         # Geração automática do par de chaves RSA
│   ├── security_group.tf   # Regras de firewall (HTTP :80, SSH :22, Next.js :3000)
│   ├── data.tf             # Busca dinâmica da AMI Amazon Linux 2023
│   ├── ec2.tf              # Instância EC2 t2.micro
│   ├── outputs.tf          # IP público e URL da aplicação
│   └── variables.tf        # Variáveis (ex: seu IP público para SSH)
│
└── ansible/
    ├── ansible.cfg         # Desabilita verificação de host key
    ├── inventory           # IP da instância EC2 criada pelo Terraform
    └── playbook.yml        # Instalação do ambiente e deploy do Next.js
```

## Variáveis de Conexão EC2

Após executar `terraform apply`, as seguintes variáveis serão geradas automaticamente:

| Variável | Descrição | Exemplo |
|----------|-----------|---------|
| `EC2_HOST` | IP público da instância EC2 | `54.123.45.67` |
| `EC2_USERNAME` | Usuário padrão para acesso SSH | `ec2-user` |
| `EC2_SSH_KEY` | Caminho da chave privada SSH | `./keys/ec2-key.pem` |

### Como acessar o servidor via SSH

```bash
ssh -i ./keys/ec2-key.pem ec2-user@<EC2_HOST>
```

### Exemplo com valores reais

```bash
ssh -i ./keys/ec2-key.pem ec2-user@54.123.45.67
```

## Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/downloads) instalado
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/) instalado (Linux/WSL obrigatório)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) instalado e configurado
- Conta AWS com permissões de EC2

## Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/andrejsmattos/demoday_iac.git
cd demoday_iac
```

### 2. Configure suas credenciais AWS

```bash
aws configure
# Informe: Access Key ID, Secret Access Key, região (us-east-1), output (json)
```

### 3. Defina seu IP público no Terraform

Edite `terraform/variables.tf` e substitua pelo seu IP (consulte em https://www.whatismyip.com/):

```hcl
default = "SEU_IP_AQUI/32"
```

### 4. Provisione a infraestrutura

```bash
cd terraform/

terraform init
terraform plan
terraform apply   # confirme com "yes"
```

O output exibirá o IP público da instância e a URL da aplicação. **Anote o IP.**

### 5. Configure o inventário do Ansible

Edite `ansible/inventory` e substitua `IP_DA_EC2` pelo IP do passo anterior:

```ini
[all]
IP_DA_EC2 ansible_user=ec2-user ansible_ssh_private_key_file=/home/SEU_USUARIO/ec2-instance-key.pem
```

> A chave `ec2-instance-key.pem` é gerada automaticamente pelo Terraform.

### 6. Execute o deploy

```bash
cd ../ansible/

# Testar conectividade
ansible -i inventory all -m ping

# Executar o playbook
ansible-playbook -i inventory playbook.yml
```

### 7. Acesse a aplicação

Abra no navegador:

```
http://IP_DA_EC2:3000
```

> ⚠️ Digite `http://` explicitamente — navegadores modernos podem forçar HTTPS.

### 8. Destruir a infraestrutura

Quando não precisar mais, destrua os recursos para evitar cobranças na AWS:

```bash
cd terraform/
terraform destroy
```

## O que o Ansible provisiona

| Etapa | O que faz |
|-------|-----------|
| 1 | Atualiza todos os pacotes do sistema |
| 2 | Instala Git, tar e gzip |
| 3 | Instala Node.js 20 via NodeSource |
| 4 | Instala pnpm e PM2 globalmente |
| 5 | Clona o repositório `demoday_frontend` |
| 6 | Executa `pnpm install` e `pnpm build` |
| 7 | Sobe a aplicação com PM2 (persiste após reboot) |

## Recursos AWS criados pelo Terraform

| Recurso | Descrição |
|---------|-----------|
| `aws_instance` | EC2 t2.micro — Amazon Linux 2023 |
| `aws_key_pair` | Par de chaves RSA gerado automaticamente |
| `aws_security_group` (HTTP) | Libera porta 80 para qualquer origem |
| `aws_security_group` (SSH) | Libera porta 22 apenas para seu IP |
| `aws_security_group` (Next.js) | Libera porta 3000 para qualquer origem |
| `aws_security_group` (Egress) | Libera todo tráfego de saída |

## Referências

- [Documentação do Terraform](https://developer.hashicorp.com/terraform)
- [Provider AWS do Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Documentação do Ansible](https://docs.ansible.com/)
- [Documentação da AWS](https://docs.aws.amazon.com/pt_br/)
- [Repositório do Frontend](https://github.com/YagoMaia/demoday_frontend)
