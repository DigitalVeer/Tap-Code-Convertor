local validator = {}

--//Ensures we are working with proper input
--[[

CONDITIONS TO BE MET:

1.) The input length is more than 1 | "." or "1" would not be valid.
2.) Each dot has a pair. | ".." is not valid alone -> Should be ".. ..."
3.) Each number has a pair | "1" is not valid alone -> Should be "12"
4.) No letters to contaminate the string

]]--

function validator.isValid(input)

  if #input <= 1 then
    return false;
  end

  local dotMatch = [[([%.]+)]];
  local numberMatch = [[(%d)]];

  local function isValidNumPairCount(numPairs)
    return numPairs % 2 == 0; --//Make sure each number or dot has a pair to go with it
  end

  local function countMatches(match)
    local str = input;
    local result, count = str:gsub(match, "")
    return count;
  end

  local function containsNoLetters()
    return not input:find("%a")
  end

  local dotPairs = countMatches(dotMatch);
  local numPairs = countMatches(numberMatch);

  return isValidNumPairCount(dotPairs) and isValidNumPairCount(numPairs) and containsNoLetters();

end

--//Simplifies all numbers to their equivalent dot representation
--//Ex. "23" becomes " ..  ... "
function validator.simplify(input)

  local spaceFormat = [[ %s ]]

  local function getNumDots(num)
    return ("."):rep(tonumber(num))
  end

  local function numbersToDots(str)
    local result = str:gsub([[%d]],
    function(num)
      return spaceFormat:format(getNumDots(num))
    end)
    return result;
  end

  local simplifiedResult = numbersToDots(input);
  return simplifiedResult;
end

return validator;
