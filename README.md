# adinstaller
The adinstaller script was designed to automate the AD package installation and configuration task on multiple linux servers
without the need to log into each of them individually. You will need access to a central administrative account with the same
password on each machine. The user name and password will go into the python script. 

---===---===---===---

In order to make AD groups work with /etc/sudoers, the entry must look like this example:

+domain_name\\sudoers ALL=(ALL) ALL

---===---===---===---
