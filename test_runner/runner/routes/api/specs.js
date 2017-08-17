var express = require('express');
var router = express.Router();
var child_process = require('child_process');

/* GET home page. */
router.get('/', function (req, res, next) {
  var path = "."
  child_process.exec('ls -R */*.rb *.rb', { cwd: '/opt/var/slacker_runner/test/spec' }, function (err, specList) {
    if (!err) {
      res.writeHead(200, { "Content-Type": "application/json; charset=utf-8" });
      var index = specList.indexOf('\n');
      var last = 0;
      var specId = 1;

      //format specList to json
      res.write('[');
      while (index > -1) {
        var spec = specList.substring(last, index);
        last = index + 1;
        index = specList.indexOf('\n', last);
        res.write('{ "id": '+ specId + ',"specFile": "' + spec)
        if (index < 1)
          res.write('" }');
        else 
          res.write('" },')
        specId += 1;
      }
      res.write(']')
      res.end();
    }
    else {
      res.write(err);
      res.end();
    }
  });
});

module.exports = router;
