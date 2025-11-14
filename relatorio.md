# Relatório da Atividade Docker-Django

## Sumário

1. [Dockerfile.dev criado com base em Fedora](../2025.2-Atividades-05-Docker-Django/relatorio.md#dockerfiledev-criado-com-base-em-fedora)

1. [Dockerfile.prod criado com base em Fedora](../2025.2-Atividades-05-Docker-Django/relatorio.md#dockerfileprod-criado-com-base-em-fedora)

1. [Python e Django instalados](../2025.2-Atividades-05-Docker-Django/relatorio.md#python-e-django-instalados)

1. [Projeto Django criado (myproject)](../2025.2-Atividades-05-Docker-Django/relatorio.md#projeto-django-criado-myproject)

1. [Aplicação Django criada (webapp)](../2025.2-Atividades-05-Docker-Django/relatorio.md#aplicação-django-criada-webapp)

1. [SQLite3 configurado (padrão)](../2025.2-Atividades-05-Docker-Django/relatorio.md#sqlite3-configurado-padrão)

1. [Migrações executadas](../2025.2-Atividades-05-Docker-Django/relatorio.md#migrações-executadas)

1. [Superusuário criado](../2025.2-Atividades-05-Docker-Django/relatorio.md#superusuário-criado-username-admin-password-321)

1. [View simples criada e testada](../2025.2-Atividades-05-Docker-Django/relatorio.md#view-simples-criada-e-testada)

1. [Painel admin acessível e funcional](../2025.2-Atividades-05-Docker-Django/relatorio.md#painel-admin-acessível-e-funcional)

1. [Container de desenvolvimento testado](../2025.2-Atividades-05-Docker-Django/relatorio.md#container-de-desenvolvimento-testado)

1. [Container de produção testado](../2025.2-Atividades-05-Docker-Django/relatorio.md#container-de-desenvolvimento-testado)

1. [Comandos usados](../2025.2-Atividades-05-Docker-Django/relatorio.md#comandos-usados)

1. [Dificuldades](../2025.2-Atividades-05-Docker-Django/relatorio.md#dificuldades)

## Dockerfile.dev criado com base em Fedora

```bash
# Usar Fedora como imagem base
FROM fedora:latest

# Definir diretório de trabalho
WORKDIR /app

# Atualizar sistema e instalar dependências
RUN dnf update -y && \
    dnf install -y fish python3 python3-pip python3-devel gcc sqlite && \
    dnf clean all

# Instalar Django
RUN pip3 install Django==4.2.7

# Expor porta 8000
EXPOSE 8000

# Comando padrão
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
```

## Dockerfile.prod criado com base em Fedora

```bash
# Usar Fedora como imagem base
FROM fedora:latest

# Definir diretório de trabalho
WORKDIR /app

# Atualizar sistema e instalar dependências
RUN dnf update -y && \
    dnf install -y python3 python3-pip python3-devel gcc sqlite && \
    dnf clean all

# Copiar arquivo de requirements
COPY requirements.txt .

# Instalar dependências Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Copiar todos os arquivos do projeto
COPY app/ ./

# Dar permissão de execução ao script
RUN chmod +x init.sh

# Expor porta 8000
EXPOSE 8000

# Comando para executar o script de inicialização
CMD ["./init.sh"]
```

## Python e Django instalados

```bash
(virtual) PS C:\Users\Windows\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker build -f Dockerfile.dev -t django-dev .
[+] Building 61.1s (9/9) FINISHED                                                                                                                                                                        docker:desktop-linux
 => [internal] load build definition from Dockerfile.dev                                                                                                                                                                 0.1s
 => => transferring dockerfile: 477B                                                                                                                                                                                     0.0s 
 => [internal] load metadata for docker.io/library/fedora:latest                                                                                                                                                         1.7s
 => [auth] library/fedora:pull token for registry-1.docker.io                                                                                                                                                            0.0s
 => [internal] load .dockerignore                                                                                                                                                                                        0.1s
 => => transferring context: 2B                                                                                                                                                                                          0.0s 
 => [1/4] FROM docker.io/library/fedora:latest@sha256:aa7befe5cfd1f0e062728c16453cd1c479d4134c7b85eac00172f3025ab0d522                                                                                                   9.0s
 => => resolve docker.io/library/fedora:latest@sha256:aa7befe5cfd1f0e062728c16453cd1c479d4134c7b85eac00172f3025ab0d522                                                                                                   0.1s 
 => => sha256:30f8cfaf47ed35aa20e3dd1ed04b976c7e72f47299ebef675861b4e7be0afe46 61.09MB / 61.09MB                                                                                                                         6.2s
 => => extracting sha256:30f8cfaf47ed35aa20e3dd1ed04b976c7e72f47299ebef675861b4e7be0afe46                                                                                                                                2.6s
 => [2/4] WORKDIR /app                                                                                                                                                                                                   0.3s
 => [3/4] RUN dnf update -y &&     dnf install -y fish python3 python3-pip python3-devel gcc sqlite &&     dnf clean all                                                                                                29.9s
 => [4/4] RUN pip3 install Django==4.2.7                                                                                                                                                                                 5.1s
 => exporting to image                                                                                                                                                                                                  14.6s
 => => exporting layers                                                                                                                                                                                                  8.8s
 => => exporting manifest sha256:4706b71e4b1acd4610ffb2db14b72682e4a4e8a86c43900faba715d0fdc48b26                                                                                                                        0.0s
 => => exporting config sha256:e64e4323eb977b0e9865351f0d68ec68ac4fe10e60aa5ecfb74f70e9622a1a41                                                                                                                          0.0s
 => => exporting attestation manifest sha256:2dabc1656d640909b9a6e893e9a7045c22db55998c7d1460df4d732f0b64a631                                                                                                            0.0s
 => => exporting manifest list sha256:4c40556ebd9582ddb604b4fb37a3b400ce93488a864e567ebb2262a64b7908a6                                                                                                                   0.0s 
 => => naming to docker.io/library/django-dev:latest                                                                                                                                                                     0.0s 
 => => unpacking to docker.io/library/django-dev:latest                                                                                                                                                                  5.7s
```

## Projeto Django criado (myproject)

![Myproject](./Captura%20de%20tela%202025-11-10%20231707.png)

## Aplicação Django criada (webapp)

![Criação app django](./Captura%20de%20tela%202025-11-10%20232045.png)

## SQLite3 configurado (padrão)

```bash
# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```

## Migrações executadas

```bash
root@86d0a3b3eb67 /app# python3 manage.py migrate                          
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying sessions.0001_initial... OK
```

## Superusuário criado (username: admin, password: 321)

```bash
root@86d0a3b3eb67 /app# python3 manage.py createsuperuser
Usuário (leave blank to use 'root'): admin
Endereço de email: admin@email.com
Password: 
Password (again):
Esta senha é muito curta. Ela precisa conter pelo menos 8 caracteres.
Esta senha é muito comum.
Esta senha é inteiramente numérica.
Bypass password validation and create user anyway? [y/N]: y
Superuser created successfully.
```

## View simples criada e testada

![Teste da view](./Captura%20de%20tela%202025-11-10%20233018.png)

## Painel admin acessível e funcional

![Painel admin](./Captura%20de%20tela%202025-11-10%20232438.png)

## Container de desenvolvimento testado

```bash
(virtual) PS C:\Users\Windows\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker run -it --rm -p 8000:8000 -v ${PWD}:/app django-dev fish
Welcome to fish, the friendly interactive shell
Type help for instructions on how to use fish
root@86d0a3b3eb67 /app# ls
Dockerfile.dev*  app/  requirements.txt*
```

## Container de produção testado

```bash
(virtual) PS C:\Users\20242014040005\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker build -f Dockerfile.prod -t django-prod .
[+] Building 2.8s (11/11) FINISHED                                                                                                                                                                          docker:desktop-linux
 => [internal] load build definition from Dockerfile.prod                                                                                                                                                                   0.5s
 => => transferring dockerfile: 641B                                                                                                                                                                                        0.0s 
 => [internal] load metadata for docker.io/library/fedora:latest                                                                                                                                                            1.3s
 => [internal] load .dockerignore                                                                                                                                                                                           0.5s
 => => transferring context: 2B                                                                                                                                                                                             0.0s 
 => [1/6] FROM docker.io/library/fedora:latest@sha256:aa7befe5cfd1f0e062728c16453cd1c479d4134c7b85eac00172f3025ab0d522                                                                                                      0.0s
 => => resolve docker.io/library/fedora:latest@sha256:aa7befe5cfd1f0e062728c16453cd1c479d4134c7b85eac00172f3025ab0d522                                                                                                      0.0s 
 => [internal] load build context                                                                                                                                                                                           0.0s 
 => CACHED [2/6] WORKDIR /app                                                                                                                                                                                               0.0s 
 => CACHED [4/6] COPY requirements.txt .                                                                                                                                                                                    0.0s 
 => CACHED [5/6] RUN pip3 install --no-cache-dir -r requirements.txt                                                                                                                                                        0.0s 
 => exporting to image                                                                                                                                                                                                      0.1s 
 => => exporting manifest sha256:ca910069ae13af4f1702dde210fcd881708c33c683fc4138c493c3c63a9bb410                                                                                                                           0.0s 
 => => exporting attestation manifest sha256:6888674ddad670f25afec751c8ddc9bd3700813cfbda9d6e8e3de20e687944c5                                                                                                               0.0s 
 => => exporting manifest list sha256:2d63b94efebcdc90819c5b430fcd199643358f7f9239551833bce56c31a8a1e2                                                                                                                      0.0s 
 => => naming to docker.io/library/django-prod:latest                                                                                                                                                                       0.0s 
 => => unpacking to docker.io/library/django-prod:latest                                                                                                                                                                    0.0s 
(virtual) PS C:\Users\20242014040005\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker run -d -p 8080:8000 --name django-app-prod django-prod
7d8bb6abcebf44bf64186ee6339da8372d62fd4807d205885c756162194251b0
```

## Comandos Usados

```bash
root@86d0a3b3eb67 /app# django-admin startproject myproject .
root@86d0a3b3eb67 /app# python3 manage.py startapp webapp                                                                                                                                                                     
root@86d0a3b3eb67 /app# python3 manage.py migrate                                                                                                                                                                 

root@86d0a3b3eb67 /app# python3 manage.py createsuperuser                                                                                                                                                                     

root@86d0a3b3eb67 /app# python3 manage.py runserver 0.0.0.0:8000                                                                                                                                                              

(virtual) PS C:\Users\Windows\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker build -f Dockerfile.prod -t django-prod .


(virtual) PS C:\Users\20242014040005\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS              PORTS                                         NAMES
7d8bb6abcebf   django-prod   "python3 manage.py r…"   About a minute ago   Up About a minute   0.0.0.0:8080->8000/tcp, [::]:8080->8000/tcp   django-app-prod
(virtual) PS C:\Users\20242014040005\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker stop django-app-prod
django-app-prod
(virtual) PS C:\Users\20242014040005\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker rm django-app-prod
django-app-prod
(virtual) PS C:\Users\20242014040005\Documents\ws-so\2025.2-Atividades-05-Docker-Django\django-docker-project> docker exec -it django-app-prod /bin/bash
Error response from daemon: No such container: django-app-prod
```

## Dificuldades

- Criar a aplicação no diretório certo;
- Testar os containers, resolvido depois de organizar corretamente os diretórios da aplicação;
- Rodar a aplicação através da imagem construída em Fedora, resolvido depois de entender com mais clareza os erros de diretórios.

## Diferenças entre os ambientes

- O ambiente de desenvolvimento cria um terminal linux para executar o projeto;
- O de produção consegue executar a aplicação django diretamente na imagem docker.