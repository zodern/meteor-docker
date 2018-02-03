zodern/meteor Docker Image
===

Docker image to run Meteor apps.

### Features

- One image supports every Meteor version
- Automatically uses correct node and npm version
- Runs app as non-root user
- Compatible with Meteor up

## Tags

- `zodern/meteor:base`
- `zodern/meteor:root` Same as the base, except runs the app as the root user. Notes below about permissions do not apply to this image.
- `zodern/meteor:slim` Comming soon. Is a smaller image without node or npm preinstalled. During ONBUILD or when starting the app, it will install the correct version.

## How To Use

### Permissions

This image runs the app with the `app` user. The owner of any files or folders your app uses should be changed to `app`.

### Meteor Up

In your mup config, change `app.docker.image` to `zodern/meteor`.

### Compressed bundle

You can create the bundle with the `meteor build` command.

#### Dockerfile

Create a file named `Dockerfile` and add the following:

```Dockerfile
FROM zodern/meteor
COPY --chown=app:app ../path/to/bundle.tar.gz /bundle/bundle.tar.gz
```

Then build and run the image with

```bash
docker build --build-arg NODE_VERSION=<node version> -t meteor-app .
docker run --name my-meteor-app meteor-app
```

And your app will be running on port 3000

The `--build-arg NODE_VERSION=<node version>` is optional, and only needed if a command in your docker file will use node or npm.

#### Volume

Run

```bash
  docker run --name my-meteor-app -v /path/to/folder/with/bundle:/bundle -p 3000:3000 -e "ROOT_URL=http://app.com" zodern/meteor
```

### Built app

`Built app` refers to an uncompressed bundle that already has had it's npm dependencies installed.

When using a compressed bundle, the bundle is decompressed and the app's npm dependencies are installed every time the app is started, which can take a while. By using this method instead, both steps are done before the container is started, allowing it to start much faster. Meteor up's `Prepare Bundle` feature uses this.

Before following the instructions in either of the next two sections, build your app with `meteor build --directory ../path/to/put/bundle`

#### Docker Image

Create a file named `Dockerfile` and copy the following into it:

```Dockerfile
FROM zodern/meteor
COPY --chown=app:app ./path/to/bundle /built_app
RUN cd /built_app/programs/server && npm install
```

Then build and run your image with:

```bash
docker build -t meteor-app --build-arg NODE_VERSION="node version" .
docker run --name my-meteor-app -p 3000:3000 -e "ROOT_URL=http://app.com" meteor-app
```

#### Volume

If possible, you should create a docker image as described in the previous instructions since it is more reliable.

First, make sure you have the correct version of node installed for the Meteor version your app uses, and then run

```bash
cd /path/to/bundle
cd programs/server
npm install
```

Next, start the docker container with

```bash
docker run --name my-meteor-app -v /path/to/bundle:/built_app -p 3000:3000 -e "ROOT_URL=http://app.com" zodern/meteor
```

### Options

#### NPM_INSTALL_OPTIONS

When using a compressed bundle, you can specify the arguments used when running `npm install` by setting the environment variable `NPM_INSTALL_OPTIONS`.
