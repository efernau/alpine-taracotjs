# alpine-TaracotJS
Docker taracotjs running on Alpine with mongodb, redis and node.

#TaracotJS

TaracotJS is fast and minimalist CMS based on Node.js. 

#Official website and demo

Official website: https://taracot.org
Github: https://github.com/xtremespb/taracotjs


# Running

docker run -d -p 27017:27017 -p 3000:3000 -p 6379:6379 efernau/alpine-taracotjs:latest

or

docker run -d -p 27017:27017 -p 3000:3000 -p 6379:6379 -v /someLocalVolume:/data/db \ 
efernau/alpine-taracotjs:latest

# Connect to running instance

docker exec -it efernau/alpine-taracotjs sh
