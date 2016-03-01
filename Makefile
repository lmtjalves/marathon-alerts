APPNAME = marathon-alerts
VERSION=0.0.1-dev

build:
	go build -o ${APPNAME} .

build-linux:
	GOOS=linux GOARCH=amd64 go build -ldflags "-s -X main.APP_VERSION=${VERSION}" -v -o ${APPNAME}-linux-amd64 .

build-mac:
	GOOS=darwin GOARCH=amd64 go build -ldflags "-s -X main.APP_VERSION=${VERSION}" -v -o ${APPNAME}-darwin-amd64 .

build-all: build-mac build-linux

all: setup
	build
	install

setup:
	go get -u github.com/spf13/pflag
	go get -u github.com/ashwanthkumar/slack-go-webhook
	go get -u github.com/gambol99/go-marathon
	# Test deps
	go get -u github.com/stretchr/testify/assert

test-only:
	go test github.com/ashwanthkumar/marathon-alerts/${name}

test:
	go test github.com/ashwanthkumar/marathon-alerts/