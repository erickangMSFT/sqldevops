var express = require('express');
var router = express.Router();
var marked = require('marked');
var fs  = require('fs');

marked.setOptions({
  renderer: new marked.Renderer(),
  gfm: true,
  tables: true,
  breaks: false,
  pedantic: false,
  sanitize: true,
  smartLists: true,
  smartypants: false
});


/* GET home page. */
router.get('/', function (req, res, next) {
  mdFile = './views/docs/index.md';
  mdtext = marked((fs.readFileSync(mdFile, 'utf8')));
  res.render('index', {md: mdtext});
});


module.exports = router;
