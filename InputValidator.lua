local validator = {}

function validator.isValid(input)

  if #input <= 1 then
    return false;
  end

  local dotMatch = [[([%.]+)]];
  local numberMatch = [[(%d)]];

  local function isValidNumPairCount(numPairs)
    return numPairs % 2 == 0;
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
