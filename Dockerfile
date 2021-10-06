### Build from the minimal Alpine-based Python image
FROM python:3.7-alpine

### Allow to set-up HTTP(S) proxy using '--build-arg'
ARG http_proxy
ENV http_proxy ${http_proxy}
ARG https_proxy
ENV https_proxy ${https_proxy}
RUN echo 'http_proxy='$http_proxy'\nhttps_proxy='$https_proxy

### Configuration settings & options
ENV WORKSPACE           /opt
ENV APP                 $WORKSPACE/app

WORKDIR $APP
COPY . $APP
RUN if [ -f "requirements.txt" ]; then \
        pip_args=""; \
        [ ! -z "$http_proxy"  ] && set pip_args+=" --proxy $http_proxy"; \
        [ ! -z "$https_proxy" ] && set pip_args+=" --proxy $https_proxy"; \
        pip install $pip_args -r $APP/requirements.txt; \
    fi

### Unset variables
ENV http_proxy ""
ENV https_proxy ""

CMD ["python", "main.py"]
