# syntax=docker/dockerfile:1
# Web version of P.E.U.C. — `docker compose up --build` → http://localhost:8080

# ---- 1. Compile the Flutter web app
FROM ghcr.io/cirruslabs/flutter:3.44.0 AS build
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
COPY analysis_options.yaml ./
COPY lib ./lib
COPY assets ./assets
COPY web ./web
RUN flutter build web --release --no-web-resources-cdn --no-wasm-dry-run --base-href /

# ---- 2. Serve it with an unprivileged nginx (runs as uid 101, port 8080)
FROM nginxinc/nginx-unprivileged:1.31.7-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
