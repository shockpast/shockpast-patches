math.Clamp = function(number, min, max)
  return number < min and min or number > max and max or number
end

do
  local index, length = 1, 0

  do
    local keys = setmetatable({}, { __mode = "v" })
    table.Random = function(tbl, isSequential)
      if isSequential then
        length = #tbl

        if length == 0 then
          return nil, nil
        end

        if length == 1 then
          index = 1
        else
          index = math.random(1, length)
        end
      else
        length = 0

        for key in pairs(tbl) do
          length = length + 1
          keys[length] = key
        end

        if length == 0 then
          return nil, nil
        end

        if length == 1 then
          index = keys[1]
        else
          index = keys[math.random(1, length)]
        end
      end

      return tbl[index], index
    end
  end
end