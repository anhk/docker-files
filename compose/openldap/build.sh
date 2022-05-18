#!/bin/bash

mkdir -p ./certs ./ldif

prepareSSL(){
# 生产证书
    export base_dir="./certs"
    export map_dir="/opt/certs"
    openssl genrsa -out "${base_dir}/rootCA.key" 2048
    openssl req -x509 -new -nodes -subj "/C=CN/CN=IR0CN-CA"  -key "${base_dir}/rootCA.key" -sha256 -days 1024 -out "${base_dir}/rootCA.pem"
    openssl genrsa -out "${base_dir}/ldap.key" 2048
    openssl req -new -subj "/C=CN/CN=ldap-server.ir0.cn" -key "${base_dir}/ldap.key" -out "${base_dir}/ldap.csr"
    openssl x509 -req -in "${base_dir}/ldap.csr" -CA "${base_dir}/rootCA.pem" -CAkey "${base_dir}/rootCA.key" \
        -CAcreateserial -out "${base_dir}/ldap.crt" -days 3650 -sha256

    cat > "${base_dir}/certs.ldif" << EOF
dn: cn=config
changetype: modify
replace: olcTLSCACertificateFile
olcTLSCACertificateFile: "${map_dir}/rootCA.pem"

dn: cn=config
changetype: modify
replace: olcTLSCertificateFile
olcTLSCertificateFile: "${map_dir}/ldap.crt"

dn: cn=config
changetype: modify
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: "${map_dir}/ldap.key"
EOF

# 给 key 授权（key 默认是600，docker 容器是 nonroot 运行，无法读取）
    chmod 644 ${base_dir}/*.key
}

prepareLDIF(){
    # memberOf
    export base_dir="./ldif"
    cat > "${base_dir}/memberof_conf.ldif" << EOF
#开启memberof支持
dn: cn=module{0},cn=config
cn: modulle{0}
objectClass: olcModuleList
objectclass: top
olcModuleload: memberof
olcModulePath: /opt/bitnami/openldap/lib/openldap

#新增用户支持memberof配置
dn: olcOverlay={0}memberof,olcDatabase={2}hdb,cn=config
objectClass: olcConfig
objectClass: olcMemberOf
objectClass: olcOverlayConfig
objectClass: top
olcOverlay: memberof
olcMemberOfDangling: ignore
olcMemberOfRefInt: TRUE
olcMemberOfGroupOC: groupOfUniqueNames
olcMemberOfMemberAD: uniqueMember
olcMemberOfMemberOfAD: memberOf
EOF

    cat > "${base_dir}/refint1.ldif" << EOF
dn: cn=module{0},cn=config
add: olcmoduleload
olcmoduleload: refint
EOF

    cat > "${base_dir}/refint2.ldif" << EOF
dn: olcOverlay=refint,olcDatabase={2}hdb,cn=config
objectClass: olcConfig
objectClass: olcOverlayConfig
objectClass: olcRefintConfig
objectClass: top
olcOverlay: refint
olcRefintAttribute: memberof uniqueMember  manager owner
EOF

    # ppolicy 用户安全策略
    cat > "${base_dir}/mod_ppolicy.ldif" << EOF
dn: cn=module{0},cn=config
changetype: modify
add: olcModuleLoad
olcModuleLoad: ppolicy
EOF

    cat > "${base_dir}/ppolicy.ldif" << EOF
dn: olcOverlay=ppolicy,olcDatabase={2}hdb,cn=config
changeType: add
objectClass: olcOverlayConfig
objectClass: olcPPolicyConfig
olcOverlay: ppolicy
olcPPolicyDefault: ou=users,dc=ichilson,dc=com
olcPPolicyHashCleartext: TRUE
EOF

# 允许用户自己改密码
    cat > "${base_dir}/self_change_passwd.ldif" << EOF
dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcAccess
olcAccess: {0}to attrs=userPassword by self write by dn.base="cn=admin,dc=ichilson,dc=com" write by anonymous auth by * none

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcAccess
olcAccess: {1}to * by dn.base="cn=admin,dc=ichilson,dc=com" write by self write by * read
EOF

}


prepareSSL && prepareLDIF

#docker build -t ir0cn/openldap .



