FROM jaypickle/godot-build:3.1.2
LABEL author="james@pickett.me"

COPY ./edit-tres.sh /edit-tres.sh
RUN chmod +x edit-tres.sh

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
