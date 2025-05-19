#!/bin/bash
# chipinfo > ESP32-C5-DevKitC-1-chipinfo-`date +%s`.txt
bash ./espdump.sh
bash /home/princesspi/scripts/webhook.sh "espdump finished lol exitcode: $?" tagme
# sudo shutdown -r +5
# unset ESPIDFTOOLS_INSTALLDIR
# unset IDF_PATH
# unset ESP_IDF_VERSION
# unset IDF_PYTHON_ENV_PATH
# unset OPENOCD_SCRIPTS
# unset ESP_ROM_ELF_DIR
# unset IDF_DEACTIVATE_FILE_PATH
# unset IDF_TOOLS_INSTALL_CMD
# unset IDF_TOOLS_EXPORT_CMD
# unset ESPPORT
# unset ESPBAUD
# unset ESPTARGET
# echo bash /home/princesspi/esp/esp-idf-tools/esp-idf-tools-cmd.sh nr
# bash /home/princesspi/scripts/webhook.sh "esp reinstall nuke finished, rebooting" taGME
