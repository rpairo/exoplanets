# Stage 1: Build
FROM swift:6.0.3 AS build

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/rpairo/exoplanets.git /app

# Build the application
RUN swift build --configuration release

# Stage 2: Runtime
FROM swift:6.0.3-slim

# Set working directory
WORKDIR /app

# Copy the built executable from the previous stage
COPY --from=build /app/.build/release/ExoplanetAnalyzer /app/ExoplanetAnalyzer

# Set a default environment variable
ENV APP_ENV=production

# Default command to run the application
CMD ["./ExoplanetAnalyzer"]
