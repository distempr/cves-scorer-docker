FROM python:3.9-bullseye

RUN apt-get update && apt-get install -y sqlite3 && rm -rf /var/lib/apt/lists/*
RUN useradd -r -d /var/lib/cves -s /bin/bash cves
RUN mkdir /usr/lib/cves /var/lib/cves /var/lib/cves/data && \
  chown cves: /usr/lib/cves /var/lib/cves /var/lib/cves/data

WORKDIR /usr/lib/cves

USER cves
COPY --chown=cves:cves src/requirements.txt .
RUN pip install \
    --no-warn-script-location \
    --no-cache-dir \
    --disable-pip-version-check \
    --user \
    --requirement requirements.txt

ENV STANZA_RESOURCES_DIR=/usr/lib/cves/stanza
COPY --chown=cves:cves src/stanza-download .
RUN ./stanza-download

COPY --chown=cves:cves src/ .

CMD ["./cves-scorer"]
