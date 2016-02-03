-- Function to test that all extensions load correctly
function testrequires()
  failed = {}
  for k,v in pairs(hs._extensions) do
    print(string.format("checking extension '%s'", k))
    res, ext = pcall(load(string.format("return hs.%s", k)))
    if res then
      if type(ext) ~= 'table' then
        failreason = string.format("type of 'hs.%s' is '%s', was expecting 'table'", k, type(ext))
        print(failreason)
        table.insert(failed, failreason)
      end
    else
      failreason = string.format("failed to load 'hs.%s', error was '%s'", k, ext)
      print(failreason)
      table.insert(failed, failreason)
    end
  end
  return table.concat(failed, " / ")
end

-- Utility functions
function failure(msg)
  error(string.format("Assertion failure: %s", msg))
end

function success()
  return "Success"
end

function errorMsgEquality(actual, expected)
  return string.format("expected: %s, actual: %s", expected, actual)
end

-- Assertions

-- Equality assertions
function assertIsEqual(a, b)
  if type(a) ~= type(b) then
    failure(errorMsgEquality(type(a), type(b)))
  end
  if a ~= b then
    failure(errorMsgEquality(a, b))
  end
end

-- Comparison assertions
function assertTrue(a)
  if not a then
    failure("expected: true, actual: "..a)
  end
end

function assertFalse(a)
  if a then
    failure("expected: false, actual: "..a)
  end
end

function assertIsNil(a)
  if a ~= nil then
    failure("expected: nil, actual: "..a)
  end
end

function assertIsNotNil(a)
  if a == nil then
    failure("expected: nil, actual: "..a)
  end
end

function assertGreaterThan(a, b)
  if a <= b then
    failure(string.format("expected: %s > %s", a, b))
  end
end

function assertLessThan(a, b)
  assertGreaterThan(b, a)
end

-- Type assertions
function assertIsType(a, aType)
  if type(a) ~= aType then
    failure(string.format("expected: %s, actual: %s", aType, type(a)))
  end
end

function assertIsNumber(a)
  assertIsType(a, "number")
end

function assertIsString(a)
  assertIsType(a, "string")
end

function assertIsTable(a)
  assertIsType(a, "table")
end

function assertIsFunction(a)
  assertIsType(a, "function")
end

function assertIsBoolean(a)
  assertIsType(a, "boolean")
end

function assertIsUserdata(a)
  assertIsType(a, "userdata")
end

function assertIsUserdataOfType(a, aType)
  assertIsType(a, "userdata")
  local meta = getmetatable(a)
  assertIsEqual(meta["__type"], aType)
end

-- Table assertions
function assertTableNotEmpty(a)
  assertGreaterThan(#a, 0)
end


-- Leave this at the end of the file
print ('testing init.lua loaded')