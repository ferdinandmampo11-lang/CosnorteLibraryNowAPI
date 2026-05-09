FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASNETCORE_URLS=https://+:8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore  "MuitLibraryNowAPI/MuitLibraryNowAPI.csproj"
RUN dotnet publish "MuitLibraryNowAPI/MuitLibraryNowAPI.csproj" -c Reslease -o /app/out

FROM base AS final
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "MuitLibraryNowAPI.dll"]
