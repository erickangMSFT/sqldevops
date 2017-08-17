var express = require('express');
var router = express.Router();
var child_process = require('child_process');

/* GET home page. */
router.get('/', function (req, res, next) {
  var path = "."

    child_process.exec('slacker ./spec/*/*',{cwd: '/opt/var/slacker_runner/test'}, function (err, testResult) {
      if (err)
        console.log(err);
      else
        console.log(testResult);
      res.render('index', {
        title: 'Slacker test result',
        results: testResult
      });
    });
  });


module.exports = router;
