# use test data

# test input to make sure it works properly
# add expect to add 2 items
# or ect..
#task 1 impelement register bank
#task2 create a set of functions to perform the operations
#test each one # add assertions ect..
#know what goes inside the registerbanks.
#implement a switch that works only when one register
#is on or off.

#todo how to switch




type CPU
    A::Array{Int16,1} # reg_bank A
    B::Array{Int16,1} # reg_bank B
    PC_stack::Array{Int16,1}
    active_bank::Char
    PC::Int16
    Cflag::Bool
    Zflag::Bool
    CPU(A::Array{Int16,1},B::Array{Int16,1}) = new(A,B,Array{Int}(0),'A',0,0,0)
end





machine = CPU(zeros(Int16,16), zeros(Int16,16))

alu_Register = 'B'
type registerBank
    A
    B
end

type flagCZ
  carry_flag::Bool
  zero_flag::Bool
end
#TODO change this to same name as peter.
newflag = flagCZ(false,false)

println("the flags are", newflag.carry_flag, newflag.zero_flag)

#note these are undeclared can be anything:: may want to make sure they are
# for sure arrays.

#machine = registerBank(zeros(16,8),zeros(16,8))

#either take the value and
# implement load first.
#TODO: make sure we can just store values into registers.
#registerind
function Load_register_constant(machine::CPU,registerindex,constant)#instruction file i/o,  which bank is selected
          #CONVERT INPUT INTO ARY.
          if alu_Register=='B'
              machine.B[registerindex] = constant
              #println(machine.B[registerindex])
          end
          if alu_Register=='A'
              machine.A[registerindex] = constant
              println(machine.A[registerindex])
          end
  end

  function Load_register_register(machine::CPU,register1Index, register2Index)
     if alu_Register=='B'
        machine.B[register1Index] = machine.B[register2Index]
      #  println(machine.B[registerindex])
    end
    if alu_Register=='A'
        machine.A[register1Index] = machine.A[register2Index]
    end
  end
 #peters code parses the code into integer index

Load_register_constant(machine,2,86)
Load_register_register(machine,1,6)
Load_register_constant(machine,4,16)
Load_register_register(machine,6,5)
Load_register_constant(machine,9,13)

@assert machine.B[2] == 86
println(machine.B[2] == 86)
@assert machine.B[1] == machine.B[6]
println(machine.B[1] == machine.B[6])
@assert machine.B[4] == 16
@assert machine.B[6] == machine.B[5]
@assert machine.B[9] == 13
# cornercases if the number exceeeds the digits chopp?

function AND_Register_Register(machine::CPU,register1Index,register2Index)
          if alu_Register=='B'
              #note new julia allows & allows simbol.
              machine.B[register1Index] =  (Int(machine.B[register1Index]) & Int(machine.B[register2Index]))
              println(machine.B[register1Index])
          end
          if alu_Register=='A'
              machine.A[register1Index]= (Int(machine.A[register1Index]) & Int(machine.A[register2Index]))
              println(machine.A[register1Index])
            end

  end
  function AND_Register_Constant(machine::CPU,register1Index,constant)
  if alu_Register=='B'
      #note new julia allows & allows simbol.
      resulting_And= (Int(machine.B[register1Index]) & Int(constant))
      machine.B[register1Index] = resulting_And
      println(resulting_And)
      return machine.B[register1Index]
  end

  if alu_Register=='A'
       resulting_And= (Int(machine.A[register1Index]) & Int(constant))
       machine.A[register1Index] = resulting_And
       println(resulting_And)
       return machine.A[register1Index]
    end

end

println("and register", AND_Register_Constant(machine,2,4545),machine.B[2])

println("and register", AND_Register_Constant(machine,6,56),machine.B[6])
function OR_Register_Register(machine::CPU,register1Index,register2Index)
  if alu_Register=='B'

      resulting_Or = (Int(machine.B[register1Index]) | Int(machine.B[register2Index]))
      println("resulting or", resulting_Or)
      machine.B[register1Index] = resulting_Or

      return machine.B[register1Index]
  end
  if alu_Register=='A'
      resulting_Or= (Int(machine.A[register1Index]) | Int(machine.A[register2Index]))
      println(resulting_Or)
      machine.A[register1Index] = resulting_Or
      return machine.A[register1Index]
    end

end

println("or register",OR_Register_Register(machine,2,3))
println("or register",OR_Register_Register(machine,2,3))
println("or register",OR_Register_Register(machine,2,3))
function OR_Register_Constant(machine::CPU,register1Index,constant)
  if alu_Register=='B'

      resulting_Or = (Int(machine.B[register1Index]) | Int(constant))
      println(resulting_Or)
      machine.B[register1Index] = resulting_Or
      return machine.B[register1Index]
  end
  if alu_Register=='A'
      resulting_Or= (Int(machine.A[register1Index]) | Int(constant))
      println(resulting_Or)
      machine.A[register1Index] = resulting_Or
      return machine.A[register1Index]
    end

end

println("or register",OR_Register_Constant(machine,2,56))
#println("or register constant",OR_Register_Constant(2,45))
#TODO : test XOR

function XOR_Register_Register(machine::CPU,register1Index,register2Index)
  if alu_Register=='B'

      resulting_XOr = (Int(machine.B[register1Index]) $ Int(machine.B[register2Index]))

  end
  if alu_Register=='A'
      resulting_XOr= (Int(machine.A[register1Index]) $ Int(machine.A[register2Index]))

    end
return resulting_XOr
end
################################################################
#test cases for xor



Load_register_constant(machine,1,7)
Load_register_constant(machine,7,7)
Load_register_constant(machine,5,7)
Load_register_register(machine,4,7)

###

println("Xor register constant",XOR_Register_Register(machine,2,16))

function XOR_Register_Constant(machine::CPU,register1Index,constant)
  if alu_Register=='B'

      resulting_XOr = (Int(machine.B[register1Index]) $ Int(constant))
      println(resulting_XOr)
  end
  if alu_Register=='A'
      resulting_Or= (Int(machine.A[register1Index]) $ Int(constant))
      println(resulting_XOr)
    end
return resulting_XOr
end
#note the results are strings.
resulting_xor = XOR_Register_Register(machine,1,7)
@assert (resulting_xor==0)
@assert XOR_Register_Register(machine,7,7)==0
@assert XOR_Register_Register(machine,5,7) == 0
@assert XOR_Register_Register(machine,4,7) == 0
#################################################################
println("Xor register constant",XOR_Register_Constant(machine,2,45))
@assert XOR_Register_Constant(machine,7,7)==0
@assert XOR_Register_Constant(machine,5,7) == 0
@assert XOR_Register_Constant(machine,4,7) == 0


resulting_ADD= Int,XOR_Register_Register(machine,1,7)
@assert (resulting_xor==0)
@assert XOR_Register_Register(machine,7,7)==0
@assert XOR_Register_Register(machine,5,7) == 0
@assert XOR_Register_Register(machine,4,7) == 0
#################################################################
println("Xor register constant",XOR_Register_Constant(machine,2,45))
@assert XOR_Register_Constant(machine,7,7)==0
@assert XOR_Register_Constant(machine,5,7) == 0
@assert XOR_Register_Constant(machine,4,7) == 0

function flagcheckADD(result)
  if result==0
     newflag.zero_flag = true
  elseif result != 0
     newflag.zero_flag = false
  end
  if  result>255

     newflag.carry_flag = true
  else
    newflag.carry_flag = false
  end
end

function ADD_register_constant(machine::CPU,register1Index,constant)
  if alu_Register=='B'
      resulting_ADD = (Int(machine.B[register1Index]) + Int(constant))
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.B[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.B[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
  if alu_Register=='A'
      resulting_ADD = (Int(machine.A[register1Index]) + Int(constant))
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.A[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.A[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
end
function ADD_register_register(machine::CPU,register1Index,register2Index)
  if alu_Register=='B'
      resulting_ADD = (Int(machine.B[register1Index]) + Int(machine.B[register2Index]))
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.B[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.B[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
  if alu_Register=='A'
      resulting_ADD = (Int(machine.A[register1Index]) + Int(machine.B[register2Index]))
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.A[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.A[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
end

a = ADD_register_constant(machine,3,255)
println( "add register",machine.B[3], newflag.carry_flag,newflag.zero_flag)
Load_register_constant(machine,13,9)
b = ADD_register_register(machine,4,13)
println( "add register",machine.B[4], newflag.carry_flag,newflag.zero_flag)

#TODO: load all the register with the resulting values.

#TODO: to the resulting ADDCY ?

function ADDCY_register_constant(machine::CPU,register1Index,constant)
  if alu_Register=='B'
      resulting_ADD = (Int(machine.B[register1Index]) + Int(constant))+machine.carry_flag
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.B[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.B[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
  if alu_Register=='A'
      resulting_ADD = (Int(machine.A[register1Index]) + Int(constant))+ machine.carry_flag
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.A[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.A[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
end
function ADDCY_register_register(machine::CPU,register1Index,register2Index)
  if alu_Register=='B'
      resulting_ADD = Int(machine.B[register1Index]) + Int(machine.B[register2Index])+machine.carry_flag
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.B[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.B[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
  if alu_Register=='A'
      resulting_ADD = Int(machine.A[register1Index]) + Int(machine.B[register2Index])+ machine.carry_flag
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      machine.A[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       machine.A[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return machine.A[register1Index]
  end
end

function SUBCY()
end


function flagcheckSUB(machine::CPU,result)
   result==0?
     machine.Zflag = true:
     machine.Zflag = false
    result<0?
    machine.Cflag = true:
    machine.Cflag = false

end
function SUB_Register_Constant(machine::CPU,register1Index,constant)
    alu_Register=='B'?
      machine.B[register1Index] = (Int(machine.B[register1Index]) -Int(constant)):
      machine.A[register1Index] = Int(machine.A[register1Index]) -Int(constant)
      #print 255
      alu_Register=='B'?
      flagcheckSUB(machine,machine.B[register1Index]):
       flagcheckSUB(machine,machine.A[register1Index])


      end

      function SUB_Register_Register(machine::CPU,register1Index,register2Index)
          alu_Register=='B'?
            machine.B[register1Index] = (Int(machine.B[register1Index]) -Int(machine.B[register2Index])):
            machine.A[register1Index] = Int(machine.A[register1Index]) -Int(machine.B[register2Index])
            #print 255
            alu_Register=='B'?
            flagcheckSUB(machine,machine.B[register1Index]):
             flagcheckSUB(machine,machine.A[register1Index])
            end

            function SUBCY_Register_Constant(machine::CPU,register1Index,constant)
                alu_Register=='B'?
                  machine.B[register1Index] = (Int(machine.B[register1Index]) -Int(constant))-machine.carry_flag:
                  machine.A[register1Index] = Int(machine.A[register1Index]) -Int(constant)-machine.carry_flag
                  #print 255
                  alu_Register=='B'?
                  flagcheckSUB(machine,machine.B[register1Index]):
                   flagcheckSUB(machine,machine.A[register1Index])


                  end

                  function SUBCY_Register_register(machine::CPU,register1Index,register2Index)
                      alu_Register=='B'?
                        machine.B[register1Index] = (Int(machine.B[register1Index]) -Int(machine.B[register2Index]))-machine.carry_flag:
                        machine.A[register1Index] = Int(machine.A[register1Index]) -Int(machine.A[register2Index])-machine.carry_flag
                        #print 255
                        alu_Register=='B'?
                        flagcheckSUB(machine,machine.B[register1Index]):
                         flagcheckSUB(machine,machine.A[register1Index])


                        end
      # return machine.A[register1Index]



SUB_Register_Constant(machine,8,9)
@assert machine.B[8] == -9
@assert machine.Cflag == true
@assert machine.Zflag == false

Load_register_constant(machine,8,0)
Load_register_constant(machine,9,9)
SUB_Register_Register(machine,8,9)
@assert machine.B[8] == -9
@assert machine.Cflag == true
@assert machine.Zflag == false

# flagcheckSUB(machine,3)
# @assert machine.Cflag == true
function COMPARE_Register_Constant(machine::CPU,register1Index, constant)

  if alu_Register=='B'
      SUB_value = (Int(machine.B[register1Index]) -Int(constant))
      println("subvalue ",SUB_value)
      flagcheckSUB(machine,SUB_value)
      end
      if alu_Register=='A'
          SUB_value = (Int(machine.A[register1Index]) -Int(constant))
          println("subvalue ",SUB_value)
          flagcheckSUB(machine,SUB_value)
      end

end
function COMPARE_Register_Register(machine::CPU,register1Index, register2Index)

      alu_Register=='B'?
      machine.B[register1Index] = (Int(machine.B[register1Index]) -Int(machine.B[register2Index])):
      machine.A[register1Index]=Int(machine.A[register1Index]) -Int(machine.B[register2Index])

      alu_Register=='B'?
      flagcheckSUB(machine,machine.B[register1Index]):
      flagcheckSUB(machine,machine.A[register1Index])

      alu_Register=='B'?
      println("subvalue ",machine.B[register1Index]):
      println("subvalue ",machine.A[register1Index])

end
Load_register_constant(machine,1,0)
COMPARE_Register_Constant(machine,1,0)
@assert machine.Cflag == false
@assert machine.Zflag == true

function SLZERO(registerindex)#SHIFT  REGISTA OR B
#shift the elements,
#using the shifting
#if the this results in overflow, push to the c flag.
#if bin of integer of first is one, c flag on,
# else just shift the flag.
if alu_Register == 'B'
  machine.B[registerindex]>255?
  machine.B[registerindex] = 255:
  print("")
  println("before shift ",bin(machine.B[registerindex]))
  ((machine.B[registerindex]<<1))>255? machine.Cflag = 1 : machine.Cflag = 0

  resultingshift = bin(machine.B[registerindex]<<1)
  parse(Int,resultingshift) ==0?
  machine.Zflag = true:
  machine.Zflag = false

 println("resulting shif is", resultingshift)
 if machine.B[registerindex]>127
 parse(Int,resultingshift[2:end])!=0?
 machine.B[registerindex] = parse(Int,resultingshift[2:end],2):
 machine.B[registerindex] = 0
 elseif machine.B[registerindex]<128
     machine.B[registerindex] =  machine.B[registerindex]<<1

 end
 println(machine.Cflag,machine.Zflag)
 println(machine.B[registerindex])
return machine.B[registerindex]
end
if alu_Register == 'A'
  machine.A[registerindex]>255?
  machine.A[registerindex] = 255:
  print("")
  println("before shift ",bin(machine.A[registerindex]))
  machine.A[registerindex] % 2 != 0 ? machine.Cflag = 1 : machine.Cflag = 0

  resultingshift = bin(machine.A[registerindex]<<1)
  parse(Int,resultingshift) ==0?
  machine.Zflag = true:
  machine.Zflag = false

 println("resulting shif is", resultingshift)
 if machine.A[registerindex]>127
 parse(Int,resultingshift[2:end])!=0?
 machine.A[registerindex] = parse(Int,resultingshift[2:end],2):
 machine.A[registerindex] = 0
 elseif machine.A[registerindex]<128
     machine.A[registerindex] =  machine.A[registerindex]<<1

 end
 println(bin(machine.B[registerindex]))

return machine.B[registerindex]
end
end

Load_register_constant(machine,3,0)
SLZERO(3)
Load_register_constant(machine,3,5)
SLZERO(3)
Load_register_constant(machine,3,127)
SLZERO(3)
Load_register_constant(machine,3,255)
SLZERO(3)
function SL1(registerindex)
  if alu_Register == 'B'
    machine.B[registerindex]>255?
    machine.B[registerindex] = 255:
    print("")
    println("before shift ",bin(machine.B[registerindex]))
    ((machine.B[registerindex]<<1)+1)>255? machine.Cflag = 1 : machine.Cflag = 0

    resultingshift = bin((machine.B[registerindex]<<1)+1)
    parse(Int,resultingshift) ==0?
    machine.Zflag = true:
    machine.Zflag = false

   println("resulting shift is", resultingshift)
   if machine.B[registerindex]>127
   parse(Int,resultingshift[2:end])!=0?
   machine.B[registerindex] = parse(Int,resultingshift[2:end],2):
   machine.B[registerindex] = 0
   elseif machine.B[registerindex]<128
       machine.B[registerindex] = (machine.B[registerindex]<<1)+1

   end
   println(bin(machine.B[registerindex]))
   println(machine.Cflag,machine.Zflag)
  return machine.B[registerindex]
  end
end



Load_register_constant(machine,3,5)
SL1(3)
Load_register_constant(machine,3,127)
SL1(3)
Load_register_constant(machine,3,255)
SL1(3)

function SLA(registerindex)
  if alu_Register == 'B'
    machine.B[registerindex]>255?
    machine.B[registerindex] = 255:
    print("")
    println("before shift ",bin(machine.B[registerindex]))
    Carry = machine.Cflag
    ((machine.B[registerindex]<<1)+machine.Cflag)>255? machine.Cflag = 1 : machine.Cflag = 0

    resultingshift = bin((machine.B[registerindex]<<1)+Carry)
    parse(Int,resultingshift) ==0?
    machine.Zflag = true:
    machine.Zflag = false

   println("resulting shift is", resultingshift)
   if machine.B[registerindex]>127
   parse(Int,resultingshift[2:end])!=0?
   machine.B[registerindex] = parse(Int,resultingshift[2:end],2):
   machine.B[registerindex] = 0
   elseif machine.B[registerindex]<128
       machine.B[registerindex] = (machine.B[registerindex]<<1)+Carry

   end
   println(bin(machine.B[registerindex]))
   println(machine.Cflag,machine.Zflag)
  return machine.B[registerindex]
  end
end


function SLX(registerindex)
  if alu_Register == 'B'
    machine.B[registerindex]>255?
    machine.B[registerindex] = 255:
    print("")
    println("before shift ",bin(machine.B[registerindex]))
    Carry = machine.Cflag
    ((machine.B[registerindex]<<1)+machine.B[registerindex]%2)>255? machine.Cflag = 1 : machine.Cflag = 0

    resultingshift = bin((machine.B[registerindex]<<1)+machine.B[registerindex]%2)
    parse(Int,resultingshift) ==0?
    machine.Zflag = true:
    machine.Zflag = false

   println("resulting shift is", resultingshift)
   if machine.B[registerindex]>127
   parse(Int,resultingshift[2:end])!=0?
   machine.B[registerindex] = parse(Int,resultingshift[2:end],2):
   machine.B[registerindex] = 0

   elseif machine.B[registerindex]<128
       machine.B[registerindex] = (machine.B[registerindex]<<1)+machine.B[registerindex]%2

   end
   println(bin(machine.B[registerindex]))
   println(machine.Cflag,machine.Zflag)
  return machine.B[registerindex]
  end
end

Load_register_constant(machine,3,5)
SLX(3)
Load_register_constant(machine,3,127)
SLX(3)
Load_register_constant(machine,3,128)
SLX(3)
Load_register_constant(machine,3,255)
SLX(3)
Load_register_constant(machine,3,344)
SLX(3)



function SR()#SHIFT REGISTERS RIGHT OR LEFT


end

function RL()
end

function RR()
end
