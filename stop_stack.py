#!/usr/bin/env python3
import subprocess

def run(cmd):
    print("Running:", " ".join(cmd))
    subprocess.check_call(cmd)

def main():
    # Stop Apache first, then MariaDB
    run(["/usr/bin/systemctl", "stop", "httpd"])
    run(["/usr/bin/systemctl", "stop", "mariadb"])
    print("Apache (httpd) and MariaDB stopped.")

if __name__ == "__main__":
    main()
