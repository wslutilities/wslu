# A copy of robertdebock/github-action-rpmbuild because that one don't work
FROM rockylinux/rockylinux:8

WORKDIR /github/workspace

RUN dnf install -y make tar gzip rpmdevtools dnf-utils spectool dnf-utils && \
    dnf clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec && \
    yum-builddep --assumeyes SPECS/*.spec && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec