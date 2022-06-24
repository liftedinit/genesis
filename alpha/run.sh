#!/bin/bash

tmux new-session -s many-ledger -n tendermint-ledger -d "$HOME/tendermint start"
tmux new-window  -t many-ledger -n ledger "$HOME/target/release/many-ledger -v --abci --addr 127.0.0.1:8001 --pem <(openssl genpkey -algorithm Ed25519) --persistent $HOME/ledger.db --state $HOME/ledger.json --allow-origin https://alberto.app --allow-origin https://staging.alberto.app --logmode syslog"
tmux new-window  -t many-ledger -n abci "$HOME/target/release/many-abci -v --many 127.0.0.1:8000 --many-app http://localhost:8001 --many-pem <(openssl genpkey -algorithm Ed25519) --abci 127.0.0.1:26658 --tendermint http://localhost:26657/ --allow-origin https://alberto.app --allow-origin https://staging.alberto.app --logmode syslog"

tmux -2 attach-session -t many-ledger
