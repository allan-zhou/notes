# LDAP Manual

LDAP(/ˈɛldæp/)是轻量目录访问协议，英文全称是Lightweight Directory Access Protocol，一般简称为LDAP。
> The Lightweight Directory Access Protocol  is an open, vendor-neutral, industry standard application protocol for accessing and maintaining distributed directory information services over an Internet Protocol (IP) network.

- LDAP经典用途：用来存储用户账户、密码，以及允许其他应用程序连接LDAP server验证用户
> A common use of LDAP is to provide a central place to store usernames and passwords. This allows many different applications and services to connect to the LDAP server to validate users.

- LDAP基于x.500标准
> LDAP is based on a simpler subset of the standards contained within the X.500 standard. Because of this relationship, LDAP is sometimes called X.500-lite.

- LDAP核心规范定义[RFC4511](https://tools.ietf.org/html/rfc4511)

## Directory structure 目录结构

The protocol provides an interface with directories that follow the 1993 edition of the X.500 model：

- **An entry** consists of a set of attributes.
- **An attribute** has a name (an attribute type or attribute description) and one or more values.
- Each entry has a unique identifier: its **Distinguished Name (DN)**. This consists of its Relative Distinguished Name (RDN), constructed from some attribute(s) in the entry, followed by the parent entry's DN. Think of the DN as the full file path and the RDN as its relative filename in its parent folder (e.g. if /foo/bar/myfile.txt were the DN, then myfile.txt would be the RDN).

```plain text
 dn: cn=John Doe,dc=example,dc=com
 cn: John Doe
 givenName: John
 sn: Doe
 telephoneNumber: +1 888 555 6789
 telephoneNumber: +1 888 555 1232
 mail: john@example.com
 manager: cn=Barbara Doe,dc=example,dc=com
 objectClass: inetOrgPerson
 objectClass: organizationalPerson
 objectClass: person
 objectClass: top
```

> "**dn**" is the distinguished name of the entry; it is neither an attribute nor a part of the entry.
>
> "**cn=John Doe**" is the entry's RDN (Relative Distinguished Name), and "dc=example,dc=com" is the DN of the parent entry, where "dc" denotes 'Domain Component'.
>
> The other lines show the attributes in the entry.

## Operations 操作

- Add
- Bind (authenticate)
- Delete
- Search and Compare
- Modify
- Modify DN
- Extended operations
- Abandon
- Unbind

## URI scheme

```plain text
ldap://host:port/DN?attributes?scope?filter?extensions
```

## Glossary

### Directory services

In computing, directory service or name service maps the names of network resources to their respective network addresses.

 A directory service is a critical component of a network operating system.

### [X.500](https://en.wikipedia.org/wiki/X.500)

X.500是一系列涵盖电子目录服务的计算机网络标准。

X.500 include:

- DAP (Directory Access Protocol)
- DSP (Directory System Protocol)
- DISP (Directory Information Shadowing Protocol)
- DOP (Directory Operational Bindings Management Protocol)

### [LDIF](https://en.wikipedia.org/wiki/LDAP_Data_Interchange_Format)

- LDAP数据交换格式，简称为LDIF（LDAP Data Interchange Format）
> LDIF is a standard plain text data interchange format for representing LDAP directory content and update requests.LDIF conveys directory content as a set of records, one record for each object (or entry). It also represents update requests, such as Add, Modify, Delete, and Rename, as a set of records, one record for each update request.

- Each content record is represented as a group of attributes,with records separated from one another by blank lines.

- The individual attributes of a record are represented as single logical lines, comprising "name: value" pairs.

### LDIF fileds

- dn : distinguished name

This refers to the name that uniquely identifies an entry in the directory.

- dc : domain component

this refers to each component of the domain. For example www.google.com would be written as DC=www,DC=google,DC=com

- ou : organizational unit

This refers to the organizational unit (or sometimes the user group) that the user is part of. If the user is part of more than one group, you may specify as such, e.g., OU= Lawyer,OU= Judge.

- cn : common name

This refers to the individual object (person's name; meeting room; recipe name; job title; etc.) for whom/which you are querying.

### Entry

LDAP 信息被组织成属性和值的组合，称为条目（entry）。

条目可能会具有必须的属性或可选属性。一个条目的属性必须要遵循 /etc/openldap/schema/ 模式文件中定义的规则。

### DSA

A client starts an LDAP session by connecting to an LDAP server, called a Directory System Agent (DSA)

### LDAPS

LDAP over SSL

## Reference

- [LDAP intro](http://www.openldap.org/doc/admin24/intro.html)
