# Start from alpine image
FROM eclipse-temurin

# setup timezone
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install curl for the health check
RUN apt update && apt install -y jq curl

# this is the prod environment
ENV ENVIRONMENT=prod

# define the user
ARG LOCAL_USER
ARG LOCAL_USER_ID
ARG LOCAL_GROUP
ARG LOCAL_GROUP_ID
RUN groupadd --gid $LOCAL_GROUP $LOCAL_GROUP_ID && useradd --uid $LOCAL_USER --gid $LOCAL_GROUP_ID --create-home $LOCAL_USER_ID

# create a workdir
WORKDIR /home/$LOCAL_USER_ID
ENV PATH=/home/$LOCAL_USER_ID:$PATH

# add getPomAttribute.sh
ADD ./getPomAttribute.sh .


