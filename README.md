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

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

##Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

##Limitations

This is where you list OS compatibility, version compatibility, etc.

##Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.
