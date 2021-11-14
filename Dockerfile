#'''''''''''''''''''''''''''''''''''''''''''''
# Dockerfile for building "LearnGitBranching" 
# web application
#'''''''''''''''''''''''''''''''''''''''''''''

FROM nginx:stable

ARG PORT

RUN apt-get update && \
apt-get -y install gnupg git python3-minimal python3-setuptools

RUN git clone https://github.com/pytest-dev/pytest-testinfra && \
cd pytest-testinfra && python3 setup.py install

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" \
| tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
apt-get -y install yarn

COPY ./ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/nginx.conf && nginx -g 'daemon off;'

WORKDIR /usr/share/nginx/html

RUN yarn install && \
yarn gulp fastBuild

