FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder

WORKDIR /app

COPY DockerProject /app/DockerProject

RUN dotnet publish DockerProject/DockerProject.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app

COPY --from=builder /app/publish .

EXPOSE 5000

CMD ["dotnet", "DockerProject.dll", "--urls", "http://0.0.0.0:5000"]
