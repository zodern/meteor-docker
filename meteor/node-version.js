var fs = require('fs');
var path = require('path');

var starPath = path.resolve(process.cwd(), 'star.json');
var starJson;
var starVersion = null;
var textPath = path.resolve(process.cwd(), '.node_version.txt');
var textVersion = null;

var installedVersions = require('../setup/versions.json');
var wantExact = JSON.parse(process.env.EXACT_NODE_VERSION || 'false') || false
var nodeVersion;

try {
  starJson = require(starPath);
  if (starJson.nodeVersion) {
    starVersion = starJson.nodeVersion;
  }
} catch (e) {

}

try {
  textVersion = fs.readFileSync(textPath).toString('utf8').slice(1).trim();
} catch (e) {

}

nodeVersion = starVersion || textVersion;

if (!wantExact) {
  // Find a version already installed with the same major version
  var majorVersion = nodeVersion.split('.')[0];

  for (var i = 0; i < installedVersions.length; i++) {
    if (installedVersions[i].node.split('.')[0] === majorVersion) {
      nodeVersion = installedVersions[i].node;
      break;
    }
  }
}

console.log(nodeVersion);
