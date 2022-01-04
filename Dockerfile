# Start from alpine image
FROM openjdk:17-alpine

# this is the prod environment
ENV ENVIRONMENT prod

# create a workdir
WORKDIR /app
ENV PATH /app:$PATH

# add getPomAttribute.sh
ADD ./getPomAttribute.sh .

# setup timezone
RUN apk add tzdata
ENV TZ=US/Central
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


