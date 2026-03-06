#!/usr/bin/env bash
# zuerst die normale ~/.bashrc laden (falls vorhanden)
if [ -f "${HOME}/.bashrc" ]; then
    source "${HOME}/.bashrc"
fi


alias dev='pnpm dev'
alias build='pnpm build'
alias start='pnpm start'
alias check='pnpm biome check'