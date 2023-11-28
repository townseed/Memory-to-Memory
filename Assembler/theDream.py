# Wecome to the rice fields MF

f = open("fib.txt", "r")
content = f.readlines()
dest = "-1"
rs1 = "-1"
rs2 = "-1"
opcode = '0'
finalString = ""
currentAddress = 0
lables = {"start" : 0x0}
names = {"nonsenseLable" : 0xf001,
         "Input" : 0xf010,
         "Output" : 0xfffe}
set = set()
hm = {}
global namespaceLocation
namespaceLocation = 65280
def makeNewAddress(name):
    global namespaceLocation
    names[name] = namespaceLocation
    namespaceLocation += 2
    return namespaceLocation

# goofy thing, but pushra needs a space in the input.txt otherwise it reads it as a label

def setOpcode(currentElement):
    match currentElement:
        case "add":
            opcode = "00"
        case "sub":
            opcode = "60"
        case "or":
            opcode = "01"
        case "and":
            opcode = "02"
        case "xor":
            opcode = "04"
        case "srl":
            opcode = "3e"
        case "sll":
            opcode = "3c"
        case "sri":
            opcode = "38"
        case "sili":
            opcode = "7c"
        case "slli":
            opcode = "7c"
        case "addi":
            opcode = "80"
        case "andi":
            opcode = "82"
        case "ori":
            opcode = "81"
        case "xori":
            opcode = "84"
        case "j":
            opcode = "a0"
        case "ja":
            opcode = "20"
        case "push":
            opcode = "5f"
        case "pop":
            opcode = "5e"
        case "beq":
            opcode = "30"
        case "blt":
            opcode = "3a"
        case "bge":
            opcode = "34"
        case "bne":
            opcode = "39"
        case "beqi":
            opcode = "b0"
        case "blti":
            opcode = "ba"
        case "bnei":
            opcode = "b9"
        case "bgei":
            opcode = "b4"
        case "bgti":
            opcode = "a4"
        case "blei":
            opcode = "ac"
        case "pushra":
            opcode = "7f"
        case "mov":
            opcode = "bf"
        case _:
            lables[currentElement] = currentAddress
            return "hasLabel"
    return opcode

# for command in content:
#     inst = command.partition(' ')[0]
#     OP = setOpcode(inst)

# def tohex16bit(val):
#     return hex((val + (1 << 16)) % (1 << 16))[2:].zfill(4)

for command in content:
    # print(command)
    insts = command
    command = command.split(" ") # space deliniation
    command = [i.strip() for i in command] #get rid of all \n and spaces
    i = 0
    currentElement = command[i]
    # if(currentElement[0].isupper()):
    #     currentElement = command[i + 1]
    OP = setOpcode(currentElement)
    # print(OP, command)
    
    if(OP == "hasLabel"):
        if currentElement not in hm:
            hm.update({currentElement: currentAddress})
        i += 1
        currentElement = command[i]
        OP = setOpcode(currentElement)
    
    finalString += OP + "\n"
    if((currentElement == "j") | (currentElement == "ja") | (currentElement == "push") | (currentElement == "pop")):
        currentAddress += 3
        dest = command[i + 1]
        # TODO logic for named memory addresses
        
        if(dest in lables or dest == "END" or (dest[0] >= 'A' and dest[0] < 'Z')): #fill in label if present (this is for the jumps)
            print(dest in lables)
            print(dest, command)
            # dest = hex(lables.get(dest))[2:].zfill(4)
            # print(dest, command)
            1+1 # do SOMETHING in the if statement
        # elif(dest in names): #fill memory names
        #     dest = hex(names.get(dest))[2:].zfill(4)
        elif(dest not in set and dest[0] >= 'a' and dest[0] <= 'z' ):
            set.add(dest)
            dest = hex(makeNewAddress(dest))[2:].zfill(4)
        else:
            # print(dest, command)
            dest = hex(names.get(dest))[2:].zfill(4)

        if(currentElement == "j" and command[i + 1] == "END"):
            finalString += "ff\n" 
            currentAddress -= 1
        elif(currentElement == "j"):
            finalString += dest + "\n"
        else:
            finalString += dest[:2] + "\n" + dest[2:] + "\n"
    elif(currentElement == "pushra"):
        currentAddress += 1
        continue
    else:
        currentAddress += 5
        dest = command[i + 1]
        rs1 = command[i + 2]
        if(command[0] != "mov"):
            rs2 = command[i + 3]
        # TODO logic for named memory addresses
        if(dest in names): #fill memory names
            dest = hex(names.get(dest))[2:].zfill(4)
        elif(dest not in set and dest[0] >= 'a' and dest[0] <= 'z'):
            set.add(dest)
            dest = hex(makeNewAddress(dest))[2:].zfill(4)
        if(rs1 in names): #fill memory names
            rs1 = hex(names.get(rs1))[2:].zfill(4)
        elif(rs1 not in set and rs1[0] >= 'a' and rs1[0] <= 'z'):
            set.add(rs1)
            rs1 = hex(makeNewAddress(rs1))[2:].zfill(4)
        else:
            if(int(rs1) >= 0):
                rs1 = hex(int(rs1))[2:].zfill(4)
            else:
                print(rs1)
                rs1 = hex((int(rs1) + (1 << 16)) % (1 << 16))[2:].zfill(4)
                print(rs1)
        if(command[0] != "mov"):
            currentAddress += 2
            if(rs2 in names): #fill memory names
                rs2 = hex(names.get(rs2))[2:].zfill(4)
            elif(rs2 not in set and rs2[0] >= 'a' and rs2[0] <= 'z'):
                set.add(rs2)
                rs2 = hex(makeNewAddress(rs2))[2:].zfill(4)
            else:
                if(int(rs2) >= 0):
                    rs2 = hex(int(rs2))[2:].zfill(4)
                else:
                    rs2 = hex((int(rs2) + (1 << 16)) % (1 << 16))[2:].zfill(4)
        if(OP == "30" or OP == "3a" or OP == "39" or OP == "b0" or OP == "ba" or OP == "b9" or OP == "b4" or OP == "ba" or OP == "ac" or OP == "34"):
            finalString += rs1[:2] + "\n" + rs1[2:] + "\n" + rs2[:2] + "\n" + rs2[2:] + "\n" + dest + "\n"
        elif(command[0] != "mov"):
            finalString += rs1[:2] + "\n" + rs1[2:] + "\n" + rs2[:2] + "\n" + rs2[2:]   + "\n" + dest[:2] + "\n" + dest[2:] + "\n"
        else:
            finalString += rs1[:2] + "\n" + rs1[2:] + "\n" + dest[:2] + "\n" + dest[2:] + "\n"

f.close()
content = finalString.split()
output = open("output.txt", "w")
finalString = ''

for command in content:
    if(command[0] >= 'A' and command[0] <= 'Z'):
        res = hex(hm[command.strip()])[2:].zfill(4)
        finalString += res[:2] + "\n" + res[2:] + "\n"
    else:
        finalString += command + "\n"

output.write(finalString)

# f.close()
output.close()