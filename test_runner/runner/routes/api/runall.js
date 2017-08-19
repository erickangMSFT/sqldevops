var express = require('express');
var router = express.Router();
var child_process = require('child_process');
var runnerConfig = require('../../modules/runnerconfig');

const configFile = 'config/slackerRunner.yml';
var config = runnerConfig.getConfig(configFile)

router.get('/', function (req, res, next) {
  child_process.exec('slacker -fd ./spec/**/*', { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      res.type('application/json');
      res.send(testResult);
    }
    else{
      res.status('500').send(err.message)
    }
  });
});


module.exports = router;
