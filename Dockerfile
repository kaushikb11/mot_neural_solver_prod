FROM python:3.7-slim
LABEL maintainer="Kaushik Bokka <kaushikbokka@gmail.com>"

ARG AWS_ACCESS_KEY_ID
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ARG AWS_SECRET_ACCESS_KEY
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

ENV CUDA cpu
ENV CUDA=${CUDA}

ENV VIDEO_URL=${VIDEO_URL}

ENV FPS=${FPS}

RUN apt-get update -y
RUN apt install git libgtk2.0-dev -y
RUN apt install ffmpeg -y
RUN pip install --upgrade pip

RUN pip install torch==1.6.0+cpu torchvision==0.7.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install torch-scatter==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-1.6.0.html
RUN pip install torch-sparse==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-1.6.0.html
RUN pip install torch-cluster==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-1.6.0.html
RUN pip install torch-spline-conv==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-1.6.0.html
RUN pip install torch-geometric


COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

CMD [ "python", "flow.py" ]
