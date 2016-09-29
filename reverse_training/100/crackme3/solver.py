#!/usr/bin/env python

import re
from pwn import *
from itertools import product


def solve():
	username = 'username'
	alphabet = ''.join([chr(i) for i in range(33,127)])
	for part_1 in product(alphabet, repeat=4):
		for part_2 in product(alphabet, repeat=4):
#			p = process('./Crackme3')
			serial = ''.join(part_1) + '-' + ''.join(part_2)
			print 'Username: ' + username + '\nSerial: ' + serial


if __name__ == "__main__":
	context.log_level = 'debug'
	solve()
