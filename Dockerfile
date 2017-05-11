FROM honigwasser/base-ruby-gem

RUN apt-get update && \
	apt-get install -y --no-install-recommends imagemagick && \
	apt-get clean

WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
ADD ./*.gemspec dummy.gemspec
RUN bash -l -c "bundle install -j16"
ADD ./lib lib
RUN rm -rf /tmp/*
WORKDIR /app
