# SSH-Notifications

<p align="left">
<img alt="SSH" src="https://cdn-icons-png.flaticon.com/512/5261/5261867.png" width="112" height="112" >
<br>A Discord Webhook System To Alert Developers To SSH Logins</p>

## Required Dependencies:

- [curl](https://curl.se)
- [jq](https://stedolan.github.io/jq/)
- [git](https://git-scm.com)
- [dnsutils](https://phoenixnap.com/kb/linux-dig-command-examples#:~:text=The%20dig%20command%20in%20Linux,used%20to%20display%20DNS%20information.)

## 1. Setting Up The Script:

1. [Configure The Webhook](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks) In Your Discord Channel
2. Installer The Required Packages **JQ** , **curl**, **git** `sudo apt install jq curl git dnsutils -y`
3. Clone The Repo `git clone https://github.com/Kyle8973/SSH-Notifications/` 
5. CD Into The Folder **SSH-Notifications** `cd SSH-Notifications`
6. Move The File To The Required Location **ssh-notify.sh** Moves To **/etc/profile.d/** `sudo mv ssh-notify.sh /etc/profile.d/`
7. Make The Script Executable `sudo chmod +x /etc/profile.d/ssh-notify.sh`
8. Add Your Discord Webhook Link In The Script
Look For The Line WEBHOOK="" And Replace your_url With The Webhook Link. `sudo nano /etc/profile.d/ssh-notify.sh.`
To Save: `ctrl +x` Type y And Hit Enter
9. Restart The SSH Service `sudo systemctl restart sshd`.
10. Relogin In And Test It Works!

## 2. Breif Overview: 

![Screenshot](https://imgur.com/eKwKtjk.png)
