FROM ghcr.io/qtvhao/debian-smb:main
RUN echo "deb http://mirror.sg.gs/debian/ bookworm main contrib non-free" > /etc/apt/sources.list
RUN echo "deb http://mirror.sg.gs/debian/ bookworm-updates main contrib non-free" >> /etc/apt/sources.list
WORKDIR /app/
USER root
RUN apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"
ENV PATH="/root/.local/share/pypoetry/venv/bin:${PATH}"
RUN poetry config virtualenvs.create false
RUN pip3 install torch==2.5.1 torchaudio==2.5.1 --index-url  https://download.pytorch.org/whl/cpu --no-cache-dir
RUN pip3 install triton==3.1.0 --no-cache-dir
