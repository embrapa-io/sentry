# Sentry for Embrapa I/O

Configuração e recuparação da instância do [**Sentry**](https://sentry.io) (_error tracking_) no ecossistema do **Embrapa I/O**.

## Instalação

> **Atenção!** Em **ambiente de desenvolvimento** instale o **Sentry** diretamente no Docker do seu sistema operacional (não necessariamente em uma VM). Esta dica é válida principalmente para quem utiliza **Apple Silicon**. Em outras palavras, neste caso avance para o "**Passo 3**".

1. Crie uma VM local em **Ubuntu Server 24.04 LTS**:
   
   ```bash
   sudo su -
   apt update && apt upgrade -y && apt dist-upgrade -y && apt autoremove -y && apt autoclean
   apt install ca-certificates curl git openssh-server vim
   ```

2. Instale a última versão do Docker, seguindo a [documentação oficial](https://docs.docker.com/engine/install/ubuntu/):

   Configure o repositório oficial:

   ```bash
   for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done && \
   install -m 0755 -d /etc/apt/keyrings && \
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
   chmod a+r /etc/apt/keyrings/docker.asc && \
   echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
     $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
     tee /etc/apt/sources.list.d/docker.list > /dev/null && \
   apt update
   ```

   Instale a última versão do Docker:

   ```bash
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```

3. Siga o passo-a-passo da [documentação oficial](https://develop.sentry.dev/self-hosted/) e instale a última versão do Sentry:

   ```bash
   VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/getsentry/self-hosted/releases/latest) && \
   VERSION=${VERSION##*/} && \
   git clone https://github.com/getsentry/self-hosted.git sentry && \
   cd sentry && \
   git checkout ${VERSION} && \
   ./install.sh
   ```

4. Configurações:

   - Alterar no arquivo `sentry/sentry.conf.py` a variável `SENTRY_SINGLE_ORGANIZATION = False`.
   - Ajustar as configurações de **SMTP** em `sentry/config.yaml` e também:
   
   ```yaml
   # Para não dar erro de CSRF:
   # https://github.com/getsentry/self-hosted/issues/2751
   system.url-prefix: https://nginx.sentry.orb.local
   ```
   
   - Ajuste no `.env` na raiz da aplicação:
  
   ```ini
   COMPOSE_PROJECT_NAME=sentry
   # Se estiver em ambiente de desenvolvimento:
   SENTRY_MAIL_HOST=host.docker.internal
   ```
   
7. Após finalizar a instalação, faça:

   ```bash
   docker compose up --wait
   ```
