#!/usr/bin/python

import platform
import psutil
import sys

class Server():
    """Server constructor: gathers system info about local host"""
    def __init__(self):
        self.fqdn = platform.node()
        self.mem = psutil.virtual_memory()
        self.cpuPercent = psutil.cpu_times_percent()
        self.cpuCount = psutil.cpu_count()
        self.diskParts = psutil.disk_partitions(all=False)

def convert_bytes(n):
    """Convert bytes to readable format"""
    symbols = ('K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y')
    prefix = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i + 1) * 10
    for s in reversed(symbols):
        if n >= prefix[s]:
            value = float(n) / prefix[s]
            return '%.1f%s' % (value, s)
    return "%sB" % n

def print_(a, b):
    """Print pretty value pair"""
    if sys.stdout.isatty() and psutil.POSIX:
        fmt = '\x1b[1;32m%-13s\x1b[0m %s' % (a, b)
    else:
        fmt = '%-11s %s' % (a, b)
    print(fmt)

def main():
    """Main Program"""
    a = Server()
    print
    print_('Hostname', a.fqdn)
    print_('Core Count', a.cpuCount)
    print_('CPU Idle', a.cpuPercent.idle)
    print_('Total Memory',convert_bytes(a.mem.total))
    print_('Free Memory',convert_bytes(a.mem.free))
    # Disk Usage
    print_('Disk Usage:','')
    templ = "%-17s %8s %8s %8s %5s%% %9s  %s"
    print(templ % ("Device", "Total", "Used", "Free", "Use ", "Type", "Mount"))
    for part in a.diskParts:
        usage = psutil.disk_usage(part.mountpoint)
        print(templ % (
            part.device,
            convert_bytes(usage.total),
            convert_bytes(usage.used),
            convert_bytes(usage.free),
            int(usage.percent),
            part.fstype,
            part.mountpoint))
    print

if __name__ == '__main__':
    main()
