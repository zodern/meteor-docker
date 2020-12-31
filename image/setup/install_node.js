var versions = require('./versions.json');
var { spawnSync, execSync } = require('child_process');
var fs = require('fs');

var nvm = '. "$NVM_DIR/nvm.sh" && nvm';

process.env.PATH += ':/home/app/.nvm';
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

  if (version.npm === (versions[i - 1] ? versions[i - 1].npm : '')) {
    console.log('symlinking duplicate npm version');
    const prevVersion = versions[i - 1];

    // This is only correct when version.node is 0.10.x since nvm stores
    // newer versions in a different location
    const targetPath = `/home/app/.nvm/v${version.node}/lib/node_modules/npm`;
    execSync(`rm -rf ${targetPath}`);
    fs.symlinkSync(
      `/home/app/.nvm/versions/node/v${prevVersion.node}/lib/node_modules/npm`,
      targetPath
    );
  } else if (version.npm !== 'default') {
    var npmOutput = execSync(`${nvm} use ${version.node} && npm install --global npm@${version.npm}`, {
      stdio: 'pipe'
    });
    log(npmOutput);
  }

  console.log(`\n Finished installing ${version.node}\n`);
}
