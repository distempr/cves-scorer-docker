# Cves scorer in Docker

Run the following

```
mkdir var
docker build -t cves-scorer .
docker run -it --mount type=bind,source="$(pwd)"/var,target=/var/lib/cves cves-scorer
```
