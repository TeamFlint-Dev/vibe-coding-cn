# Makefile for Vibe Coding Guide

.PHONY: help lint build test test-cloud-compile clean

help:
	@echo "Makefile for Vibe Coding Guide"
	@echo ""
	@echo "Available commands:"
	@echo "  help               - Show this help message"
	@echo "  lint               - Lint all markdown files"
	@echo "  build              - Build the project (Placeholder)"
	@echo "  test               - Run tests (Placeholder)"
	@echo "  test-cloud-compile - Test cloud compilation functionality"
	@echo "  clean              - Clean build artifacts (Placeholder)"
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

test-cloud-compile:
	@echo "Testing cloud compilation functionality..."
	@cd tests/verse-cloud-compile && python3 test_cloud_compile.py
	@echo "Cloud compilation tests complete."

clean:
	@echo "Cleaning up build artifacts..."
	# Add your clean commands here (e.g., rm -rf dist/ build/)
	@echo "Cleanup complete."