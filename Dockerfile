# syntax=docker/dockerfile:1

# setting up our operating system
ARG VARIANT="20"
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

# Install some generally useful tools particularly for development in devcontainer
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    curl git sqlite3 entr source-highlight

# set user node
USER node

# installation of CDS-DK globally inside the container
# You can choose to ignore this command if you are configuring cds-dk within you dependencies
ARG CAPVER="latest"
RUN npm install -g @sap/cds-dk@$CAPVER

# not necessary
# vi mode everywhere and nicer prompt KTHXBAI
RUN cat <<EOBASHRC >> /home/node/.bashrc
export EDITOR=vi
set -o vi
bind -x '"\C-l": clear'
EOBASHRC

RUN echo 'export PS1=${PS1/\$ /\\\\n$ }' >> /home/node/.bashrc

# Go to our directory where we will store our codes
WORKDIR /home/node

# Copy your SAP CAP project files(current path of Dockerfile) into the container path "./home/node/"
COPY . /home/node/

# # # Install dependencies (needed)
# it will neglect the packages for devDependencies
RUN npm install --omit=dev

# Start your CAP application
CMD ["npm", "start"]

# Important for exposing our service
EXPOSE 4004