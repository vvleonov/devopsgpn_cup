import sys
import os
sys.path.append(os.environ['WORKSPACE'] + '/lib')
import testinfra

def test_passwd_file(host):
    passwd = host.file("/etc/passwd")
    assert passwd.contains("root")
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.mode == 0o644
    print("User settings are correct")


def test_nginx_is_installed(host):
    nginx = host.package("nginx")
    assert nginx.is_installed
    assert nginx.version.startswith("1.20")
    print("Nginx older than 1.20 is installed")
	

def test_nginx_running_and_enabled(host):
    nginx = host.service("nginx")
    assert nginx.is_running
    assert nginx.is_enabled
    print("Nginx is running and enabled")
