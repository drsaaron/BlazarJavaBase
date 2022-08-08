# Start from alpine image
FROM maven:3-openjdk-17-slim

# setup timezone
ENV TZ=US/Central
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# this is the prod environment
ENV ENVIRONMENT prod

# define the user
RUN groupadd --gid 1001 blazar && useradd --uid 1001 --gid blazar --create-home scott

# create a workdir
WORKDIR /home/scott
ENV PATH /home/scott:$PATH

# add getPomAttribute.sh
ADD ./getPomAttribute.sh .


