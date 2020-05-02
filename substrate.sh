#!/bin/bash

IP_="`curl -s ifconfig.co`"


sudo docker run -d --name backend -p 8000:8000 chevdor/substrate-telemetry-backend -l 0.0.0.0:8000 &&

sudo docker run -d --name frontend --link backend -p 80:80 -e SUBSTRATE_TELEMETRY_URL=ws://185.194.76.118:8000/feed chevdor/substrate-telemetry-frontend &&

sudo docker run -d --name alice --link backend  -p 30334:30334 chevdor/substrate substrate --base-path /tmp/alice   --chain=local   --alice   --node-key 0000000000000000000000000000000000000000000000000000000000000001 --telemetry-url 'ws://'$IP_':8000/submit 0' --validator

sudo docker run -d --name bob --link backend  chevdor/substrate substrate  --base-path /tmp/bob --bootnodes /ip4/127.0.0.1/tcp/30333/p2p/QmRpheLN4JWdAnY7HGJfWFNbfkQCb6tFf4vvA6hgjMZKrR --chain=local --bob --port 30334 --telemetry-url 'ws://'$IP_':8000/submit 0' --validator



