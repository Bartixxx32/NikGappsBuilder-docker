# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: <Android version> <Gapps variant>"
    exit 1
fi
docker run -v $PWD/Releases:/app/Releases -v $PWD/Data/$1:/app/$1 -it ghcr.io/bartixxx32/nikgappsbuilder-docker:main $1 $2