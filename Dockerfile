FROM stereolabs/zed:5.5-runtime-l4t-r36.5

LABEL org.opencontainers.image.title="semantic-layer"
LABEL org.opencontainers.image.description="WATCHER Semantic Navigation development environment (ZED SDK baseline)"

WORKDIR /workspace

CMD ["/bin/bash"]