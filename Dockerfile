FROM docker.io/library/archlinux:latest

ARG dev_user=dev-ai
ARG dev_uid=1000

RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Sy --noconfirm archlinux-keyring && \
    pacman -Syy && \
    pacman -Syu --noconfirm && \
    \
    pacman -S --noconfirm \
    base-devel \
    sudo \
    \
    neovim  \
    tmux \
    \
    git \
    wget \
    just \
    \
    rustup \
    python \
    nodejs \
    npm \
    luarocks \
    zig \
    go \
    terraform \
    \
    uv \
    pyenv \
    deno \
    cmake \
    \
    python-pip \
    python-pynvim \
    fd \
    tree-sitter-cli \
    ripgrep \
    \
    gemini-cli \
    opencode \
    \
    pacman-contrib && \
    paccache -rk0 && \
    rm -rf /var/cache/pacman/pkg/*

RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel && \
    chmod 0440 /etc/sudoers.d/wheel && \
    visudo -c /etc/sudoers.d/wheel && \
    useradd -m -u ${dev_uid} -G wheel ${dev_user}

USER ${dev_user}
WORKDIR /home/${dev_user}

# clone latest versions
RUN git clone https://github.com/the-citto/nvim-conf /home/${dev_user}/.config/nvim && \
    git clone https://github.com/the-citto/tmux-conf /home/${dev_user}/.config/tmux && \
    git clone https://github.com/the-citto/bashrc-conf /home/${dev_user}/.config/bashrc && \
    rustup default stable && \
    rustup component add rust-analyzer && \
    echo "[[ -e ~/.config/bashrc/.bashrc ]] && source ~/.config/bashrc/.bashrc" >> .bashrc && \
    nvim --headless "+Lazy! sync" +qa


CMD ["/bin/bash"]
