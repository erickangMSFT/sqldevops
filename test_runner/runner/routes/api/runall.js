var express = require('express');
var router = express.Router();
var child_process = require('child_process');
var runnerConfig = require('../../modules/runnerconfig');

const configFile = 'config/slackerRunner.yml';
var config = runnerConfig.getConfig(configFile)
console.log(config);
/* GET home page. */
router.get('/', function (req, res, next) {
  var specs = config.specs.specFolder + '/*/*';
  console.log(specs);
  child_process.execFile('slacker', ['-fd', specs], { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      res.writeHead(200, { "Content-Type": "text/utf-8" });
      res.write(testResult);
      res.end();
    }
    else{
      res.write(err);
      res.end();
    }
  });
});


module.exports = router;
