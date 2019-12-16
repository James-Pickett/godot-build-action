FROM jaypickle/godot-build:3.1.2
LABEL author="james@pickett.me"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
