# Sentry for Embrapa I/O

Configuração e recuparação da instância do Sentry (_error tracking_) no ecossistema do Embrapa I/O.

<!-- Observação: Em ambiantes **Apple Silicon** será necessário utilizar o UTM com QEMU (emulando a arquitetura AMD64). Nestes casos, habilite 4 CPUs, pelo menos 8GB de RAM e configure a VM para utilizar o processador "`Intel Core Processor (Haswell) (Haswell-v1)`" e habilite os seguintes recursos: `sse4.2`, `sse4.1`, `avx`, `avx2` e `ssse3`. -->

Guia para instanciação do Sentry:

### 1. Instale a partir do repositório oficial:

Leia a [documentação](https://develop.sentry.dev/self-hosted/) para instalar a última versão do Sentry a partir do [repositório público](https://github.com/getsentry/self-hosted/) utilizando o Docker.
