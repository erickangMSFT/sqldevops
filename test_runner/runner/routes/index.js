var express = require('express');
var router = express.Router();
var child_process = require('child_process');


/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index');
});


module.exports = router;
