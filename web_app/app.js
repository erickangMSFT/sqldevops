// ------------------------------------------------------------------------//
// Description: Demo application source code
// Repository: https://github.com/erickangMSFT
// Author: Eric Kang
// License: MIT
// ------------------------------------------------------------------------//

'use strict';

const express = require('express');
const path = require('path');
const favicon = require('serve-favicon');
const logger = require('morgan');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');

//database
const mssql = require('mssql');
const dbconfig = require('./src/config/dbconfig.json');
const pool = new mssql.ConnectionPool(dbconfig);
mssql.globalConnectionPool = pool;
//open database connection
pool.connect((err)=>{
  if (err){
    console.log('connection failed to server:' + dbconfig.server + ' database:' + dbconfig.database);
    console.log(err);
  }
  else {
    console.log ('Connected to ' + dbconfig.server 
                    + '/' + dbconfig.database 
                    + ' (' + dbconfig.user + ')');
    const request = new mssql.Request(pool);
    request.query('select @@version',(err,rec)=>{
      console.log(JSON.stringify(rec.recordset, null, 0)
        .replace('[{"":"', '')
        .replace('"}]','')
      );
    });
  }    
});

//routes
const index = require('./src/routes/index');
const users = require('./src/routes/users');
const directory = require('./src/routes/directory');
const queryperf = require('./src/routes/queryperf');
const tablespacedetail = require('./src/routes/tablespacedetail');
const servermemorybydb = require('./src/routes/servermemorybydb');
const backuphistory = require('./src/routes/backuphistory');
const dbsize = require('./src/routes/dbsize');

const app = express();

// view engine setup
app.set('views', './src/views');
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
// app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

//map routes and views
app.use('/', index);
app.use('/users', users);
app.use('/directory', directory);
app.use('/queryperf', queryperf);
app.use('/tablespacedetail', tablespacedetail);
app.use('/servermemorybydb', servermemorybydb);
app.use('/backuphistory', backuphistory);
app.use('/dbsize', dbsize);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  const err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
