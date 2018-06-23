# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gcwnet bootnode all test clean
.PHONY: gcwnet-windows gcwnet-windows-386 gcwnet-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

gcwnet:
	build/env.sh go run build/ci.go install ./cmd/gcwnet
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gcwnet\" to launch gcwnet."

bootnode:
	build/env.sh go run build/ci.go install ./cmd/bootnode
	@echo "Done building."
	@echo "Run \"$(GOBIN)/bootnode\" to launch bootnode."

all:
	build/env.sh go run build/ci.go install

test: all
	build/env.sh go run build/ci.go test

lint:
	build/env.sh go run build/ci.go lint

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

gcwnet-windows: gcwnet-windows-386 gcwnet-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gcwnet-windows-*

gcwnet-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gcwnet
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gcwnet-windows-* | grep 386

gcwnet-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gcwnet
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gcwnet-windows-* | grep amd64
