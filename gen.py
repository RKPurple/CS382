import random
class bcolors:
    HEADER      = '\033[95m'
    OKBLUE      = '\033[94m'
    OKCYAN      = '\033[96m'
    OKGREEN     = '\033[92m'
    WARNING     = '\033[93m'
    FAIL        = '\033[91m'
    ENDC        = '\033[0m'
    BOLD        = '\033[1m'
    UNDERLINE   = '\033[4m'


if __name__ == "__main__":
    
    instructions    = [
        "LDUR", "LDURSH", "LDURSB",
        "LDURH", "LDURB"
    ]
    
    dst_regs        =   ["X","W"]
    hexd            =   [str(x) for x in range(10)] + ["A","B","C","D","E","F"]
    size            =   32
    mem             =   [random.choice(hexd)+random.choice(hexd) for x in range(size)]
    address         =   random.choice(range(2048))
    reg_for_base    =   random.choice(range(20))
    base_reg        =   "X"+str(reg_for_base)
    base_pos        =   random.choice(range(size))

    
    print("The following is a segment of memory.")
    print("The address of a specific byte is stored in " + base_reg)
    
    print("High address")
    display_mem = mem[::-1]
    print(" "*(len(base_reg)+4) + "┠────┨")
    for k in range(size):
        if k == size-base_pos-1:
            print( "%s%s%s ->%s ┃ %s%s%s%s ┃" %
                    (bcolors.OKCYAN, bcolors.BOLD, base_reg, bcolors.ENDC,
                     bcolors.OKCYAN, bcolors.BOLD, display_mem[k], bcolors.ENDC )
                )
            print(" "*(len(base_reg)+4) + "┠────┨") 
        else:
            print((len(base_reg)+4)*" ", end = "")
            print( "┃ %s ┃" % (display_mem[k]))
            print(" "*(len(base_reg)+4) + "┠────┨")             
    print("Low address\n\n")
    
    
    
    
    
    while True:
        
        if random.getrandbits(1):
            rand_rt = random.choice(range(20))
            if rand_rt == reg_for_base: continue
            
            rand_size   =   "X" if random.getrandbits(1) else "W"
            dst_size    =   8   if rand_size == "X" else 4
            rand_off    =   random.choice(range(-1*base_pos, size-base_pos-dst_size))
            rand_ins    =   random.choice(instructions)
            
            data_size   =   2 if "H" in rand_ins \
                                else 1 if "B" in rand_ins \
                                else dst_size

            if size - base_pos < data_size: continue
            
            q = ("What will be stored in %s%d "
                 "after the following instruction:\n"
                 "%s  %s%d, [ X%d, %d ]") % (
                 rand_size, rand_rt,
                 rand_ins,
                 rand_size, rand_rt, reg_for_base, rand_off
                 )
            print(q)
            
            ans = input("0x")
            sol = ""
            if rand_ins == "LDUR":
                if rand_size == "X":
                    sol = "".join(mem[base_pos+rand_off:base_pos+rand_off+8][::-1])
                else:
                    sol = "".join(mem[base_pos+rand_off:base_pos+rand_off+4][::-1])
            
            else:
                data_size   = 2 if "H" in rand_ins else 1
                total_bytes = 8 if rand_size == "X" else 4
                padding     = total_bytes - data_size
                sol         = "".join(mem[base_pos+rand_off:base_pos+rand_off+data_size][::-1])
                if "S" not in rand_ins:
                    sol = "00"*padding + sol
                else:
                    sol = "00"*padding + sol if sol[0].isdigit() and int(sol[0]) < 8 \
                            else "FF"*padding + sol
            
            if ans.lower() == sol.lower():
                print(bcolors.OKGREEN+bcolors.BOLD+"Correct!\n\n"+bcolors.ENDC)
            else:
                print(bcolors.FAIL+bcolors.BOLD+"Wrong:\n0x"+sol+"\n"+bcolors.ENDC)
            
