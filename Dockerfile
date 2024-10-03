FROM 882161362076.dkr.ecr.us-east-2.amazonaws.com/mvc-app:restore AS base

WORKDIR /app

COPY DockerProject /app/DockerProject

RUN dotnet publish DockerProject/DockerProject.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS runtime

RUN echo '#!/bin/bash' > /root/start.sh && \
    echo 'apache2ctl -D FOREGROUND &' >> /root/start.sh && \
    echo 'cd /app && dotnet DockerProject.Api.dll --urls http://0.0.0.0:5000' >> /root/start.sh

EXPOSE 80 443

RUN chmod +x /root/start.sh

CMD ["/root/start.sh"]