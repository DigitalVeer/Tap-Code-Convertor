
do
  local input, convertTap = "", require("TapCode");

  repeat
     io.write("Enter either tap-code, dots, or a combination: ");
     input = io.read();
     local result = convertTap(input);
     print(result, "\nContinue?[ No | Yes ]")
     input = io.read();
  until input:lower() == "no";

end
