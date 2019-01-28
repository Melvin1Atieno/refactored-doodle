#Use ruby 2.5 as base image
FROM ruby:2.5
#update package database, install postgres(preferred database) and install nodejs a javascript runtime required by rails for [minifica.
RUN apt-get update && apt-get install -y postgresql-client nodejs
#create a directory into which the app contents will be added
RUN mkdir /myapp
#Make it the working directory. This basically means the directory into which your commands wiill be run
WORKDIR /myapp
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
#Copy the created gemfile with the rails gem which will simply load rails. It will be overwritten by the rails new command
COPY Gemfile /myapp/Gemfile
#An empty gemfile lock to build the dockerfile
COPY Gemfile.lock /myapp/Gemfile.lock
#bundle install to install the required gems into the container
RUN bundle install
#copy generated app contents into my app
COPY . /myapp
#Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
#Give container user executable rights.
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
#expose port
EXPOSE 3000
#change container UID and GID to match that of the host
USER 1000:1000
#Starting up the Web Server
CMD ["rails", "server", "-b", "0.0.0.0"]