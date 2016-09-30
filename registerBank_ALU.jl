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
    A::Array{Int8,1} # reg_bank A
    B::Array{Int8,1} # reg_bank B
    PC_stack::Array{Int16,1}
    active_bank::Char
    PC::Int16
    Cflag::Bool
    Zflag::Bool
    CPU(A::Array{Int8,1},B::Array{Int8,1}) = new(A,B,Array{Int}(0),'A',0,0,0)
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

machine = registerBank(zeros(16,8),zeros(16,8))
for i in 1:16
@assert (machine.A[i,1:end])== [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
end
#either take the value and
# implement load first.
#TODO: make sure we can just store values into registers.
#registerind
function Load_register_constant(registerindex,constant)#instruction file i/o,  which bank is selected
          #CONVERT INPUT INTO ARY.
          if alu_Register=='B'
              machine.B[registerindex] = constant
              println(machine.B[registerindex])
          end
          if alu_Register=='A'
              machine.A[registerindex] = constant
              println(machine.A[registerindex])
          end
  end

  function Load_register_register(register1Index, register2Index)
     if alu_Register=='B'
        machine.B[register1Index] = machine.B[register2Index]
      #  println(machine.B[registerindex])
    end
    if alu_Register=='A'
        machine.A[register1Index] = machine.A[register2Index]
    end
  end
 #peters code parses the code into integer index

Load_register_constant(2,86)
Load_register_register(1,6)
Load_register_constant(4,16)
Load_register_register(6,5)
Load_register_constant(9,13)

@assert machine.B[2] == 86
println(machine.B[2] == 86)
@assert machine.B[1] == machine.B[6]
println(machine.B[1] == machine.B[6])
@assert machine.B[4] == 16
@assert machine.B[6] == machine.B[5]
@assert machine.B[9] == 13
# cornercases if the number exceeeds the digits chopp?

function AND_Register_Register(register1Index,register2Index)
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
  function AND_Register_Constant(register1Index,constant)
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

println("and register", AND_Register_Constant(2,4545),machine.B[2])

println("and register", AND_Register_Constant(6,56),machine.B[6])
function OR_Register_Register(register1Index,register2Index)
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

println("or register",OR_Register_Register(2,3))
println("or register",OR_Register_Register(2,3))
println("or register",OR_Register_Register(2,3))
function OR_Register_Constant(register1Index,constant)
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

println("or register",OR_Register_Constant(2,56))
#println("or register constant",OR_Register_Constant(2,45))
#TODO : test XOR

function XOR_Register_Register(register1Index,register2Index)
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



Load_register_constant(1,7)
Load_register_constant(7,7)
Load_register_constant(5,7)
Load_register_register(4,7)

###

println("Xor register constant",XOR_Register_Register(2,16))

function XOR_Register_Constant(register1Index,constant)
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

a = ADD_register_constant(3,255)
println( "add register",machine.B[3], newflag.carry_flag,newflag.zero_flag)

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
  if alu_Register=='B'
      SUB_value = (Int(machine.B[register1Index]) -Int(constant))
      println("subvalue ",SUB_value)
      #print 255

      machine.B[register1Index] = SUB_value
      flagcheckSUB(SUB_value)
      end
      # return machine.A[register1Index]

  end

SUB_Register_Constant(8,9)
@assert machine.B[8] == -9
@assert newflag.carry_flag == true
@assert newflag.zero_flag == false

function SUBCY()
end
function TEST()
end
function TESTCY()
end

function COMPARE_Register_Constant(register1Index, constant)

  if alu_Register=='B'
      SUB_value = (Int(machine.B[register1Index]) -Int(constant))
      println("subvalue ",SUB_value)
      flagcheckSUB(SUB_value)
      end
      if alu_Register=='A'
          SUB_value = (Int(machine.A[register1Index]) -Int(constant))
          println("subvalue ",SUB_value)
          flagcheckSUB(SUB_value)
      end

end


function SL0(::CPU,registerindex)#SHIFT  REGISTA OR B
#shift the elements,
#using the shifting
#if the this results in overflow, push to the c flag.
#if bin of integer of first is one, c flag on,
# else just shift the flag.
if registerBank == 'A'
resultingshift = machine.A[registerindex]<<1
machine.A[registerindex] = resultingshift[2:end]
 newflag.carry_flag = resultingshift[0]
end

if registerBank == 'B'
resultingshift = machine.B[registerindex]<<1
machine.B[registerindex] = resultingshift[2:end]
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
