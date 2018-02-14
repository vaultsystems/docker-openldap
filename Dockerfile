FROM osixia/openldap
ENV ldap_version 2.4.44
ENV ppm_version 1.6
RUN export packages="build-essential libcrack2-dev wget libdb-dev libldap2-dev" && apt-get -y update && \
    apt-get -y install $packages && wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-$ldap_version.tgz && \
    wget https://github.com/ltb-project/ppm/archive/v$ppm_version.tar.gz && \
    tar xfz openldap-$ldap_version.tgz && tar xfz v$ppm_version.tar.gz -C /openldap-$ldap_version/ && \
    cd openldap-$ldap_version && ./configure && make depend && cd ppm-$ppm_version && \
    make CONFIG=/etc/openldap/ppm.conf LIBDIR=/usr/lib/x86_64-linux-gnu && cp ppm.so /usr/lib/ldap/ppm.so && \
    cp ppm.conf /etc/ldap/ppm.conf.example && \
    apt-get -y purge $packages && apt-get -y autoremove && \
    rm -rf /openldap-$ldap_version /openldap-$ldap_version.tgz /v$ppm_version.tar.gz
