# alpine-taracotjs
Docker taracotjs running on Alpine with mongodb, redis and node.

# Running

docker run -d -p 27017:27017 -p 3000:3000 -p 6379:6379 efernau/alpine-taracotjs:latest

or

docker run -d -p 27017:27017 -p 3000:3000 -p 6379:6379 -v /someLocalVolume:/data/db \ 
efernau/alpine-taracotjs:latest

# Connect to running instance

docker exec -it efernau/alpine-taracotjs sh
