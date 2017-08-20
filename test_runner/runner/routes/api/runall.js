var express = require('express');
var router = express.Router();
var child_process = require('child_process');
var formatter = require('../../modules/resultformatter.js');
var runnerConfig = require('../../modules/runnerconfig');

const configFile = 'config/slackerRunner.yml';
var config = runnerConfig.getConfig(configFile)

router.get('/', function (req, res, next) {
  child_process.exec('slacker -fh ./spec/**/*', { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      res.type('html');
      res.send(testResult);
    }
    else{
      res.status('500').send(err.message)
    }
  });
});

router.get('/:format', function (req, res, next) {
  var format = formatter.getFormatArgument(req.params.format);
  var command = 'slacker ' + format.arg + ' ./spec/**/*'
  child_process.exec(command, { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      res.type(format.type);
      res.send(testResult);
    }
    else{
      res.status('500').send(err.message)
    }
  });
});


module.exports = router;
