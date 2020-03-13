FROM ruby:2.6.3

# Install 3rd party dependencies.
RUN apt update && apt -y install nodejs

# Working directory.
RUN mkdir /app
WORKDIR /app

# Script run when container first starts.
COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT [ "/app/docker-entrypoint.sh" ]
