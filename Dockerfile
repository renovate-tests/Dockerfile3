FROM mcr.microsoft.com/dotnet/core/aspnet:2.1.18@sha256:7000c71ad64ef922005ac3ea9ebd0daf2ecd4c4329dadfe56ca3b80433c82a51 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2.402@sha256:092a177c84f1dde6aacf0a60ce5f10132db017381f21912ecc6bb4a5eabae651 AS build
WORKDIR /src
COPY . .
RUN [...]

FROM build AS publish
WORKDIR /src/Web/Web.Startup
RUN [...]

FROM base AS final
WORKDIR /app
COPY --from=publish /app .

# Local
COPY /run-local.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
