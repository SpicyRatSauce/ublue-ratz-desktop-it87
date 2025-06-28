#!/usr/bin/env bash
set -oue pipefail

echo "--- Debugging Kernel Info ---"
        echo "Current kernel (uname -r):"
        uname -r
        echo "Kernel version (uname -v):"
        uname -v
        echo "OS release info (cat /etc/os-release):"
        cat /etc/os-release
        echo "Content of /lib/modules/:"
        ls -l /lib/modules/
        echo "Installed kernel packages (rpm -qa 'kernel*' | sort):"
        rpm -qa 'kernel*' | sort
        echo "--- End Debugging Kernel Info ---"
