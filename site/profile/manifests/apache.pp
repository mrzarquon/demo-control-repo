class profile::apache {

  # This is the apache php configuration generic for all systems
  include ::apache
  include ::apache::mod::php

}
