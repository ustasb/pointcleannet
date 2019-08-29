FROM ubuntu:16.04

RUN apt-get update && apt-get -y install \
  git

# Point Cloud
# https://github.com/strawlab/python-pcl
RUN apt-get -y install \
  python2-pip

RUN pip install numpy
RUN pip install scipy
RUN pip install tensorboardX
RUN pip install torch

WORKDIR /opt
RUN git clone --depth 1 https://github.com/ustasb/pointcleannet.git && \
  cd data && \
  python download_data.py --task denoising && \
  python download_data.py --task outliers_removal && \
  cd ../models && \
  python download_models.py --task denoising && \
  python download_models.py --task outliers_removal

# apt-get cleanup
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /opt

CMD ["/bin/bash"]
