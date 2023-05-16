#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
ROOT_DIR="$(cd $SCRIPT_DIR && cd ../.. && pwd)"

FSHOW_SCRIPT="$ROOT_DIR/examples/fzf/fshow/fshow"
PACKAGE_JSON="$ROOT_DIR/package.json"
RFV_SCRIPT="$ROOT_DIR/examples/fzf/rfv/rfv"

echo "Bat demo:"
echo ""

bat --paging=always "$SCRIPT_DIR/first-text.sh"
bat -p --paging=always "$SCRIPT_DIR/second-text.sh"

printf "> bat -pp $FSHOW_SCRIPT\n"
bat -pp "$FSHOW_SCRIPT"
echo ""

printf "> bat $PACKAGE_JSON\n"
bat -pp --theme="Monokai Extended" "$PACKAGE_JSON"
echo ""

printf "> bat -pp $SCRIPT_DIR\n"
bat -pp "$RFV_SCRIPT"
