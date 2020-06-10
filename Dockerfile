FROM mcr.microsoft.com/dotnet/core/aspnet:2.1.19@sha256:c94e6889cdbaf5a89106733a798ec991da0a57fdb552127643153ce2250346b5 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.1.807@sha256:a43f9191449c65901d7b7573b225111c644f7a8028017e1d0cd80d9853e51ff2 AS build
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
