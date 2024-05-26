FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure the database
ENV KC_DB=postgres

WORKDIR /opt/keycloak

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Environment variables expected to be set by the deployment platform
ENV KC_PROXY_ADDRESS_FORWARDING=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=true

# Database Configuration
ENV KC_DB=postgres
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}
ENV KC_DB_URL_HOST=${KC_DB_URL_HOST}
ENV KC_DB_URL_PORT=${KC_DB_URL_PORT}
ENV KC_DB_URL_DATABASE=${KC_DB_URL_DATABASE}

# Admin User Configuration
ENV KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN}
ENV KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD}

# Entrypoint to start Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
