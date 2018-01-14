var versions = require('./versions.json');
var { spawnSync, execSync } = require('child_process');

var nvm = '. "$NVM_DIR/nvm.sh" && nvm';

process.env.PATH += ':/home/app/.nvm'

console.log('\nInstalling node versions');

function log({ output }) {
  if (output) {
    console.log(output.toString());
  }
}

for (var i = 0; i < versions.length; i++) {
  var version = versions[i];

  var output = spawnSync(nvm, ['install', version.node], {
    stdio: 'pipe',
    shell: true
  });
  log(output);

  var useOutput = spawnSync(nvm, ['use', version.node], {
    stdio: 'pipe',
    shell: true
  });
  log(useOutput);

  if (version.npm !== 'default') {
    var npmOutput = execSync(`${nvm} use ${version.node} && npm install --global npm@${version.npm}`, {
      stdio: 'pipe'
    });
    log(npmOutput);
  }

  console.log(`\n Finished installing ${version.node}\n`)
}
