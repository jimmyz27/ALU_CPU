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


module KCPSM6

type CPU
    A::Array{Int8,1} # reg_bank A
    B::Array{Int8,1} # reg_bank B
    PC_stack::Array{Int16,1}
    active_bank::Char
    PC::Int16
    Cflag::Bool
    Zflag::Bool
    CPU(A::Array{Int8,1},B::Array{Int8,1}) = new(A,B,Array{Int}(0),'A',0,0,0)
end
end
#newMachine = CPU(zeros(16),zeros(16))

alu_Register = "B"
type registerBank
    bankA
    bankB
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

newregisterbank = registerBank(zeros(16,8),zeros(16,8))
for i in 1:16
@assert (newregisterbank.bankA[i,1:end])== [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
end
#either take the value and
# implement load first.
#TODO: make sure we can just store values into registers.
#registerind
function Load_register_constant(registerindex,constant)#instruction file i/o,  which bank is selected
          #CONVERT INPUT INTO ARY.
          if alu_Register=="B"
              newregisterbank.bankB[registerindex] = constant
              println(newregisterbank.bankB[registerindex])
          end
          if alu_Register=="A"
              newregisterbank.bankA[registerindex] = constant
              println(newregisterbank.bankA[registerindex])
          end
  end

  function Load_register_register(register1Index, register2Index)
     if alu_Register=="B"
        newregisterbank.bankB[register1Index] = newregisterbank.bankB[register2Index]
      #  println(newregisterbank.bankB[registerindex])
    end
    if alu_Register=="A"
        newregisterbank.bankA[register1Index] = newregisterbank.bankA[register2Index]
    end
  end
 #peters code parses the code into integer index

Load_register_constant(2,86)
Load_register_register(1,6)
Load_register_constant(4,16)
Load_register_register(6,5)
Load_register_constant(9,13)

@assert newregisterbank.bankB[2] == 86
println(newregisterbank.bankB[2] == 86)
@assert newregisterbank.bankB[1] == newregisterbank.bankB[6]
println(newregisterbank.bankB[1] == newregisterbank.bankB[6])
@assert newregisterbank.bankB[4] == 16
@assert newregisterbank.bankB[6] == newregisterbank.bankB[5]
@assert newregisterbank.bankB[9] == 13
# cornercases if the number exceeeds the digits chopp?

function AND_Register_Register(register1Index,register2Index)
          if alu_Register=="B"
              #note new julia allows & allows simbol.
              newregisterbank.bankB[register1Index] =  (Int(newregisterbank.bankB[register1Index]) & Int(newregisterbank.bankB[register2Index]))
              println(newregisterbank.bankB[register1Index])
          end
          if alu_Register=="A"
              newregisterbank.bankA[register1Index]= (Int(newregisterbank.bankA[register1Index]) & Int(newregisterbank.bankA[register2Index]))
              println(newregisterbank.bankA[register1Index])
            end

  end
  function AND_Register_Constant(register1Index,constant)
  if alu_Register=="B"
      #note new julia allows & allows simbol.
      resulting_And= (Int(newregisterbank.bankB[register1Index]) & Int(constant))
      newregisterbank.bankB[register1Index] = resulting_And
      println(resulting_And)
      return newregisterbank.bankB[register1Index]
  end

  if alu_Register=="A"
       resulting_And= (Int(newregisterbank.bankA[register1Index]) & Int(constant))
       newregisterbank.bankA[register1Index] = resulting_And
       println(resulting_And)
       return newregisterbank.bankA[register1Index]
    end

end

println("and register", AND_Register_Constant(2,4545),newregisterbank.bankB[2])

println("and register", AND_Register_Constant(6,56),newregisterbank.bankB[6])
function OR_Register_Register(register1Index,register2Index)
  if alu_Register=="B"

      resulting_Or = (Int(newregisterbank.bankB[register1Index]) | Int(newregisterbank.bankB[register2Index]))
      println("resulting or", resulting_Or)
      newregisterbank.bankB[register1Index] = resulting_Or

      return newregisterbank.bankB[register1Index]
  end
  if alu_Register=="A"
      resulting_Or= (Int(newregisterbank.bankA[register1Index]) | Int(newregisterbank.bankA[register2Index]))
      println(resulting_Or)
      newregisterbank.bankA[register1Index] = resulting_Or
      return newregisterbank.bankA[register1Index]
    end

end

println("or register",OR_Register_Register(2,3))
println("or register",OR_Register_Register(2,3))
println("or register",OR_Register_Register(2,3))
function OR_Register_Constant(register1Index,constant)
  if alu_Register=="B"

      resulting_Or = (Int(newregisterbank.bankB[register1Index]) | Int(constant))
      println(resulting_Or)
      newregisterbank.bankB[register1Index] = resulting_Or
      return newregisterbank.bankB[register1Index]
  end
  if alu_Register=="A"
      resulting_Or= (Int(newregisterbank.bankA[register1Index]) | Int(constant))
      println(resulting_Or)
      newregisterbank.bankA[register1Index] = resulting_Or
      return newregisterbank.bankA[register1Index]
    end

end

println("or register",OR_Register_Constant(2,56))
#println("or register constant",OR_Register_Constant(2,45))
#TODO : test XOR

function XOR_Register_Register(register1Index,register2Index)
  if alu_Register=="B"

      resulting_XOr = (Int(newregisterbank.bankB[register1Index]) $ Int(newregisterbank.bankB[register2Index]))

  end
  if alu_Register=="A"
      resulting_XOr= (Int(newregisterbank.bankA[register1Index]) $ Int(newregisterbank.bankA[register2Index]))

    end
return resulting_XOr
end
################################################################
#test cases for xor



Load_register_constant(1,7)
Load_register_constant(7,7)
Load_register_constant(5,7)
Load_register_register(4,7)

###

println("Xor register constant",XOR_Register_Register(2,16))

function XOR_Register_Constant(register1Index,constant)
  if alu_Register=="B"

      resulting_XOr = (Int(newregisterbank.bankB[register1Index]) $ Int(constant))
      println(resulting_XOr)
  end
  if alu_Register=="A"
      resulting_Or= (Int(newregisterbank.bankA[register1Index]) $ Int(constant))
      println(resulting_XOr)
    end
return resulting_XOr
end
#note the results are strings.
resulting_xor = XOR_Register_Register(1,7)
@assert (resulting_xor==0)
@assert XOR_Register_Register(7,7)==0
@assert XOR_Register_Register(5,7) == 0
@assert XOR_Register_Register(4,7) == 0
#################################################################
println("Xor register constant",XOR_Register_Constant(2,45))
@assert XOR_Register_Constant(7,7)==0
@assert XOR_Register_Constant(5,7) == 0
@assert XOR_Register_Constant(4,7) == 0


resulting_ADD= Int,XOR_Register_Register(1,7)
@assert (resulting_xor==0)
@assert XOR_Register_Register(7,7)==0
@assert XOR_Register_Register(5,7) == 0
@assert XOR_Register_Register(4,7) == 0
#################################################################
println("Xor register constant",XOR_Register_Constant(2,45))
@assert XOR_Register_Constant(7,7)==0
@assert XOR_Register_Constant(5,7) == 0
@assert XOR_Register_Constant(4,7) == 0

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

function ADD_register_constant(register1Index,constant)
  if alu_Register=="B"
      resulting_ADD = (Int(newregisterbank.bankB[register1Index]) + Int(constant))
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      newregisterbank.bankB[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       newregisterbank.bankB[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return newregisterbank.bankA[register1Index]
  end
  if alu_Register=="A"
      resulting_ADD = (Int(newregisterbank.bankA[register1Index]) + Int(constant))
      println(resulting_ADD)
      #print 255
      if resulting_ADD<=255
      newregisterbank.bankA[register1Index] = resulting_ADD
      flagcheckADD(resulting_ADD)
      end

       if resulting_ADD>255
       newregisterbank.bankA[register1Index] = 255
        flagcheckADD(resulting_ADD)
     end
      # return newregisterbank.bankA[register1Index]
  end
end

a = ADD_register_constant(3,255)
println( "add register",newregisterbank.bankB[3], newflag.carry_flag,newflag.zero_flag)

#TODO: load all the register with the resulting values.

#TODO: to the resulting ADDCY ?

function flagcheckSUB(result)
  if result==0
     newflag.zero_flag = true
  elseif result != 0
     newflag.zero_flag = false
  end
  if  result<0

     newflag.carry_flag = true
  else
    newflag.carry_flag = false
  end
end


function SUB_Register_Constant(register1Index,constant)
  if alu_Register=="B"
      SUB_value = (Int(newregisterbank.bankB[register1Index]) -Int(constant))
      println("subvalue ",SUB_value)
      #print 255

      newregisterbank.bankB[register1Index] = SUB_value
      flagcheckSUB(SUB_value)
      end
      # return newregisterbank.bankA[register1Index]

  end

SUB_Register_Constant(8,9)
@assert newregisterbank.bankB[8] == -9
@assert newflag.carry_flag == true
@assert newflag.zero_flag == false

function SUBCY()
end
function TEST()
end
function TESTCY()
end

function COMPARE_Register_Constant(register1Index, constant)

  if alu_Register=="B"
      SUB_value = (Int(newregisterbank.bankB[register1Index]) -Int(constant))
      println("subvalue ",SUB_value)
      flagcheckSUB(SUB_value)
      end
      if alu_Register=="A"
          SUB_value = (Int(newregisterbank.bankA[register1Index]) -Int(constant))
          println("subvalue ",SUB_value)
          flagcheckSUB(SUB_value)
      end

end


function SL0(registerindex)#SHIFT  REGISTA OR B
#shift the elements,
#using the shifting
#if the this results in overflow, push to the c flag.
#if bin of integer of first is one, c flag on,
# else just shift the flag.
if registerBank == "A"
resultingshift = newregisterbank.bankA[registerindex]<<1
newregisterbank.bankA[registerindex] = resultingshift[2:end]
 newflag.carry_flag = resultingshift[0]
end

if registerBank == "B"
resultingshift = newregisterbank.bankB[registerindex]<<1
newregisterbank.bankB[registerindex] = resultingshift[2:end]
 newflag.carry_flag = resultingshift[0]
end

end

Load_register_constant(1,7)
a = SL0(1)
println("theresgister1shifted",a,"carry_flag",newflag.carry_flag)
function SR()#SHIFT REGISTERS RIGHT OR LEFT

end

function RL()
end

function RR()
end
