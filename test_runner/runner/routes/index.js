var express = require('express');
var router = express.Router();
var child_process = require('child_process');

/* GET home page. */
router.get('/', function (req, res, next) {
  var path = "."
  res.writeHead(200, { "Content-Type": "text/utf-8"});
  child_process.exec('slacker -fd ./spec/*/*', { cwd: '/opt/var/slacker_runner/test' }, function (err, testResult) {
    if (err)
      console.log(err);
    else
      console.log(testResult);
    res.write(testResult);
    res.end();
  });
});


module.exports = router;
