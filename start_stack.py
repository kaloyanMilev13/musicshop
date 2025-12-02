#!/usr/bin/env python3
import subprocess

def run(cmd):
    print("Running:", " ".join(cmd))
    # no sudo here because systemd will run this as root
    subprocess.check_call(cmd)

def main():
    # Start MariaDB first, then Apache
    run(["/usr/bin/systemctl", "start", "mariadb"])
    run(["/usr/bin/systemctl", "start", "httpd"])
    print("MariaDB and Apache (httpd) started.")

if __name__ == "__main__":
    main()
