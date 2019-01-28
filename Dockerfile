#Use ruby 2.5 as base image
FROM ruby:2.5
#update package database, install postgres(preferred database) and install nodejs a javascript runtime required by rails for [minifica.
RUN apt-get update && apt-get install -y postgresql-client nodejs
# Add user deploy
# RUN adduser deploy --gecos '' --disabled-password
#Add first script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
#Give container user executable rights.
RUN chmod +x /usr/bin/entrypoint.sh
#create a directory
RUN mkdir /myapp
# make user current user
# USER deploy
#Copy the created gemfile with the rails gem which will simply load rails. It will be overwritten by the rails new command
COPY Gemfile Gemfile.lock /myapp/
#Make it the working directory. This basically means the directory into which your commands wiill be run
WORKDIR /myapp
#bundle install to install the required gems into the container
RUN bundle install
#copy generated app contents into my app
COPY . /myapp
#add the scripts 
ENTRYPOINT ["entrypoint.sh"]
#expose port
EXPOSE 3000
#Starting up the Web Server
CMD ["rails", "server", "-b", "0.0.0.0"]