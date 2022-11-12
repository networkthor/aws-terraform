[web_servers]
%{ for ip in web-srv ~}
${ip} ansible_user=ubuntu
%{ endfor ~}
