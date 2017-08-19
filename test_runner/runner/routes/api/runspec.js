var express = require('express');
var router = express.Router();
var child_process = require('child_process');
var runnerConfig = require('../../modules/runnerconfig');

const configFile = 'config/slackerRunner.yml';
var config = runnerConfig.getConfig(configFile)

router.get('/:folder/:spec', function (req, res, next) {
  var specPath = config.specs.specFolder + '/';
  specPath += req.params.folder + '/' + req.params.spec;
  child_process.execFile('slacker', ['-fd', specPath], { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      res.type('application/json');
      res.send(testResult);
    }
    else {
      res.status('500').send(err.message);
    }
  });
});

router.get('/:spec', function (req, res, next) {
  var specPath = config.specs.specFolder + '/';
  specPath += req.params.spec;
  child_process.execFile('slacker', ['-fd', specPath], { cwd: config.specs.rootFolder }, function (err, testResult) {
    if (!err) {
      //res.type('application/json')
      res.write(testResult);
      res.end();
    }
    else {
      res.type('application/json')
      res.status('500').send(err.message);
    }
  });
});

router.get('/', function (req, res, next) {
  res.send('enter spec file name');
});


module.exports = router;
