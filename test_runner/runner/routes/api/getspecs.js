var express = require('express');
var router = express.Router();
var child_process = require('child_process');
var formatter = require('../../modules/resultformatter.js');


/* GET home page. */
router.get('/', function (req, res, next) {
  var path = "."
  child_process.exec('ls -R */*.rb *.rb', { cwd: '/opt/var/slacker_runner/test/spec' }, function (err, specList) {
    if (!err) {
      var result = formatter.formatSpecList(specList);
      res.type('application/json');
      res.send(result);
    }
    else {
      res.status('500').send(err);
    }
  });
});

module.exports = router;
