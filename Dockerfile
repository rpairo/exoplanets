FROM swift:6.0.3 AS build
WORKDIR /app
COPY . .
RUN swift build --configuration release

FROM swift:6.0.3-slim AS terminal
WORKDIR /app
COPY --from=build /app/.build/release/ExoplanetTerminal /app/ExoplanetTerminal
CMD ["./ExoplanetTerminal"]
