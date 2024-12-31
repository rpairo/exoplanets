# ---------- STAGE 1: BUILD ----------
FROM swift:6.0.3 AS build

WORKDIR /build

COPY . .

RUN swift build --configuration release

# ---------- STAGE 2: RUNTIME ----------
FROM swift:6.0.3-slim AS terminal

LABEL maintainer="Raul Pera raul_pairo@icloud.com"
LABEL description="ExoplanetTerminal Swift application"

WORKDIR /app

RUN useradd --create-home --uid 1001 --shell /bin/bash swiftuser
USER swiftuser

COPY --from=build /build/.build/release/ExoplanetTerminal /app/ExoplanetTerminal

ENTRYPOINT ["./ExoplanetTerminal"]
