## Introduction

**Apache Guacamole** is a clientless remote desktop gateway. Users can access RDP, VNC, and SSH sessions directly from a browser without installing local client software.

## 1Panel Local App Notes

This directory has been converted to a **1Panel local app** layout:

- Uses official `guacamole/guacd` images
- Uses a **MySQL/MariaDB service managed by 1Panel**
- Initializes the database automatically during install with a one-shot setup container

## Default Login

- Username: `guacadmin`
- Password: `guacadmin`

Change the default password immediately after the first login.
