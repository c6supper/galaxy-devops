
# Use posgres as base for the runtime image
ARG POSTGRES_VERSION=13-alpine
FROM postgres:${POSTGRES_VERSION}

# Copy source to container for sake of build
COPY schema/* /docker-entrypoint-initdb.d/

# Expose the default listener port
EXPOSE 5432

CMD ["postgres"]
