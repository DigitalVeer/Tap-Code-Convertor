local validator = require("InputValidator")

function splitIntoPairs(str)

  local pairs = {};
  local pairsMatch = [[([%.]+)%s+([%.]+)]];

  for column, row in str:gmatch(pairsMatch) do
    local positionArray = {column, row}
    pairs[#pairs + 1] = positionArray;
  end

  return pairs;
end

function dotsToLetter(row, column)

  local function getPositionInAlphabet()
    return (#row - 1) * 5 + #column;
  end

  local startDecimal, cutoffDecimal = ("A"):byte() - 1, ("K"):byte();
  local letterDecimal = startDecimal + getPositionInAlphabet();

  if letterDecimal - startDecimal >= (cutoffDecimal - startDecimal) then
    letterDecimal = letterDecimal + 1;
  end

  return string.char(letterDecimal)

end

function convertTap(str)
  if validator.isValid(str) then
      local simplifiedString = validator.simplify(str);
      local strPairs = splitIntoPairs(simplifiedString);
      return recConvertTap(strPairs, 1, "");
  else
     error("Invalid Input")
  end
end

function recConvertTap(ar, index, str)
  if index > #ar then
    return str;
  end
  local positionArray = ar[index];
  local row, col = positionArray[1], positionArray[2];
  local finalLetter = dotsToLetter(row, col);
  str = str .. finalLetter;
  return recConvertTap(ar, index + 1, str)
end

return convertTap;
