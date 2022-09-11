#!/bin/bash
export TZ=Asia/Ho_Chi_Minh #TIMEZONE
TELEGRAM_BOT_TOKEN="55555555555:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" #YOUR TELEGRAM BOT TOKEN, CREATED VIA @BotFather
CHAT_ID="YYYYYYYY" #DESTINATION TO RECEIVE NOTIFICATIONS

echo 'Sui Genesis Updater v0.1'

notify() {
  msg=$1 
  curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID&parse_mode=html&text=$msg" &> /dev/null
}

while :
do
  sleep 60s
  NOW=$(date +'%d/%m/%Y %T')
  echo "$NOW - Checking genesis.blob.."
  
  wget -q https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob -O genesis.blob.x
  RETURN_CODE=$?
  if [ $RETURN_CODE -ne 0 ]; then
    echo "Download failed"
    continue
  fi

  md5f1=$(md5sum "genesis.blob.x" | cut -d' ' -f1) 
  md5f2=$(md5sum "genesis.blob" | cut -d' ' -f1)
  if [ "$md5f2" != "$md5f1" ]; then
    cp genesis.blob.x genesis.blob
    docker compose down --volumes
    docker compose up -d
    notify "<code>$NOW</code>"$'\n'"New genesis.blob updated"
    echo "New genesis.blob updated"
  else
    echo "No change"
  fi
done
