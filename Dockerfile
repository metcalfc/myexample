FROM golang:1.13 as builder

COPY . /code
WORKDIR /code

# Create a non root user.
RUN adduser --disabled-password --disabled-login user

RUN go get -d -v
RUN go mod download
RUN go mod verify
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s"

FROM scratch

# Import the user and group files from the builder.
COPY --from=builder /etc/passwd /etc/passwd
# Copy our static executable.
COPY --from=builder /code/myexample /
# Use an unprivileged user.
USER user

CMD ["/myexample"]
