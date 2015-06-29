# Based on official iojs Docker image
FROM iojs:2.3

# If you like Docker like me, any help is always welcome!
MAINTAINER Andrés Amado <andres@bootenv.org> (@acactown)

LABEL version="1.0.0-alpha.1"
LABEL description="This file describes the standard way to run >bootenv REST-API, using Docker!"

# Useful ENV variables
ENV BOOTENV_API_VERSION 1.0.0-alpha.1
ENV BOOTENV_PATH /usr/src/bootenv-rest-api
ENV NODE_ENV production
ENV MONGO_URL mongodb://localhost:27017

# Packaged dependencies
RUN apt-get update \
  && apt-get install -y build-essential curl git --no-install-recommends

# Add simple launch script
COPY entrypoint /usr/bin/

# Get API source code
RUN curl -sSL https://github.com/bootenv/bootenv-rest-api/archive/${BOOTENV_API_VERSION}.tar.gz | tar -v -C /usr/src -xz \
  && ln -s /usr/src/bootenv-rest-api-${BOOTENV_API_VERSION} ${BOOTENV_PATH} \
  && chmod +x /usr/bin/entrypoint

# Set API path as Working directory
WORKDIR ${BOOTENV_PATH}
RUN npm install

# Expose API port
EXPOSE 3000

# Launch API
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["api:start"]
