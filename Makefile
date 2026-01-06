# Makefile for Vibe Coding Guide

.PHONY: help lint build test test-lsp clean

help:
	@echo "Makefile for Vibe Coding Guide"
	@echo ""
	@echo "Available commands:"
	@echo "  help     - Show this help message"
	@echo "  lint     - Lint all markdown files"
	@echo "  build    - Build the project (Placeholder)"
	@echo "  test     - Run tests (Placeholder)"
	@echo "  test-lsp - Run LSP error detection tests"
	@echo "  clean    - Clean build artifacts (Placeholder)"
	@echo ""

lint:
	@echo "Linting markdown files..."
	@npm install -g markdownlint-cli
	@markdownlint **/*.md

build:
	@echo "Building the project..."
	# Add your project build commands here
	@echo "Build complete."

test:
	@echo "Running tests..."
	# Add your test commands here
	@echo "Tests complete."

test-lsp:
	@echo "Running LSP error detection tests..."
	@./scripts/verse-lsp/setup-verse-env.sh
	@python3 tests/verse-lsp/test_lsp_error_detection.py
	@echo "LSP tests complete."

clean:
	@echo "Cleaning up build artifacts..."
	# Add your clean commands here (e.g., rm -rf dist/ build/)
	@echo "Cleanup complete."