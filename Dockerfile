FROM mcr.microsoft.com/dotnet/core/aspnet:2.1.18@sha256:7000c71ad64ef922005ac3ea9ebd0daf2ecd4c4329dadfe56ca3b80433c82a51 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.1.806@sha256:d6ce8ac1540697c2add1cf72ce322478909713f9c6f68cb7a56778752a1a0bc1 AS build
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
