GET_TRANSACTIONS=$(printf "{%s" "$(${UTILS_DIR}/tonos-cli run ${MSIG_ADDR} getTransactions {} --abi "${CONFIGS_DIR}/SafeMultisigWallet.abi.json" | sed -n -e '/"transactions"/,$p')")
TRANSACTIONS_NUMBER=$(echo $GET_TRANSACTIONS | jq '.transactions' | jq length)
TONOS_CLI_SEND_ATTEMPTS="100"

echo "Unconfirmed transactions number: ${TRANSACTIONS_NUMBER}";

if [ $TRANSACTIONS_NUMBER -gt 0 ]; then
    TRANSACTION_ID=$(echo $GET_TRANSACTIONS | jq '.transactions[0].id' -r)
    echo "Confirm transaction ${TRANSACTION_ID} by ${CONFIRMATOR_HOSTNAME}"
    for i in $(seq ${TONOS_CLI_SEND_ATTEMPTS}); do
    echo "INFO: tonos-cli confirmTransaction attempt #${i}..."
    if ! "${UTILS_DIR}/tonos-cli" call "${MSIG_ADDR}" confirmTransaction \
        "{\"transactionId\":\"${TRANSACTION_ID}\"}" \
        --abi ${CONFIGS_DIR}/SafeMultisigWallet.abi.json \
        --sign $CONFIRMATOR_KEYS_DIR/msig.keys.json; then
        echo "INFO: tonos-cli confirmElectionTransaction attempt #${i}... FAIL"
    else
        echo "INFO: tonos-cli confirmElectionTransaction attempt #${i}... PASS"
        break
    fi
    done
fi
