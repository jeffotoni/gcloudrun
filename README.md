# gcloudrun User

Testando Google Cloud Run, testando com configurar e subir uma aplicação Go no serviço Cloud Run.
O objetivo é testar e levantar as possibilidades quando utilziamos este serviço.

Antes de iniciar lembra-lo que para fucionar precisaremos autenticar no google cloud com o seguinte comando.

### Àuth Login
```bash
$ gcloud auth login
```

### Artifacts Registry

Este é a nova versão do Registry no Google Cloud, nos iremos utiliza-lo como Registry para armazenar nossas imagens.
Para inicia-lo é preciso reinicia-lo com o link [Ativar Artifacts](https://console.cloud.google.com/apis/enableflow?apiid=artifactregistry.googleapis.com)

```bash
$ gcloud artifacts repositories create go2 --repository-format=docker \
--location=us-central1 --description="Docker repository Go"
```

#### List Repo
```bash
gcloud artifacts repositories list
```

#### Auth Repo
```bash
gcloud auth configure-docker us-central1-docker.pkg.dev
```

#### Clear Repo
```bash
gcloud artifacts repositories delete go2 --location=us-central1
```

#### Docker Build

Criamos um arquivo deploy.gcloud.sh, ele só irá funcionar se vocẽ tiver logado em seu ambiente do Google Cloud e ativado o Regitry.

#### Docker Build
Fizemos um arquivo bash o deploy.gcloud.sh, porém foi criado o Markefile para que execute tudo de forma simples.

```bash
$ make deploy
```

Foi contruída uma API simples de exemplo para testarmos Google Cloud Run.
Abaixo como executar localmente e testar para ver se está tudo ok.

### API USER - DOCKER BUILD - LOCAL

```bash
$ docker docker build -f Dockerfile -t jeffotoni/gcloudrun.user .
```

Agora vamos subir nosso serviço usando docker.
```bash
$ docker run --rm --name gcloudrun.user -it -p 8080:8080 jeffotoni/gcloudrun.user:latest
┌───────────────────────────────────────────────────┐ 
│                   Fiber v2.21.0                   │ 
│               http://127.0.0.1:8080               │ 
│       (bound on host 0.0.0.0 and port 8080)       │ 
│                                                   │ 
│ Handlers ............. 3  Processes ........... 1 │ 
│ Prefork ....... Disabled  PID ................. 1 │ 
└───────────────────────────────────────────────────┘ 
```

### API USER - [GET] /api/v1/ping

Agoa para testar vamos executar nossos endpoints e testar nossa api.

```bash
$ curl -i -XGET -H "Content-type:application/json" \
localhost:8080//api/v1/ping
```

### API USER - [POST] /api/v1/user

```bash
$ curl -i -XGET -H "Content-type:application/json" \
localhost:8080//api/v1/user -d '{"name":"jefferson","cpf":"23232323", "year":2021}'
```
