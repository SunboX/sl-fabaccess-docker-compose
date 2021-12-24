{
  -- General Server Configuration
  listens = 
  [ 
    { address = "::", port = Some 59661 }
  ],
  mqtt_url = "tcp://mqtt:1883", 
  db_path = "/var/lib/bffh/db",

  -- Machines Configuration
  machines = 
  { 
    Testmachine = 
    { 
      name = "Testmachine",
      description = Some "A test machine",
      
      disclose = "lab.test.read",
      read = "lab.test.read",
      write = "lab.test.write",
      manage = "lab.test.admin"
    },
    Another = 
    { 
      name = "Another",
      description = Some "Another test machine",
      
      disclose = "lab.test.read",
      read = "lab.test.read",
      write = "lab.test.write",
      manage = "lab.test.admin"
    },
    Yetmore = 
    { 
      name = "Yetmore",
      description = Some "Yet more test machines",
      
      disclose = "lab.test.read",
      read = "lab.test.read",
      write = "lab.test.write",
      manage = "lab.test.admin"
    }
  },

  -- Actors Configuration
  actors = 
  { 
    Shelly_1234 = 
    { 
      module = "Shelly", 
      params = {=} 
    },
    Bash = 
    { 
      module = "Process", 
      params =
      { 
        cmd = "/usr/local/lib/bffh/adapters/actor.sh",
        args = "your ad could be here"
      }
    },
    Bash2 = 
    { 
      module = "Process", 
      params =
      { 
        cmd = "/usr/local/lib/bffh/adapters/actor.sh",
        args = "this is a different one"
      }
    }, 
    FailBash = 
    { 
      module = "Process", 
      params =
      { 
        cmd = "/usr/local/lib/bffh/adapters/fail-actor.sh" 
      }
    }
  }, 
  actor_connections = 
  [
    { machine = "Testmachine", actor = "Shelly_1234" },
    { machine = "Another", actor = "Bash" },
    { machine = "Yetmore", actor = "Bash2" },
    { machine = "Yetmore", actor = "FailBash"}
  ], 

  -- Initiator Configuration
  initiators = {=},
  init_connections = [] : List { machine : Text, initiator : Text }, 

  -- Roles
  roles =
  { 
    testrole = 
    { 
      permissions = [ "lab.test.*" ] 
    }, 
    somerole = 
    { 
      parents = ["testparent"],
      permissions = [ "lab.some.admin" ]
    }, 
    testparent = 
    { 
      permissions = 
      [ 
        "lab.some.write",
        "lab.some.read",
        "lab.some.disclose"
      ]
    }
  }
}
