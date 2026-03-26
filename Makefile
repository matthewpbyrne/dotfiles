SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

# Tools
SHFMT      ?= shfmt
SHELLCHECK ?= shellcheck
ZSH_BIN    ?= zsh
MDFORMAT   ?= mdformat
TAPLO      ?= taplo

# Find files via git so we only touch repo content
MD_FILES       := $(shell git ls-files '*.md')
SH_POSIX_FILES := $(shell git ls-files 'dot_profile' 2>/dev/null)
SH_BASH_FILES  := $(shell git ls-files '*.sh' 'dot_bashrc' 2>/dev/null)
TOML_FILES     := $(shell git ls-files '*.toml' '.taplo.toml' 'taplo.toml' 2>/dev/null)
ZSH_FMT_FILES  := $(shell git ls-files '*.zsh' \
  'dot_config/zsh/profiles/*/dot_zprofile' \
  'dot_config/zsh/profiles/*/dot_zshenv' \
  'dot_config/zsh/profiles/*/dot_zlogin' \
  'dot_config/zsh/profiles/*/dot_zlogout' \
  'dot_zshenv' 2>/dev/null)
ZSH_LINT_FILES := $(shell git ls-files '*.zsh' \
  'dot_config/zsh/profiles/*/dot_zshrc' \
  'dot_config/zsh/profiles/*/dot_zprofile' \
  'dot_config/zsh/profiles/*/dot_zshenv' \
  'dot_config/zsh/profiles/*/dot_zlogin' \
  'dot_config/zsh/profiles/*/dot_zlogout' \
  'dot_zshenv' 2>/dev/null)

.PHONY: help
help:
	@printf '%s\n' \
	  'make fmt          # format everything safely' \
	  'make lint         # lint/check everything' \
	  'make check        # alias for lint' \
	  'make lint-terminal # check shared terminal defaults stay aligned' \
	  'make fmt-sh       # format .sh files' \
	  'make fmt-zsh      # format .zsh files' \
	  'make lint-sh      # shellcheck + syntax check .sh' \
	  'make lint-zsh     # zsh syntax check only' \
	  'make fmt-md       # format markdown' \
	  'make lint-md      # markdown check-only' \
	  'make fmt-toml     # format toml' \
	  'make lint-toml    # toml syntax/format check'

.PHONY: fmt lint check
fmt: fmt-sh fmt-zsh fmt-md fmt-toml
lint: lint-sh lint-zsh lint-md lint-toml lint-terminal
check: lint

# ----------------
# Shell (.sh)
# ----------------

.PHONY: fmt-sh lint-sh
fmt-sh:
	@if [ -n "$(SH_POSIX_FILES)" ]; then \
	  $(SHFMT) --apply-ignore -ln=posix -w $(SH_POSIX_FILES); \
	fi
	@if [ -n "$(SH_BASH_FILES)" ]; then \
	  $(SHFMT) --apply-ignore -ln=bash -w $(SH_BASH_FILES); \
	fi
	@if [ -z "$(SH_POSIX_FILES)$(SH_BASH_FILES)" ]; then \
	  echo "No shell files"; \
	fi

lint-sh:
	@if [ -n "$(SH_POSIX_FILES)" ]; then \
	  $(SHELLCHECK) $(SH_POSIX_FILES); \
	  $(SHFMT) --apply-ignore -ln=posix -d $(SH_POSIX_FILES); \
	fi
	@if [ -n "$(SH_BASH_FILES)" ]; then \
	  $(SHELLCHECK) $(SH_BASH_FILES); \
	  $(SHFMT) --apply-ignore -ln=bash -d $(SH_BASH_FILES); \
	fi
	@if [ -z "$(SH_POSIX_FILES)$(SH_BASH_FILES)" ]; then \
	  echo "No shell files"; \
		fi

# ----------------
# Terminal config consistency
# ----------------

.PHONY: lint-terminal
lint-terminal:
	@scripts/check_terminal_defaults.sh

# ----------------
# Zsh (.zsh, zsh dotfiles)
# ----------------

.PHONY: fmt-zsh lint-zsh
fmt-zsh:
	@if [ -n "$(ZSH_FMT_FILES)" ]; then \
	  $(SHFMT) --apply-ignore -ln=zsh -w $(ZSH_FMT_FILES); \
	else \
	  echo "No zsh files"; \
	fi

lint-zsh:
	@if [ -n "$(ZSH_LINT_FILES)" ]; then \
	  for f in $(ZSH_LINT_FILES); do $(ZSH_BIN) -n "$$f"; done; \
	  $(SHFMT) --apply-ignore -ln=zsh -d $(ZSH_FMT_FILES); \
	else \
	  echo "No zsh files"; \
	fi

# ----------------
# Markdown
# ----------------

.PHONY: fmt-md lint-md
fmt-md:
	@if [ -n "$(MD_FILES)" ]; then \
	  $(MDFORMAT) $(MD_FILES); \
	else \
	  echo "No markdown files"; \
	fi

lint-md:
	@if [ -n "$(MD_FILES)" ]; then \
	  $(MDFORMAT) --check $(MD_FILES); \
	else \
	  echo "No markdown files"; \
	fi

# ----------------
# TOML
# ----------------

.PHONY: fmt-toml lint-toml
fmt-toml:
	@if [ -n "$(TOML_FILES)" ]; then \
	  $(TAPLO) fmt $(TOML_FILES); \
	else \
	  echo "No toml files"; \
	fi

lint-toml:
	@if [ -n "$(TOML_FILES)" ]; then \
	  $(TAPLO) fmt --check $(TOML_FILES); \
	else \
	  echo "No toml files"; \
	fi
