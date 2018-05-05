set server=itsofsrv01
set share=studentmat$

net use j: /d
net use j: \\%server%\%share% /persistent:yes

