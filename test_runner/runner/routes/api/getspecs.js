var express = require('express');
var router = express.Router();
var child_process = require('child_process');
var formatter = require('../../modules/resultformatter.js');
var runnerConfig = require('../../modules/runnerconfig');

const configFile = 'config/slackerRunner.yml';
var config = runnerConfig.getConfig(configFile)

/* GET home page. */
router.get('/', function (req, res, next) {
  child_process.exec('ls -R */*.rb *.rb', { cwd: config.specs.specFolder }, function (err, specList) {
    if (!err) {
      var result = formatter.formatSpecList(specList);
      res.type('application/json');
      res.send(result);
    }
    else {
      err.status = '500';
      res.render('error',{message: err.message,error: err});
    }
  });
});

module.exports = router;
