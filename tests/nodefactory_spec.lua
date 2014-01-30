SILE = require("core/sile")
describe("The node factory", function()
  it("should exist", function()
    assert.is.truthy(SILE.nodefactory)
  end)
  describe("HBoxes", function()
    local hbox = SILE.nodefactory.newHbox({ width = 20, height = 30, depth = 3 })
    it("should have width", function () assert.is.equal(hbox.width,20) end)
    it("should have height", function () assert.is.equal(hbox.height,30) end)
    it("should have depth", function () assert.is.equal(hbox.depth,3) end)
    it("should have type", function () assert.is.equal(hbox.type,"hbox") end)
    it("should be a box (not glue)", function () assert.is.truthy(hbox:isBox()); assert.falsy(hbox:isGlue()) end)

    it("should stringify", function() assert.is.equal(tostring(hbox), "H<20>^30-3v") end)
  end)

  describe("NNodes", function ()
    local hbox1 = SILE.nodefactory.newHbox({ width = 10, height = 5, depth = 3 })
    local hbox2 = SILE.nodefactory.newHbox({ width = 20, height = 10, depth = 5 })

    local nnode = SILE.nodefactory.newNnode({ text = "test", nodes = {hbox1, hbox2} })
    it("should have width", function () assert.is.equal(nnode.width,30) end)
    it("should have depth", function () assert.is.equal(nnode.depth,5) end)
    it("should have height", function () assert.is.equal(nnode.height,10) end)
    it("should have type", function () assert.is.equal(nnode.type,"nnode") end)
    it("should have text", function () assert.is.equal(nnode:toText(), "test") end)
    it("should stringify", function() assert.is.equal(tostring(nnode), "N<30>^10-5v(test)") end)
  end)

  describe("Disc", function () 
    local nnode1 = SILE.nodefactory.newNnode({ width = 20, height = 30, depth = 3, text = "pre" })
    local nnode2 = SILE.nodefactory.newNnode({ width = 20, height = 30, depth = 3, text = "break" })
    local nnode3 = SILE.nodefactory.newNnode({ width = 20, height = 30, depth = 3, text = "post" })
    local disc   = SILE.nodefactory.newDisc({ prebreak = {nnode1, nnode2}, postbreak = {nnode3, nnode2 } })
    it("should stringify", function() assert.is.equal(tostring(disc), "D(N<20>^30-3v(pre)N<20>^30-3v(break)|N<20>^30-3v(post)N<20>^30-3v(break))") end)
  end)


  describe("Glue", function () 
    local glue = SILE.nodefactory.newGlue({ width = SILE.length.new({ length = 3, stretch = 2, shrink = 2 }) })
    it("should stringify", function() assert.is.equal(tostring(glue), "G<3 plus 2 minus 2>") end)
  end)
  describe("vbox", function () 
    local nnode1 = SILE.nodefactory.newNnode({ width = 20, height = 30, depth = 3, text = "one" })
    local glue = SILE.nodefactory.newGlue({ width = SILE.length.new ({ length = 3, stretch = 2, shrink = 2}) })
    local nnode2 = SILE.nodefactory.newNnode({ width = 20, height = 30, depth = 7, text = "two" })
    local nnode3 = SILE.nodefactory.newNnode({ width = 20, height = 30, depth = 2, text = "three" })
    local vbox   = SILE.nodefactory.newVbox({ nodes = {nnode1, glue, nnode2, glue, nnode3 } })
    it("should go to text", function() assert.is.equal(vbox:toText(), "VB[one two three]") end)
    it("should have depth", function() assert.is.equal(vbox.depth, 7) end)
  end)
  
end)
