# Sentry for Embrapa I/O

Configuração e recuparação da instância do **Sentry** (_error tracking_) no ecossistema do **Embrapa I/O**.

<!-- Observação: Em ambiantes **Apple Silicon** será necessário utilizar o UTM com QEMU (emulando a arquitetura AMD64). Nestes casos, habilite 4 CPUs, pelo menos 8GB de RAM e configure a VM para utilizar o processador "`Intel Core Processor (Haswell) (Haswell-v1)`" e habilite os seguintes recursos: `sse4.2`, `sse4.1`, `avx`, `avx2` e `ssse3`. -->

## Ambiente de Desenvolvimento

1. Crie uma VM local em **Ubuntu Server 24.04 LTS**:
   
   ```bash
   sudo su -
   apt update && apt upgrade -y && apt dist-upgrade -y && apt autoremove -y && apt autoclean
   apt install openssh-server vim
   ```

2. Siga o passo-a-passo da [documentação oficial](https://develop.sentry.dev/self-hosted/) e instale a última versão do Sentry:

   ```bash
   VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/getsentry/self-hosted/releases/latest) && \
   VERSION=${VERSION##*/} && \
   git clone https://github.com/getsentry/self-hosted.git sentry && \
   cd sentry && \
   git checkout ${VERSION} && \
   ./install.sh
   ```

3. Após finalizar a instalação, faça:

   ```bash
   docker compose up --wait
   ```
