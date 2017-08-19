var express = require('express');
var router = express.Router();
var child_process = require('child_process');
var formatter = require('../../modules/resultformatter.js');
var runnerConfig = require('../../modules/runnerconfig');

const configFile = 'config/slackerRunner.yml';
var config = runnerConfig.getConfig(configFile)

router.get('/:format/:folder/:spec', function (req, res, next) {
  var specPath = config.specs.specFolder + '/';
  specPath += req.params.folder + '/' + req.params.spec;
  var format = formatter.getFormatArgument(req.params.format);
  child_process.execFile('slacker', [format.arg, specPath], { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      res.type(format.type);
      res.send(testResult);
    }
    else {
      res.status('500').send(err.message);
    }
  });
});

router.get('/:format/:spec', function (req, res, next) {
  var specPath = config.specs.specFolder + '/';
  specPath += req.params.spec;
  var format = formatter.getFormatArgument(req.params.format);
  child_process.execFile('slacker', [format.arg, specPath], { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      res.type(format.type)
      res.send(testResult);
    }
    else {
      //res.type('application/json')
      res.status('500').send(err.message);
    }
  });
});

router.get('/', function (req, res, next) {
  res.send('enter spec file name');
});


module.exports = router;
