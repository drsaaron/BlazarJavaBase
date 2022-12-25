# Start from alpine image
FROM maven:3-openjdk-18-slim

# setup timezone
ENV TZ=US/Central
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# this is the prod environment
ENV ENVIRONMENT prod

# define the user
ARG LOCAL_USER
ARG LOCAL_USER_ID
ARG LOCAL_GROUP
ARG LOCAL_GROUP_ID
RUN groupadd --gid $LOCAL_GROUP $LOCAL_GROUP_ID && useradd --uid $LOCAL_USER --gid $LOCAL_GROUP_ID --create-home $LOCAL_USER_ID

# create a workdir
WORKDIR /home/$LOCAL_USER_ID
ENV PATH /home/$LOCAL_USER_ID:$PATH

# add getPomAttribute.sh
ADD ./getPomAttribute.sh .


