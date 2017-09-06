// 'use strict';

// const express = require('express');
// const router = express.Router();
// const mssql = require('mssql');

// /* GET home page. */
// router.get('/', (req, res, next)=> {
    //   const ps = new mssql.PreparedStatement();
//   ps.input('id', mssql.Int);
//   ps.prepare('myquery where id = @id', (err)=>{
//     ps.execute({id:req.params.id}, (err,rec)=>{
//       res.render('index', {
//         title: 'Express',
//         tablespaces: rec.recordset
//       });
//     });
//   });

// });
// module.exports = router;
