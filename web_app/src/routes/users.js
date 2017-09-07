// ------------------------------------------------------------------------//
// Description: Demo application source code
// Repository: https://github.com/erickangMSFT
// Author: Eric Kang
// License: MIT
// ------------------------------------------------------------------------//

'use strict';

const express = require('express');
const router = express.Router();
const mssql = require('mssql');
const fs = require('fs');

const sqldevops = require('../modules/sqldevops.js');

const sqlFile = './src/sql/users.sql';
const dbconfig = require('../config/dbconfig.json');
const nav = require('../config/navconfig.json');

const viewName = 'users';
const title = 'Database Users';

const pool = mssql.globalConnectionPool;

/* GET directory page. */
router.get('/', (req, res, next) => {
    fs.readFile(sqlFile, 'utf8', (err, script) => {
        const request = new mssql.Request(pool);
        request.query(script, (err, rec) => {
            if (err) {
                const sqlerror = sqldevops.getSqlError(err);
                res.render('error', {
                    message: sqlerror.message,
                    error: sqlerror
                });
            }
            else {
                // for debugging
                // console.log(rec.recordset);
                res.render(viewName, {
                    title: title,
                    users: rec.recordset,
                    nav: nav,
                    server: dbconfig.server,
                    database: dbconfig.database,
                    user: dbconfig.user
                });
            }
        });
    });
});
module.exports = router;