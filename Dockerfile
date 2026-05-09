# =====================================
# Base Runtime Image
# =====================================
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

WORKDIR /app

EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080


# =====================================
# Build Stage
# =====================================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy all files
COPY . .

# Restore dependencies
RUN dotnet restore "*.csproj"

# Publish application
RUN dotnet publish "*.csproj" \
    -c Release \
    -o /app/out


# =====================================
# Final Runtime Image
# =====================================
FROM base AS final

WORKDIR /app

COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "CosnorteLibraryNowAPI.dll"]
