# ============================================================
#  Dockerfile — Dynamic Portfolio Website
#  Multi-stage build:
#    Stage 1 (builder) — Maven compiles the WAR
#    Stage 2 (runtime) — Tomcat 10.1 serves it
# ============================================================

# ── Stage 1: Build ───────────────────────────────────────────
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests -B

# ── Stage 2: Runtime ─────────────────────────────────────────
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy as ROOT so app is at / not /portfolio
COPY --from=builder /app/target/portfolio.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]