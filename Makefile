# Makefile for snatch.nvim

.PHONY: test install clean help

help:
	@echo "Available commands:"
	@echo "  test    - Run tests"
	@echo "  install - Install dependencies"
	@echo "  clean   - Clean up"
	@echo "  help    - Show this help"

install:
	@echo "Installing busted..."
	luarocks install busted

test:
	@echo "Running tests..."
	busted test/snatch_spec.lua

clean:
	@echo "Cleaning up..."
	rm -f coverage.txt
