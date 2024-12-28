FROM swift:6.0.3 AS build
WORKDIR /app
COPY . .
RUN swift build --configuration release

FROM swift:6.0.3-slim
WORKDIR /app
COPY --from=build /app/.build/release/ExoplanetAnalyzer /app/ExoplanetAnalyzer

# Establece un valor predeterminado para APP_ENV
ENV APP_ENV=production

# Comando para ejecutar la aplicación
CMD ["./ExoplanetAnalyzer"]
