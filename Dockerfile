#  Copyright 2014 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM centos
MAINTAINER Cato Johannessen "cjohannessen@us.ibm.com"

RUN curl -sSL https://github.com/amalgam8/amalgam8/releases/download/v0.4.2/a8sidecar.sh | sh

RUN yum -y install epel-release;\
	yum -y install nginx;\
	yum clean all

WORKDIR /var/www/html/
COPY ./ /var/www/html/


# Export port 80
EXPOSE 80

# This container is a web server serving PHP apps, so a plain Apache is our entry point
ENTRYPOINT ["a8sidecar", "--register", "--proxy", "/usr/sbin/nginx", ""]

## Inject environment variables into the microservices container
ENV A8_SERVICE=UI:v1.0
ENV A8_ENDPOINT_PORT=80
ENV A8_ENDPOINT_TYPE=http
ENV A8_REGISTRY_URL=http://dev-a8-registry-CBJ-123.mybluemix.net
ENV A8_CONTROLLER_URL=http://dev-a8-controller-CBJ-123.mybluemix.net

# Define command to run the application when the container starts
# CMD ["node", "/app/app.js"] 

