var express = require('express');
var router = express.Router();
var child_process = require('child_process');


router.get('/:folder/:spec', function (req, res, next) {
  var specPath = 'spec/';
  specPath += req.params.folder + '/' + req.params.spec;
  console.log(req.params.folder);
  console.log(req.params.spec);
  console.log(specPath);
  child_process.execFile('slacker', ['-fd', specPath], { cwd: '/opt/var/slacker_runner/test' }, function (err, testResult) {
    if (!err) {
      console.log(testResult);
      res.writeHead(200, { "Content-Type": "text/utf-8" });
      res.write(testResult);
      res.end();
    }
    else {
      console.log(err);
      res.status('500').send(err.message);
    }
  });
});

router.get('/:spec', function (req, res, next) {
  var specPath = 'spec/'; 
  specPath += req.params.spec;
  console.log(req.params.folder);
  console.log(req.param.spec);
  console.log(specPath);
  child_process.execFile('slacker', ['-fd', specPath], { cwd: '/opt/var/slacker_runner/test' }, function (err, testResult) {
    if (!err) {
      console.log(testResult);
      res.writeHead(200, { "Content-Type": "text/utf-8" });
      res.write(testResult);
      res.end();
    }
    else {
      console.log(err);
      res.status('500').send(err.message);
    }
  });
});

router.get('/', function (req, res, next) {
  res.send('enter spec file name');
});


module.exports = router;
