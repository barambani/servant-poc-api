# Servant poc Api

## How to run it
To run the service locally on a docker container you can run the following command in the project's folder (so that the docker file in there will be used and you don't have to specify it). I will try to push cache images for the dependencies, but there are chances that you have to build them for the first time if they are not available in my repos. If that's the case ... go get a coffee.
```
make local-server-run
```

## Build and run a local docker image manually
if you still want to build a docker image manually, follow the steps below

#### Build
run the following from the project's folder 
```
docker build -t servant-poc-api:latest .
```
if that's successful, looking up for the images with
```
docker images
```
should give something like
```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
servant-poc-api     latest              420ccecafd9d        6 minutes ago       115MB
<none>              <none>              db2b6162b545        6 minutes ago       11.7GB
<none>              <none>              e5d85e804e17        7 minutes ago       10.2GB
ubuntu              18.04               2ca708c1c9cc        3 weeks ago         64.2MB
fpco/stack-build    lts-14.6            9adc774bb5e5        2 months ago        8.52GB
```

#### Run
if the image has been created successfully the last step is to run it
```
docker run -e PORT=8080 -p 8080:8080 420ccecafd9d
```
clearly the ids will be different from mine, but the server should start with something like
```

```

#### Verify
to verify the service, you can send a curl request like the below (notice that the example uses `jq` but it's not required)
```
curl http://127.0.0.1:8080/pricing-api/health-check | jq
```
with a response (through `jq`) on the line of
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   104    0   104    0     0   6887      0 --:--:-- --:--:-- --:--:--  6933
{
  "name": "servant-poc-api",
  "version": "0.0.1.0",
  "buildTime": "now",
  "haskellVersion": "lts-14.6 (ghc-8.6.5)"
}
```