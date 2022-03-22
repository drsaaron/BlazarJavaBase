# Start from alpine image
FROM maven:3-openjdk-17-slim

# this is the prod environment
ENV ENVIRONMENT prod

# create a workdir
WORKDIR /app
ENV PATH /app:$PATH

# add getPomAttribute.sh
ADD ./getPomAttribute.sh .

# setup timezone
ENV TZ=US/Central
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


