ARG ARM_ARTIFACT_PATH
ARG AMD_ARTIFACT_PATH

FROM mcr.microsoft.com/dotnet/sdk:8.0 as lynxbuilder-arm64
ARG ARM_ARTIFACT_PATH
ONBUILD RUN test -n "$ARM_ARTIFACT_PATH"
ONBUILD COPY $ARM_ARTIFACT_PATH /lynx

FROM mcr.microsoft.com/dotnet/sdk:8.0 as lynxbuilder-amd64
ARG AMD_ARTIFACT_PATH
ONBUILD RUN test -n "$AMD_ARTIFACT_PATH"
ONBUILD COPY $AMD_ARTIFACT_PATH /lynx

############################################################
# Build Lynx
############################################################
FROM lynxbuilder-${TARGETARCH} as lynxbuilder
WORKDIR /lynx
RUN chmod +x Lynx.Cli &&\
    mv Lynx.Cli Lynx

############################################################
# Build lichess-bot
############################################################
FROM lynxbuilder as botbuilder
RUN apt-get update &&\
    apt-get install -y python3-venv
RUN git clone https://github.com/lynx-chess/lichess-bot.git /lynx_bot
WORKDIR /lynx_bot
RUN python3 -m venv .venv &&\
    . .venv/bin/activate &&\
    pip3 install wheel &&\
    pip3 install -r requirements.txt

############################################################
# Final base image
############################################################
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0 as lynxbase

############################################################
# Create final Lynx image
############################################################
FROM lynxbase as lynx
COPY --from=lynxbuilder /lynx lynx
WORKDIR /lynx
ENV PATH=/lynx:$PATH
CMD Lynx

############################################################
# Create final lynx_bot image
############################################################
FROM lynxbase as botbase
RUN apt-get update &&\
    apt-get install -y python3 &&\
    apt-get clean all

FROM botbase as lynx-bot
# Beware, changing botbuilder's directory name would break the python compilation
COPY --from=lynxbuilder /lynx /lynx
COPY --from=botbuilder /lynx_bot /lynx_bot
WORKDIR /lynx_bot
