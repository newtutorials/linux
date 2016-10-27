    #!/bin/bash
    dynamicDNS_IP="$(dig +short your.dynamic.dns)"
    function valid_ip()
    {
        local  ip=$1
        local  stat=1
        if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
            OIFS=$IFS
            IFS='.'
            ip=($ip)
            IFS=$OIFS
            [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
                && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
            stat=$?
        fi
        return $stat
    }
        if valid_ip $dynamicDNS_IP
                then
                    #/sbin/service iptables restart #optional
                    /sbin/iptables -A INPUT -s $dynamicDNS_IP/32 -p tcp -m tcp -j ACCEPT
                    echo good ip $dynamicDNS_IP
                else
                    echo bad ip
        fi