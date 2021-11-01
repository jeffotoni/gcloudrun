# Makefile
.EXPORT_ALL_VARIABLES:	

GO111MODULE=on
GOPROXY=direct
GOSUMDB=off

build:
	@echo "########## Compilando nossa API ... "
	CGO_ENABLED=0 GOOS=linux go build --trimpath -ldflags="-s -w" -o gcloudrun.user main.go
	@echo "buid completo..."
	@echo "\033[0;33m################ Enviando para o server #####################\033[0m"

update:
	@echo "########## Compilando nossa API ... "
	@rm -f go.*
	go mod init github.com/jeffotoni/gcloudrun.user
	go mod tidy
	CGO_ENABLED=0 GOOS=linux go build --trimpath -ldflags="-s -w" -o gcloudrun.user main.go
	@echo "buid update completo..."
	@echo "fim"

tests:
	
deploy:
	@echo "########## Compilando nossa API ... "
	sh deploy.gcloud.sh
	@echo "fim"
