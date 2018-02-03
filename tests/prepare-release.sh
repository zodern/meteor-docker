docker build -t zodern/meteor ./image
docker build -t zodern/meteor:root ./root-image

semantic-release --debug
