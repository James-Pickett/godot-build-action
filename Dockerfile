FROM jaypickle/godot-build:3.1.2
LABEL author="james@pickett.me"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]