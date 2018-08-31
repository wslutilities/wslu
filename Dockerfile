FROM patrick330602/fake_wsl_env

RUN apt -y update
RUN apt -y install apt-utils mime-support
