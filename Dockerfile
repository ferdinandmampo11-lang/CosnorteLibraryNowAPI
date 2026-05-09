# Base runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Build image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy source code
COPY . .

# Restore dependencies
RUN dotnet restore "MuitLibraryNowAPI/MuitLibraryNowAPI.csproj"

# Publish application
RUN dotnet publish "MuitLibraryNowAPI/MuitLibraryNowAPI.csproj" \
    -c Release \
    -o /app/out

# Final image
FROM base AS final
WORKDIR /app

COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "MuitLibraryNowAPI.dll"]
