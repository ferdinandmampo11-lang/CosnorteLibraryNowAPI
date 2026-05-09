# ==============================
# Base Runtime Image
# ==============================
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

WORKDIR /app

# Expose application port
EXPOSE 8080

# Configure ASP.NET Core to listen on port 8080
ENV ASPNETCORE_URLS=http://+:8080


# ==============================
# Build Stage
# ==============================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy all project files
COPY . .

# Restore NuGet packages
RUN dotnet restore "MuitLibraryNowAPI/MuitLibraryNowAPI.csproj"

# Publish application
RUN dotnet publish "MuitLibraryNowAPI/MuitLibraryNowAPI.csproj" \
    -c Release \
    -o /app/out


# ==============================
# Final Runtime Image
# ==============================
FROM base AS final

WORKDIR /app

# Copy published files from build stage
COPY --from=build /app/out .

# Run the application
ENTRYPOINT ["dotnet", "MuitLibraryNowAPI.dll"]
