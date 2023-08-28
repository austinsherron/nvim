---@diagnostic disable: undefined-field

local Dict      = require 'toolbox.core.dict'
local KeyMapper = require 'utils.core.mapper'


-- TODO: finish this (and work on unit tests more generally)
describe('KeyMapper', function()
  describe('.new(options)', function()
    it('should add only default options to instance if options are provided', function()
      local KM = KeyMapper.new()

      assert.equals(#KM.options, 1)
      assert.equals(KM.options:pop(), KeyMapper.DEFAULT_OPTIONS)
    end)
    it('should add constructor options to instance if provided', function()
      local options = { nowait = true }
      local KM = KeyMapper.new(options)

      assert.equals(#KM.options, 2)
      assert.equals(KM.options:pop(), options)
      assert.equals(KM.options:pop(), KeyMapper.DEFAULT_OPTIONS)
    end)
  end)

  local options1 = { desc_prefix = 'some-plugin: ' }
  local options2 = { nowait = true }

  describe(':with(options)', function()
    it('should add new options to the instance', function()
      local KM = KeyMapper.new()
        :with(options1)
        :with(options2)

      assert.equals(#KM.options, 3)
      assert.equals(KM.options:pop(), options2)
      assert.equals(KM.options:pop(), options1)
      assert.equals(KM.options:pop(), KeyMapper.DEFAULT_OPTIONS)
    end)
  end)

  describe(':get_merged_options(options)', function()
    it('should merge instance options w/o options arg', function()
      local KM = KeyMapper.new()
        :with(options1)
        :with(options2)

      local expected = {
        desc_prefix = 'some-plugin: ',
        noremap     = true ,
        -- WARN: this effectively duplicates the local constant DEFAULT_OPTIONS
        nowait      = true,
      }
      assert.True(Dict.equals(KM:get_merged_options(), expected))
    end)
    it('should merge instance options w/ options arg', function()
      local KM = KeyMapper.new()
        :with(options1)
        :with(options2)

      local expected = {
        desc_prefix = 'some-plugin: ',
        noremap     = true ,
        -- WARN: this effectively duplicates the local constant DEFAULT_OPTIONS
        nowait      = true,
        silent      = true,
      }
      assert.True(Dict.equals(KM:get_merged_options({ silent = true }), expected))
    end)
    it('should keep values from more recently pushed options, if collisions occur', function()
      local KM = KeyMapper.new()
        :with(options1)
        :with(options2)
        :with({ nowait = false })

      local expected = {
        desc        = 'does something',
        desc_prefix = 'some-plugin: ',
        noremap     = true ,
        -- WARN: this effectively duplicates the local constant DEFAULT_OPTIONS
        nowait      = false,
        silent      = false,
      }

      local options = {
        desc   = 'does something',
        silent = false,
      }

      assert.True(Dict.equals(KM:get_merged_options(options), expected))
    end)
  end)

  describe(':get_options(options)', function()
    it('should create a full desc w/ desc_prefix and desc', function()
      local KM = KeyMapper.new()
        :with(options1)
        :with(options2)
        :with({ desc = 'does something' })

      local expected = {
        desc        = 'some-plugin: does something',
        noremap     = true ,
        -- WARN: this effectively duplicates the local constant DEFAULT_OPTIONS
        nowait      = true,
      }
      assert.True(Dict.equals(KM:get_options(), expected))
    end)
  end)
end)

