# Binary name
BINARY=copilot2gpt
# 构建目录
DIST_DIR := ./dist
# Builds the project
build:
		GO111MODULE=on go build -o ${BINARY} -ldflags "-X main.Version=${VERSION}"
#		GO111MODULE=on go test -v
# Installs our project: copies binaries
install:
		GO111MODULE=on go install
release:
		# Clean
		go clean
		rm -rf ${DIST_DIR}/*.gz
		# Build for mac
		GO111MODULE=on go build -ldflags "-s -w -X main.Version=${VERSION}"
		tar czvf ${DIST_DIR}/${BINARY}-mac64-${VERSION}.tar.gz ./${BINARY} .env.example
		# Build for arm
		go clean
		CGO_ENABLED=0 GOOS=linux GOARCH=arm64 GO111MODULE=on go build -ldflags "-s -w -X main.Version=${VERSION}"
		tar czvf ${DIST_DIR}/${BINARY}-linux-arm64-${VERSION}.tar.gz ./${BINARY} .env.example
		# Build for linux386
		go clean
		CGO_ENABLED=0 GOOS=linux GOARCH=386 GO111MODULE=on go build -ldflags "-s -w -X main.Version=${VERSION}"
		tar czvf ${DIST_DIR}/${BINARY}-linux-386-${VERSION}.tar.gz ./${BINARY} .env.example
		# Build for linux
		go clean
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -ldflags "-s -w -X main.Version=${VERSION}"
		tar czvf ${DIST_DIR}/${BINARY}-linux-64-${VERSION}.tar.gz ./${BINARY} .env.example
		# Build for win386
		go clean
		CGO_ENABLED=0 GOOS=windows GOARCH=386 GO111MODULE=on go build -ldflags "-s -w -X main.Version=${VERSION}"
		tar czvf ${DIST_DIR}/${BINARY}-win-386-${VERSION}.tar.gz ./${BINARY}.exe .env.example
		# Build for win
		go clean
		CGO_ENABLED=0 GOOS=windows GOARCH=amd64 GO111MODULE=on go build -ldflags "-s -w -X main.Version=${VERSION}"
		tar czvf ${DIST_DIR}/${BINARY}-win-64-${VERSION}.tar.gz ./${BINARY}.exe .env.example
		go clean
# Cleans our projects: deletes binaries
clean:
		go clean
		rm -rf ${DIST_DIR}/*.gz

.PHONY:  clean build