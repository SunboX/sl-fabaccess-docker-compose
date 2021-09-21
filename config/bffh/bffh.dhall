-- { actor_connections = [] : List { _1 : Text, _2 : Text }
{ actor_connections = 
  -- Link up machines to actors
  [ { _1 = "Testmachine", _2 = "Shelly_1234" }
  , { _1 = "Another", _2 = "Bash" }
  -- One machine can have as many actors as it wants
  , { _1 = "Yetmore", _2 = "Bash2" }
  , { _1 = "Yetmore", _2 = "FailBash"}
  ]
, actors = 
  { Shelly_1234 = { module = "Shelly", params = {=} }
  , Bash = { module = "Process", params =
    { cmd = "/usr/local/lib/bffh/adapters/actor.sh"
    , args = "your ad could be here"
    }}
  , Bash2 = { module = "Process", params =
    { cmd = "/usr/local/lib/bffh/adapters/actor.sh"
    , args = "this is a different one"
    }}
  , FailBash = { module = "Process", params =
    { cmd = "/usr/local/lib/bffh/adapters/fail-actor.sh" 
    }}
  }
  , init_connections = [] : List { _1 : Text, _2 : Text }
--, init_connections = [{ _1 = "Initiator", _2 = "Testmachine" }]
, initiators = {=}
  --{ Initiator = { module = "Dummy", params = {=} } }
, listens = 
  [ { address = "::", port = Some 59661 }
  ]
, machines = 
  { Testmachine = 
    { description = Some "A test machine"
    , disclose = "lab.test.read"
    , manage = "lab.test.admin"
    , name = "Testmachine"
    , read = "lab.test.read"
    , write = "lab.test.write" 
    },
    Another = 
    { description = Some "Another test machine"
    , disclose = "lab.test.read"
    , manage = "lab.test.admin"
    , name = "Another"
    , read = "lab.test.read"
    , write = "lab.test.write" 
    },
    Yetmore = 
    { description = Some "Yet more test machines"
    , disclose = "lab.test.read"
    , manage = "lab.test.admin"
    , name = "Yetmore"
    , read = "lab.test.read"
    , write = "lab.test.write" 
    }
  }
, mqtt_url = "tcp://mqtt:1883" 
, db_path = "/var/lib/bffh/"
, roles =
  { testrole = 
    { permissions = [ "lab.test.*" ] }
  , somerole = 
    { parents = ["testparent"]
    , permissions = [ "lab.some.admin" ]
    }
  , testparent = 
    { permissions = 
      [ "lab.some.write"
      , "lab.some.read"
      , "lab.some.disclose"
      ]
    }
  }
}
