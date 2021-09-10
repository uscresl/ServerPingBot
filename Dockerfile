FROM debian:11-slim

RUN apt-get update && apt-get install -y curl iputils-ping

RUN useradd --create-home pingbot
COPY pingbot.sh /home/pingbot
RUN chown pingbot:pingbot /home/pingbot/pingbot.sh
USER pingbot

WORKDIR /home/pingbot
CMD "./pingbot.sh"
