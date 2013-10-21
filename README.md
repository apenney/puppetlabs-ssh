#ssh

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#ssh-description)
3. [Setup - The basics of getting started with [Ssh]](#setup)
    * [What [Ssh] affects](#what-[ssh]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [Ssh]](#beginning-with-[Ssh])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module manages sshd, global ssh client configuration, and user ssh client configuration.

##Module Description

This module manages OpenSSH and the associated configuration with both server and clients.  It'll also allow you to configure per user configuration.

##Setup

###What [Ssh] affects

* sshd_config
* ssh_config
* ~/.ssh/ files.
* sshd daemon.

###Beginning with [Ssh]  

In order to ensure sshd is running you just need to:

```
include ssh::server
```

##Usage

The two main classes for this module are `ssh::server` and `ssh::client`.  Through these two classes you should be able to manage ssh comprehensively.

##Reference

###Classes

* ssh::client          - Main class for managing the ssh client global settings.
* ssh::client::install - Installs the main ssh client.
* ssh::client::config  - Configs the main ssh client.
* ssh::server          - Main class for managing the ssh server.
* ssh::server::install - Installs the ssh server.
* ssh::server::config  - Configures the ssh server.
* ssh::server::service - Configures the ssh service.

###Parameters

###ssh::server

####`config_ensure`

Should the config file be present or absent.

####`config_path`

The path for the configuration file.

####`package_ensure`

Should the package be present or absent.

####`package_name`

What is the name of the ssh server package?

####`service_ensure`

Should be the service be running or stopped.

####`service_name`

What is the name of the ssh server service?

####`port`

What port should sshd listen on?

####`protocol`

What ssh protocols should be supported?

####`permit_root_password`

Should you be allowed to log in to root via password?

####`password_authentication`

Should you be allowed to log in via passwords?

####`sftp_path`

The path of the sftp binary.

####`hostkeys`

List of hostkeys to include.

###ssh::client

####`config_ensure` 

Should the config file be present or absent.

####`config_path`

The path for the configuration file.

####`package_ensure`

Should the package be present or absent.

####`package_name`

What is the name of the ssh client package?

##Limitations

This module only supports the following osfamily:

* Debian
* RedHat

##Development
