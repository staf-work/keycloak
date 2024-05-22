FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure the database
ENV KC_DB=postgres

WORKDIR /opt/keycloak

# Build Keycloak with the necessary configuration
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Change these values to point to your running PostgreSQL instance
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://db-postgresql-sgp1-38592-do-user-16628503-0.c.db.ondigitalocean.com:25060/keycloakdb
ENV KC_DB_USERNAME=keycloakuser
ENV KC_DB_PASSWORD=yourpassword

# Set hostname (you can also set other optional Keycloak environment variables as needed)
ENV KC_HOSTNAME=your-app-domain

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
