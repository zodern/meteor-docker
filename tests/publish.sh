set -e
VERSION="$1"

# Normal image
docker tag zodern/meteor zodern/meteor:latest
docker tag zodern/meteor zodern/meteor:$VERSION

docker push zodern/meteor:latest
docker push zodern/meteor:$VERSION

# root image
docker tag zodern/meteor:root zodern/meteor:$VERSION-root

docker push zodern/meteor:root
docker push zodern/meteor:$VERSION-root
