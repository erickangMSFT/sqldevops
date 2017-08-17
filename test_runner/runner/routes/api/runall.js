var express = require('express');
var router = express.Router();
var child_process = require('child_process');

/* GET home page. */
router.get('/', function (req, res, next) {
  child_process.exec('slacker -fd ./spec/*/*', { cwd: '/opt/var/slacker_runner/test' }, function (err, testResult) {
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
