FROM golang:1.14-windowsservercore as builder

WORKDIR /go/src/drone-email
COPY . .

RUN GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go build -o drone-email.exe .

FROM plugins/base:windows-ltsc2022-amd64
COPY --from=builder /go/src/drone-email/drone-email.exe C:/drone-email/
ENTRYPOINT ["C:/drone-email/drone-email.exe"]
