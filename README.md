# Tools for automatically monitoring the Sui network and upgrading the latest Sui docker image and genesis.blob
- Watchtower in `docker-compose.yml`: detect and upgrade the Sui container if a new Sui image is available.
- `monitor.sh`: notify the Sui network states.
- `genesis-updater.sh`: detect, download new `genesis.blob` file and upgrade the Sui container if the `genesis.blob` file is updated

1. Clone this repo.
2. Copy all files to your Sui folder, that overrides your `docker-compose.yml` file. Refer to https://github.com/MystenLabs/sui/tree/main/docker/fullnode
3. Run your fullnode as normal with the new `docker-compose.yml`.
4. Add your TELEGRAM_BOT_TOKEN & CHAT_ID to `monitor.sh` and `genesis-updater.sh`.
5. Run `chmod +x monitor.sh && chmod +x genesis-updater.sh`.
6. Run `monitor.sh` and `genesis-updater.sh` in 2 sessions of `screen`. Refer to https://linuxize.com/post/how-to-use-linux-screen/
