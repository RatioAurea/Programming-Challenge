FROM jupyter/datascience-notebook

USER root

RUN pip install pymongo && \
    pip install --timeout 1000 tensorflow && \
    pip install tensorflow_addons


