## My Own Puppet Module
Install Gedit and plugins. Change it to default for HTML.

### Purpose
My Puppet module installs Gedit and the readily available plugins for Gedit. It changes the default application for HTML-files to Gedit and removes mousepad text editor.

The module is developed and tested on a Virtual Xubuntu Machine.

### Environment
**Oracle Virtualbox instance:** Xubuntu 16.04 | 1GB RAM | 8GB  HDD

**Host:** Windows 10 x64 | 6GB RAM | i5345 CPU @3.10GHz

### Prep:
    $sudo apt-get update
    $sudo apt-get upgrade

### Reasons and what it does
As a baseline, Gedit is much more versatile than the default Xubuntu text editor Mousepad. Some configuration is required to change the default text editor. The defaults.list file needs to be modified so it sets the application used for opening HTML files from Firefox to Gedit. Mousepad needs to be removed so Xubuntu actually uses gedit by default.

### Experimenting

### Sources
http://installion.co.uk/ubuntu/precise/universe/m/mousepad/uninstall/index.html
https://askubuntu.com/questions/13447/how-do-i-change-the-default-text-editor
