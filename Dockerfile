FROM jaypickle/godot-build:3.1.2
LABEL author="james@pickett.me"

USER root
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]