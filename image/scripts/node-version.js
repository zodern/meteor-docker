var fs = require('fs');
var path = require('path');

var logsEnabled = process.env.DEBUG_NODE_VERSION === '0';

var logStream;
if (logsEnabled) {
  logStream = fs.createWriteStream('/home/app/scripts/log.txt', {'flags': 'w'});
}

function log(text) {
  if(logsEnabled) {
    logStream.write(text + '\n');
  }
}

function logFinish(text) {
  if (logsEnabled) {
    logStream.end(text + '\n');
  }
}

log('starting');

var starPath = path.resolve(process.cwd(), 'star.json');
var starJson;
var starVersion = null;
var textPath = path.resolve(process.cwd(), '.node_version.txt');
var textVersion = null;

var installedVersions = require('../setup/versions.json');
var wantExact = JSON.parse(process.env.EXACT_NODE_VERSION || 'false');
var nodeVersion;

log('wantExact: ' + wantExact);

try {
  starJson = require(starPath);
  if (starJson.nodeVersion) {
    starVersion = starJson.nodeVersion;
  }
} catch (e) {
  // empty
}

try {
  textVersion = fs.readFileSync(textPath).toString('utf8').slice(1).trim();
} catch (e) {
  // empty
}

log('starVersion: ', starVersion);
log('textVersion: ' + textVersion);

nodeVersion = process.env.NODE_VERSION || starVersion || textVersion;

if (!wantExact) {
  // Find a version already installed with the same major version
  var majorVersion = nodeVersion.split('.')[0];
  if (majorVersion[0] === 'v') {
    majorVersion = majorVersion.slice(1);
  }
  log('majorVersion: ' + majorVersion);
  
  for (var i = 0; i < installedVersions.length; i++) {
    if (installedVersions[i].node.split('.')[0] === majorVersion) {
      nodeVersion = installedVersions[i].node;
      log('found major version: ' + nodeVersion);
      break;
    }
  }
}

// eslint-disable-next-line
console.log(nodeVersion);
logFinish('finished: ' + nodeVersion);
