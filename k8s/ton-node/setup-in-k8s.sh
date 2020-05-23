mkdir ${TON_WORK_DIR}/{db,etc,keys}
cp "${CONFIGS_DIR}/ton-global.config.json" "${TON_WORK_DIR}/etc/ton-global.config.json"
"${TON_BUILD_DIR}/validator-engine/validator-engine" -C "${TON_WORK_DIR}/etc/ton-global.config.json" --db "${TON_WORK_DIR}/db" --ip "${EXTERNAL_IP}:${ADNL_PORT}"
cd ${KEYS_DIR}
"${UTILS_DIR}/generate-random-id" -m keys -n server > "${KEYS_DIR}/keys_s"
"${UTILS_DIR}/generate-random-id" -m keys -n liteserver > "${KEYS_DIR}/keys_l"
"${UTILS_DIR}/generate-random-id" -m keys -n client > "${KEYS_DIR}/keys_c"
mv "${KEYS_DIR}/server" "${TON_WORK_DIR}/db/keyring/$(awk '{print $1}' "${KEYS_DIR}/keys_s")"
mv "${KEYS_DIR}/liteserver" "${TON_WORK_DIR}/db/keyring/$(awk '{print $1}' "${KEYS_DIR}/keys_l")"
awk '{
    if (NR == 1) {
        server_id = $2
    } else if (NR == 2) {
        client_id = $2
    } else if (NR == 3) {
        liteserver_id = $2
    } else {
        print $0;
        if ($1 == "\"control\"") {
            print "      {";
            print "         \"id\": \"" server_id "\","
            print "         \"port\": 3030,"
            print "         \"allowed\": ["
            print "            {";
            print "               \"id\": \"" client_id "\","
            print "               \"permissions\": 15"
            print "            }";
            print "         ]"
            print "      }";
        } else if ($1 == "\"liteservers\"") {
            print "      {";
            print "         \"id\": \"" liteserver_id "\","
            print "         \"port\": 3031"
            print "      }";
        }
    }
}' "${KEYS_DIR}/keys_s" "${KEYS_DIR}/keys_c" "${KEYS_DIR}/keys_l" "${TON_WORK_DIR}/db/config.json" > "${TON_WORK_DIR}/db/config.json.tmp"
mv "${TON_WORK_DIR}/db/config.json.tmp" "${TON_WORK_DIR}/db/config.json"
