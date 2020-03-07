require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";
// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);


