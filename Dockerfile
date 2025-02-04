FROM golang:1.13 as builder

# Create a non root user.
RUN adduser --disabled-password --disabled-login --gecos "" user
WORKDIR /code

COPY go.mod go.sum /code/
RUN go mod download && go mod verify

COPY . /code

RUN make build

FROM scratch

# Import the user and group files from the builder.
COPY --from=builder /etc/passwd /etc/passwd
# Copy our static executable.
COPY --from=builder /code/myexample /
# Use an unprivileged user.
USER user

CMD ["/myexample"]
