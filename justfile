
set dotenv-load


DEV_IMAGE_NAME := "ai-cli-on-a-cob"

DEV_USER := "alex-ai"
DEV_UID := `id -u`

GEMINI_CONT_DIR := ".gemini-cont"
OPENCODE_CONT_DIR := ".opencode-cont"

PROJECT_DIR := `basename "$PWD"`


_default:
    just --list


[group: "host"]
dev-image-build:
    docker build \
        -f ai.Dockerfile \
        --no-cache \
        --tag \
        {{DEV_IMAGE_NAME}} . \
        --build-arg dev_user={{DEV_USER}} \
        --build-arg dev_uid={{DEV_UID}}


[group: "host"]
dev-run-cont:
    mkdir -p "$HOME/{{GEMINI_CONT_DIR}}"
    mkdir -p "$HOME/{{OPENCODE_CONT_DIR}}"
    docker run \
        --name {{PROJECT_DIR}} \
        -ti \
        --rm \
        --hostname {{DEV_IMAGE_NAME}} \
        --userns=keep-id \
        -v "$HOME/{{GEMINI_CONT_DIR}}":/home/{{DEV_USER}}/.gemini:Z \
        -e GEMINI_API_KEY=$GEMINI_API_KEY \
        -v "$HOME/{{OPENCODE_CONT_DIR}}":/home/{{DEV_USER}}/.opencode:Z \
        -e OPENCODE_HOME=/home/{{DEV_USER}}/.opencode \
        -v "$PWD":/home/{{DEV_USER}}/{{PROJECT_DIR}}:Z \
        {{DEV_IMAGE_NAME}} \
        tmux new -s ai-dev -n ai-proj



