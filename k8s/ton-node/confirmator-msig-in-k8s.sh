GET_TRANSACTIONS=$(printf "{%s" "$(${UTILS_DIR}/tonos-cli run ${MSIG_ADDR} getTransactions {} --abi "${CONFIGS_DIR}/SafeMultisigWallet.abi.json" | sed -n -e '/"transactions"/,$p')")
TRANSACTIONS_NUMBER=$(echo $GET_TRANSACTIONS | jq '.transactions' | jq length)

if [ $TRANSACTIONS_NUMBER -gt 0 ]; then
    TRANSACTION_ID=$(echo $GET_TRANSACTIONS | jq '.transactions[0].id' -r)
    echo "Confirm transaction ${TRANSACTION_ID} by ${CONFIRMATOR_HOSTNAME}"
    ${UTILS_DIR}/tonos-cli call ${MSIG_ADDR} confirmTransaction "{\"transactionId\":\"${TRANSACTION_ID}\"}" --abi ${CONFIGS_DIR}/SafeMultisigWallet.abi.json --sign $CONFIRMATOR_KEYS_DIR/msig.keys.json
fi
