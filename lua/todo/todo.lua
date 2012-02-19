#!/usr/bin/lua
tasks={}
y=" \27[32m✔\27[0m "
n=" \27[31m✗\27[0m "

function read()
   for line in io.lines( 'task' ) do
      table.insert( tasks, line )
   end
end

function save()
   local file = io.open ( 'task', 'w' )
   for i,v in pairs( tasks ) do
      file:write( v .. "\n")
   end
end

function print_t( opt )
   for i,v in pairs( tasks ) do
      local d = v:sub( 1, 1 )
      if d == "+" then 
	 if opt == "--all" then print( y .. v:sub(2) )  end
      else print( n .. v:sub( 2 ) ) end
   end
end

function toggle( n )
   if tasks[ n ]:sub( 1, 1 ) == "-" then 
      a, b = "-", "+"
   else 
      a, b = "+", "-" 
   end
   tasks[n] = tasks[n]:gsub(a, b, 1)
end

o = arg[1]
read()
if     o == "ls" then print_t( arg[2] )
elseif o == "rm" then table.remove( tasks, n )
elseif o == "check" or o == "undo" then toggle( tonumber( arg[2] ) )
elseif o == "clear" then tasks = {}
else   table.insert( tasks, "-" .. o )
end
save()
