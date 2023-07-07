return {
  -- required fields
  name = "some task",
  builder = function(_)
    -- this must return an overseer.taskdefinition
    return {
      -- cmd is the only required field
      cmd = { "echo" },
      -- additional arguments for the cmd
      args = { "hello", "world" },
      -- the name of the task (defaults to the cmd of the task)
      name = "greet",
      -- set the working directory for the task
      cwd = "/tmp",
      -- additional environment variables
      env = {
        var = "foo",
      },
      -- arbitrary table of data for your own personal use
      metadata = {
        foo = "bar",
      },
    }
  end,
  -- optional fields
  desc = "optional description of task",
  params = {
    -- see :help overseer-params
  },
  -- determines sort order when choosing tasks. lower comes first.
  priority = 50,
  -- add requirements for this template. if they are not met, the template will not be visible.
  -- all fields are optional.
  condition = {
    -- a string or list of strings
    -- only matches when current buffer is one of the listed filetypes
    -- filetype = {"c", "cpp"},
    -- a string or list of strings
    -- only matches when cwd is inside one of the listed dirs
    dir = "~/repos/*",
    -- arbitrary logic for determining if task is available
    callback = function(search)
      print(vim.inspect(search))
      return true
    end,
  },
}
