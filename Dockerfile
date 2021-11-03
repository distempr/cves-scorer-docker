FROM python:3.9-bullseye

RUN apt-get update && apt-get install -y sqlite3 && rm -rf /var/lib/apt/lists/*
RUN useradd -r -d /var/lib/cves -s /bin/bash cves
RUN mkdir /usr/lib/cves /var/lib/cves && chown cves: /usr/lib/cves /var/lib/cves

WORKDIR /usr/lib/cves
COPY --chown=cves:cves src/requirements.txt .
RUN pip install --no-cache-dir --disable-pip-version-check -r requirements.txt

USER cves
ENV STANZA_RESOURCES_DIR=/usr/lib/cves/stanza
COPY --chown=cves:cves src/stanza-download .
RUN ./stanza-download

COPY --chown=cves:cves src/ .

CMD ["./run"]
