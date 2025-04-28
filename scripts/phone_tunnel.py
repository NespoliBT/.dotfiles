import os
import nmap

nm = nmap.PortScanner()

# check if mounted
mounted = os.popen('gio mount -l | grep ftp').read().strip()

def divider():
    # divider based on the terminal width
    try:
        columns = os.get_terminal_size().columns
        print("-" * columns)
    except:
        pass
    

# run nmap and find the IP address of the phone
def get_phone_ip():
    divider()

    # find the network to scan
    print("Finding network...")
    network = os.popen('ip route | grep default | awk \'{print $3}\'').read().strip()
    print(f'Network: {network}')

    phone_ip = ""
    
    divider()
    print("Finding phone IP...")
    nm.scan(hosts=f"{network}-100", arguments='-p 4445')  # Scan for port 4445
    for host in nm.all_hosts():
        for proto in nm[host].all_protocols():
            lport = nm[host][proto].keys()
            for port in lport:
                state = nm[host][proto][port]["state"]
                if state != "closed":
                    phone_ip = host

    print(f"Phone IP: {phone_ip}")
    divider()

    return phone_ip

# get arguments from the command line, run the script if the argument is 'phone'
if len(os.sys.argv) > 1:
    if os.sys.argv[1] == 'mount':
        phone_ip = get_phone_ip()
        if(not phone_ip):
            print("Phone not found")
            exit()

        os.system('gio mount -s ftp')
        os.system('rm -rf ~/telefono')

        if phone_ip:
            os.system(f'echo -e 69420 | gio mount ftp://admin@{phone_ip}:4445')

            # symlink the folder
            os.system(f'ln -s /run/user/1000/gvfs/ftp\:host\={phone_ip}\,port\=4445\,user\=admin/ ~/telefono')
            
            divider()
            print("Phone mounted")
    elif os.sys.argv[1] == 'status':
        if mounted:
            print("true")
        else:
            print("false")
    else:
        print("Usage: phone_tunnel.py [mount|status]")
else:
    print("Usage: phone_tunnel.py [mount|status]")